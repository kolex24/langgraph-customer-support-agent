from dotenv import load_dotenv

load_dotenv()

import logging
import urllib

for name in ("httpx", "httpx2", "httpcore", "openai"):
    logging.getLogger(name).setLevel(logging.WARNING)

from dataclasses import dataclass
from langchain.agents import AgentState, create_agent, AgentState
from langchain.tools import tool, ToolRuntime
from langgraph.types import Command
from langchain.messages import ToolMessage
from langchain.agents.middleware import wrap_model_call, dynamic_prompt, HumanInTheLoopMiddleware, SummarizationMiddleware
from langchain.agents.middleware import ModelRequest, ModelResponse
from typing import Callable
from langchain_text_splitters import RecursiveCharacterTextSplitter
from langchain_core.vectorstores import InMemoryVectorStore
from langchain_openai import OpenAIEmbeddings
from langchain_unstructured import UnstructuredLoader
from langchain_community.document_loaders import DirectoryLoader, UnstructuredMarkdownLoader
from pprint import pprint
from langchain.messages import HumanMessage
from langchain_community.utilities import SQLDatabase
from langchain_community.agent_toolkits import SQLDatabaseToolkit
from langchain.agents.middleware import wrap_model_call, ModelRequest, ModelResponse
from typing import Callable
from langchain.agents.middleware import dynamic_prompt
from langgraph.checkpoint.memory import InMemorySaver
from datetime import date, datetime
from sqlalchemy import create_engine, text
from pathlib import Path


#Settings
refund_window_days = 14
trigger_token = 4000

NO_CUSTOMER = "No customer is logged in, so I can't look up account information."
DOCS_DIR = Path(__file__).parent / "documents"

#-----Context and State-------
# Context = who the calling app says is asking (optional, read-only).
@dataclass
class SupportContext:
    customer_id: str = ""
    tier: str = "standard"


# State = what the agent learns during the chat (the verified customer).
# Must be a DIFFERENT class from SupportContext.
class SupportState(AgentState):
    verified_customer_id: str


def ctx_value(runtime, key, default=None):
    """Read a value wether it comes as dict or dataclass"""
    ctx = runtime.context
    if isinstance(ctx, dict):
        return ctx.get(key, default)
    return getattr(ctx, key, default)


def current_customer(runtime):
    """Verified customer identity first, then an ID supplied by the calling app"""
    return runtime.state.get("verified_customer_id") or ctx_value(runtime, "customer_id")


@tool
def verify_customer(customer_id: str, email: str, runtime: ToolRuntime[SupportContext]):
    """Verify the customer's identity using their customer ID and the email address on their account."""
    with engine.connect() as conn:
        row = conn.execute(
            text("SELECT CustomerID FROM Customers "
                 "WHERE CustomerID = :cid AND LOWER(Email) = LOWER(:email)"),
            {"cid": customer_id.strip(), "email": email.strip()},
        ).fetchone()
    if row is None:
        return "Verification failed. The customer ID and email do not match our records."
    return Command(update={
        "verified_customer_id": row[0],
        "messages": [ToolMessage("Customer verified.", tool_call_id=runtime.tool_call_id)],
    })

#------Database-----------
connection_string = urllib.parse.quote_plus(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=DESKTOP-PMLLD8S;"
    "DATABASE=cus_ag;"
    "Trusted_Connection=yes;"
)

engine = create_engine(f"mssql+pyodbc:///?odbc_connect={connection_string}")
db = SQLDatabase(engine)

print(db.get_usable_table_names())

#----Knowledge Base-----

loader = UnstructuredLoader("documents/company_faq.md")

data = loader.load()

print(data)

loader = DirectoryLoader(
    "documents",
    glob="**/*.md",
    loader_cls=UnstructuredMarkdownLoader,
    show_progress=True
)

data = loader.load()
print(f"Loaded {len(data)} documents")

text_splitter = RecursiveCharacterTextSplitter(
    chunk_size=1000,
    chunk_overlap=300,
    add_start_index=True
)

splits = text_splitter.split_documents(data)

print(f"Created {len(splits)} chunks")

embeddings = OpenAIEmbeddings(model="text-embedding-3-small")

vector_store = InMemoryVectorStore.from_documents(
    documents=splits,
    embedding=embeddings
)

for doc in data:
    print(doc.metadata.get("source"))
    
#------FAQ Tools-----
@tool
def search_faq(query: str) -> str:
    """Search business FAQ and policy documents for relevant information."""

    results = vector_store.similarity_search(
        query,
        k=3
    )

    if not results:
        return "No relevant information was found in the business documents."

    formatted_results = []

    for doc in results:
        source = doc.metadata.get("source", "Unknown source")

        formatted_results.append(
            f"Source: {source}\n"
            f"Content:\n{doc.page_content}"
        )

    return "\n\n---\n\n".join(formatted_results)

#------ Order Tool ------
@tool
def get_order_details(order_id: str, runtime: ToolRuntime[SupportContext]) -> str:
    """Get an order's Orderstatus, total and customer from its OrderID."""
    cid = current_customer(runtime)
    if not cid:
        return NO_CUSTOMER
    return db.run(
        "SELECT o.OrderID, o.OrderStatus, o.TotalAmount, c.CustomerID, c.FirstName, c.LastName "
        "FROM Orders o JOIN Customers c ON c.CustomerID = o.CustomerID "
        "WHERE o.OrderID = :oid and o.CustomerID = :cid",
        parameters={"oid": order_id, "cid": cid}
        ) or "No order with that ID was found for this customer."

