# AI-Powered Customer Support Agent

An AI-powered customer support agent built with **Python, LangChain, LangGraph, and SQL Server** to help customers obtain information about company policies, orders, refunds, and product availability.

The system combines knowledge-base retrieval, database-backed tools, runtime customer context, and human-in-the-loop approval to support customer service workflows.

## Project Overview

Customer support teams frequently handle repetitive questions about shipping, returns, refunds, warranties, product availability, and order status.

Traditional support workflows may require agents to search through policy documents and customer databases manually. This project explores how an AI agent can combine document retrieval and structured database queries to provide more efficient and context-aware support.

The agent uses a language model to interpret customer questions, select appropriate tools, retrieve relevant information, and respond using available business data and policies.

## Business Problem

Customer support operations need a consistent way to answer policy questions and retrieve account-specific information while protecting customer data and maintaining appropriate oversight of sensitive actions.

This project addresses the following questions:

* How can an AI agent answer questions using company policies?
* How can it retrieve order information from a relational database?
* How can refund eligibility be checked against business rules?
* How can product availability be retrieved from structured data?
* How can sensitive actions be routed through human approval?
* How can customer-specific information be restricted to the authenticated customer?

## Project Objectives

1. Build an AI-powered customer support agent.
2. Retrieve relevant information from company knowledge-base documents.
3. Connect the agent to a SQL Server database.
4. Provide tools for order lookup, customer order history, spending information, and product stock queries.
5. Check refund eligibility before proceeding with refund requests.
6. Integrate human-in-the-loop approval for designated sensitive actions.
7. Use LangGraph to manage agent execution and runtime context.
8. Prepare the agent for deployment and integration with a customer-facing application.

## Technology Stack

| Technology                   | Purpose                                                              |
| ---------------------------- | -------------------------------------------------------------------- |
| Python                       | Application development                                              |
| LangChain                    | Agent and tool integration                                           |
| LangGraph                    | Agent execution and orchestration                                    |
| LangGraph Studio             | Visual testing and debugging                                         |
| OpenAI model                 | Natural-language understanding and response generation               |
| SQL Server                   | Structured customer, order, and product data                         |
| SQLAlchemy / database driver | Database connectivity, if used by the implementation                 |
| Vector store and embeddings  | Knowledge-base retrieval, depending on the configured implementation |
| LangSmith                    | Agent observability and deployment                                   |

## Key Features

### 1. Knowledge-Base Question Answering (RAG)

The agent retrieves information from company documents, including:

* Company FAQs
* Shipping policy
* Return policy
* Refund policy
* Discount policy
* Warranty policy
* Product catalogue

The knowledge base helps the agent answer questions using the available business documentation.

### 2. Order Information Retrieval

The agent can use database tools to retrieve order information, such as order status and order totals, subject to customer ownership checks.

### 3. Customer Order History

Customer-specific tools support retrieval of order history and other account information.

### 4. Refund Eligibility

The agent can check whether an order meets the configured refund criteria before proceeding with a refund workflow.

### 5. Human-in-the-Loop Approval

Refund requests can be configured to require human approval before the sensitive action proceeds.

### 6. Product Stock Lookup

The agent can retrieve product availability from the connected database.

### 7. Runtime Customer Context

The application uses a `SupportContext` structure to provide customer-related information to the agent and its tools.

For a production implementation, the customer identity must come from a verified authentication session. A customer ID supplied directly in a chat message must not be treated as proof of identity.

## System Architecture

The system follows this general workflow:

1. A customer submits a question through the available interface.
2. The application supplies the authenticated customer's runtime context.
3. The LangGraph agent interprets the request.
4. The agent selects an appropriate tool or knowledge-retrieval workflow.
5. The selected tool retrieves relevant policy or database information.
6. Sensitive operations follow the configured approval process.
7. The agent generates a response using the available results.

```text
Customer
   |
   v
Application / Authentication
   |
   v
LangGraph Agent
   |
   +--------------------------+
   |                          |
   v                          v
Knowledge-Base Retrieval   SQL Server Tools
   |                          |
   v                          v
Company Policies          Customer / Order /
                          Refund / Product Data
   |                          |
   +-------------+------------+
                 |
                 v
        Agent Response
                 |
                 v
              Customer
```

Human approval is incorporated into the designated sensitive-action workflow.

## Available Tools

The implementation includes tools for the following operations:

| Tool                       | Purpose                                   |
| -------------------------- | ----------------------------------------- |
| `search_faq`               | Search company knowledge-base information |
| `get_order_details`        | Retrieve details of a customer's order    |
| `list_customer_orders`     | Retrieve the customer's order history     |
| `get_customer_spending`    | Retrieve customer spending information    |
| `check_refund_eligibility` | Check refund eligibility                  |
| `request_refund`           | Initiate the configured refund workflow   |
| `check_product_stock`      | Check product availability                |

Tool names and behaviour should match the final implementation in `customer_support.py`.

## Project Structure

```text
customer-support-agent/
├── customer_support.py
├── langgraph.json
├── requirements.txt
├── .env.example
├── .gitignore
├── README.md
├── documents/
│   ├── company_faq.md
│   ├── shipping_policy.md
│   ├── return_policy.md
│   ├── refund_policy.md
│   ├── discount_policy.md
│   ├── warranty_policy.md
│   └── product_catalog.md
└── database/
    └── database setup scripts, if included
```

This structure is illustrative. The repository should reflect the actual files included in the project.

## Installation and Local Setup

### Prerequisites

* Python version compatible with the project's dependencies
* Git
* Access to the configured language model
* SQL Server configured with the required tables
* Required API credentials
* LangGraph CLI

### 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/langgraph-customer-support-agent.git
cd langgraph-customer-support-agent
```

Replace `kolex24` with the repository owner's GitHub username.

### 2. Create a virtual environment

Windows PowerShell:

```powershell
python -m venv .venv
.\.venv\Scripts\Activate.ps1
```

### 3. Install dependencies

```bash
python -m pip install --upgrade pip
pip install -r requirements.txt
```

### 4. Configure environment variables

Create a local `.env` file using `.env.example` as a reference.

Set the required model API key, database connection settings, and other variables expected by the application.

Never commit real credentials or customer data.

### 5. Configure the database

Ensure SQL Server is running and contains the tables expected by the application.

Configure the database connection using the environment variables expected by `customer_support.py`.

### 6. Start LangGraph locally

```bash
langgraph dev
```

Open the Studio URL printed in the terminal and test the agent.

## Security Considerations

* Customer identities must come from verified authentication.
* Customer-specific database queries must enforce record ownership.
* The agent must not disclose another customer's information.
* API keys and database credentials must be stored securely.
* Sensitive actions must follow the configured approval workflow.
* Production database access must use appropriate network restrictions and least-privilege credentials.
* Real customer data and database backups must not be committed to the repository.

## Testing

The agent should be tested against the following scenarios:

* Frequently asked questions
* Shipping and return policy questions
* Order lookup
* Customer order history
* Customer spending queries
* Refund eligibility checks
* Refund approval workflow
* Product stock lookup
* Missing customer context
* Attempts to access another customer's records
* Database connection failures
* Missing environment variables

Record the actual results of your tests before describing the project as production-ready.

## Deployment

The project is designed for local testing with LangGraph Studio and can be prepared for deployment through LangSmith.

A cloud deployment requires:

* A valid LangGraph configuration
* All required dependencies
* Correct environment variables and secrets
* A database that the deployed application can securely reach
* Appropriate customer authentication and authorization

Deployment status and the API endpoint should be documented here after successful deployment.

## Future Improvements

Potential improvements include:

* Customer-facing web interface
* Secure login and session management
* Persistent conversation history
* Additional support analytics
* Improved error handling and monitoring
* Automated integration tests
* Evaluation of answer quality and tool-selection accuracy
* Production deployment with managed database connectivity

## Agent Architecture

The diagram below illustrates the workflow of the customer support agent.

![LangGraph Customer Support Agent Architecture]( <img width="479" height="233" alt="image" src="https://github.com/user-attachments/assets/b36693c0-4932-4f00-b398-5566a13a0b4a" />)


## Author

**Lukmon Khalid Gbolahan**

Data Analytics | Python | SQL | LangChain | LangGraph

GitHub: https://github.com/kolex24

## Disclaimer

This project is intended as a demonstration of an AI-powered customer support workflow. Production use requires appropriate authentication, authorization, privacy controls, testing, monitoring, and secure infrastructure.