@tool
def list_customer_orders(runtime: ToolRuntime[SupportContext]) -> str:
    """List all orders (ID, Orderstatus, total) for the current customer."""
    cid = current_customer(runtime)
    if not cid:
        return NO_CUSTOMER
    return db.run("SELECT TOP 20 OrderID, OrderStatus, TotalAmount FROM Orders "
                "WHERE CustomerID = :cid ORDER BY OrderDate DESC",
                parameters={"cid": cid}) or "No orders found."

@tool
def get_customer_spending(runtime: ToolRuntime[SupportContext]) -> str:
    """Number of orders and total amount spent by the current customer."""
    cid = current_customer(runtime)
    if not cid:
        return NO_CUSTOMER
    return db.run(
        "SELECT COUNT(*) AS Orders, COALESCE(SUM(TotalAmount), 0) AS TotalSpent "
        "FROM Orders WHERE CustomerID = :cid",
        parameters={"cid": cid},
    )

@tool
def check_product_stock(product_name: str) -> str:
    """Check the price and stock quantity of products whose name matches the given text."""
    return db.run(
        "SELECT TOP 5 ProductName, Brand, Category, Price, StockQuantity "
        "FROM Products WHERE ProductName LIKE :pn",
        parameters={"pn": f"%{product_name}%"},
    ) or "No matching product found."

#----- Refund Tool ------
import datetime as dt

refund_window_days = 14

def _to_date_(value):
    if isinstance(value, dt.datetime):
        return value.date()
    if isinstance(value, str):
        return dt.date.fromisoformat(value[:10])
    return value

def _check_eligibility_(order_id:str, customer_id:str) -> tuple[bool, str]:
    with engine.connect() as conn:
        order = conn.execute(
            text("SELECT OrderStatus, OrderDate FROM Orders "
                 "WHERE OrderID= :oid AND CustomerID = :cid"),
                 {"oid": order_id, "cid": customer_id}
        ).fetchone()

        if order is None:
            return False, "No order with that ID is found for this customer"

        status, order_date = order
        if status.lower() != "delivered":
            return False, f"This order is '{status}', so it can't be refunded yet."

        existing = conn.execute(
            text("SELECT 1 FROM RefundRequests "
                 "WHERE OrderID = :oid AND Status IN ('Pending', 'Approved')"),
                 {"oid": order_id, "cid": customer_id}
        ).fetchone()

        if existing:
            return False, "A request refund already exists for this order."

        days = (dt.date.today() - _to_date_(order_date)).days

        if days > refund_window_days:
            return False, f"Ordered {days} days ago; the refund window is {refund_window_days} days."
        return True, f"Ordered {days} days ago, within the {refund_window_days}-day window."

@tool
def check_refund_eligibility(order_id:str, runtime: ToolRuntime[SupportContext]):
    """Check whether the current customer's order is eligible for a refund."""
    cid = current_customer(runtime)
    if not cid:
        return NO_CUSTOMER
    eligible, reason = _check_eligibility_(order_id, cid)
    return f"{'ELIGIBLE' if eligible else 'NOT ELIGIBLE'}: {reason}"

@tool
def request_refund(order_id:str, reason: str, runtime: ToolRuntime[SupportContext]):
    """Record a refund request for the current customer's order."""
    customer_id = current_customer(runtime)
    if not customer_id:
        return NO_CUSTOMER
    eligible, why = _check_eligibility_(order_id, customer_id)
    if not eligible:
        return f"Refund request not recorded: {why}"

    with engine.begin() as conn:
        conn.execute(
            text(
                "INSERT INTO RefundRequests (OrderID, CustomerID, Reason, Status, RequestedAt) "
                "VALUES (:oid, :cid, :reason, 'pending', :ts)"),
            {"oid": order_id, "cid": customer_id, "reason": reason, "ts": dt.datetime.now()},
            
        )

    return f"Refund request is recorded for {order_id} and is under review."


#------ Prompt --------
BASE_PROMPT = """You are a customer support assistant for Khalid Electronics, an online electronics store.
- Policy and general questions: use search_faq. If the answer isn't in the retrieved text, say so and offer to pass the customer to a human.
- Order, spending and stock questions: use the database tools and report their actual results. Never guess or calculate from memory.
- Refunds: first call check_refund_eligibility. Only if it says ELIGIBLE and you have the customer's reason, call request_refund. If NOT ELIGIBLE, explain why and offer a human. Never promise a refund or offer exceptions; every request is reviewed by a person.
- If a tool says no customer is logged in, ask for the customer's ID and the email address on their account, then call verify_customer. Never accept an ID alone as proof of identity, and never reveal the email on file.
- For refunds, ask only for the order ID and the reason. Never ask for phone numbers or card details.
- You can only access the logged-in customer's account. If asked about another customer or someone else's order, decline.
- Keep replies to 4 sentences or fewer unless the customer asks for more detail."""

TIER_NOTES = {"standard": "", "vip": "This is a VIP customer; be especially prompt and courteous."}

@dynamic_prompt
def support_prompt(request: ModelRequest) -> str:
    tier = ctx_value(request.runtime, "tier", "standard")
    return BASE_PROMPT + "\n\n" + TIER_NOTES.get(tier, "")

#---- Agent -----

agent = create_agent(
    model="gpt-5-mini",
    tools=[verify_customer, search_faq, get_order_details, check_refund_eligibility, 
           request_refund, list_customer_orders, get_customer_spending, check_product_stock],
    context_schema=SupportContext,
    state_schema=SupportState,
    middleware=[
        support_prompt,
        HumanInTheLoopMiddleware(
            interrupt_on={
                "search_faq": False,
                "get_order_details": False,
                "check_refund_eligibility": False,
                "request_refund": True,
            }
        ),
        SummarizationMiddleware(
            model="gpt-4o-mini",
            trigger=("tokens", trigger_token),
            keep=("messages", 10)
        )
    ],
)