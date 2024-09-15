# Customer Support Chatbot for Retail Analytics

# Project Overview
The Customer Support Chatbot for Retail Analytics helps retail businesses quickly respond to customer queries about sales, inventory, and product information. It combines a user-friendly interface, natural language understanding via an open-source Large Language Model (LLM), and structured data retrieval from a SQL database.

# Features

1. **Frontend**:
   - A responsive and user-friendly web interface.
   - **Chat History**: Displays previous conversations to maintain context.
   - **Typing Indicators**: Shows when the bot is processing a query.
   - **Minimalistic Design**: Focuses on user experience with easy navigation and clear visuals.
   - **Real-time Chat Interface**: Customers can ask questions and receive responses instantly.
   
2. **Backend**:
   - **Request Handling**: Handles user queries and processes data requests.
   - **LLM Communication**: Communicates with the LLM to interpret natural language inputs.
   - **SQL Query Execution**: Fetches relevant sales, product, and inventory data based on user queries.
   - **Error Handling**: Includes error handling, logging, and monitoring for robust operation.

3. **SQL Database**:
   - **Data Storage**: Stores sales, product, and customer query data.
   - **Optimized Retrieval**: Optimized to handle quick data retrieval.

4. **REST API**:
   - **Secure Endpoints**: Provides secure and scalable endpoints for the frontend to query sales data, retrieve chat history, and interact with the LLM.

5. **LLM Integration**:
   - **Open-Source LLM**: Uses an open-source Large Language Model (LLM) Gemini-API.
   - **Natural Language Understanding**: Interprets user inputs, generates responses, and forwards queries to the backend for data retrieval.

## Tech Stack

### Frontend
- **React**: A JavaScript library for building user interfaces.
- **HTML/CSS**: For structuring and styling the web application.
- **JavaScript**: Adds dynamic functionality and interactivity.
- **Material-UI**: Provides UI components and ensures design consistency.

### Backend
- **Node.js**: A JavaScript runtime for building scalable network applications.
- **Express.js**: A web application framework for Node.js that handles server-side logic and routing.

### Database
- **MySQL**: A relational database system for storing and managing customer and sales data.

### Integration with Open-Source LLM
- **Gemini API**: Used for integrating language model capabilities into the application.
 
# Chatbot System Workflow

1. **User Interaction**:
   - **Query Entry**: Users input queries or requests in the chatbot interface on the frontend.

2. **Frontend to Backend**:
   - **Query Transmission**: The frontend sends the user query to the backend using RESTful APIs.

3. **Backend Processing**:
   - **Initial Processing**: The backend receives the query and determines if further interpretation is required.
   - **LLM Communication**: For queries needing interpretation, the backend forwards them to the Large Language Model (LLM).

4. **LLM Query Handling**:
   - **Query Interpretation**: The LLM processes the query, generates a structured request if necessary, and determines if additional data is needed.

5. **LLM to SQL Database**:
   - **Database Query**: If required, the LLM sends a structured query to the SQL database to fetch relevant data.

6. **SQL Database Query**:
   - **Data Retrieval**: The SQL database processes the query, retrieves the relevant information, and returns it to the backend.

7. **Backend Response Handling**:
   - **Response Integration**: The backend integrates the data from the SQL database with the LLM's response, formats it appropriately, and prepares it for sending.

8. **Backend to Frontend**:
   - **Response Transmission**: The backend sends the formatted response back to the frontend via RESTful APIs.

9. **Frontend Display**:
   - **User Display**: The frontend displays the final response to the user, completing the interaction.

This structure outlines the flow from user interaction through to the final display of responses, detailing each component’s role in the system.


# Process Workflow Architecture

![C5I (2)](https://github.com/user-attachments/assets/53181487-4cdd-4122-ae85-844146488f50)


# Database Schema for Retail Support

This provides an overview of the database schema for the `retail_support` database. The schema includes tables for customers, products, sales, sales products, and queries, which are essential for managing customer interactions, sales transactions, and support queries.

### Customers Table

Stores information about customers.

| Column     | Type         | Description                             |
|------------|--------------|-----------------------------------------|
| `CustomerID` | `INT`        | Primary key, auto-incremented ID         |
| `FirstName`  | `VARCHAR(50)`| Customer's first name                    |
| `LastName`   | `VARCHAR(50)`| Customer's last name                     |
| `Email`      | `VARCHAR(100)`| Customer's email address                |
| `Phone`      | `VARCHAR(15)`| Customer's phone number                  |
| `Address`    | `TEXT`       | Customer's address                       |
| `City`       | `VARCHAR(50)`| City of the customer                     |
| `State`      | `VARCHAR(50)`| State of the customer                    |
| `ZipCode`    | `VARCHAR(10)`| ZIP code of the customer                 |

### Products Table

Stores information about products available for sale.

| Column        | Type           | Description                              |
|---------------|----------------|------------------------------------------|
| `ProductID`   | `INT`          | Primary key, auto-incremented ID          |
| `ProductName` | `VARCHAR(100)` | Name of the product                      |
| `Category`    | `VARCHAR(50)`  | Category of the product                  |
| `Price`       | `DECIMAL(10, 2)`| Price of the product                     |
| `StockQuantity`| `INT`         | Quantity of the product in stock         |

### Sales Table

Records sales transactions.

| Column       | Type          | Description                              |
|--------------|---------------|------------------------------------------|
| `SaleID`     | `INT`         | Primary key, auto-incremented ID          |
| `CustomerID` | `INT`         | Foreign key to `Customers.CustomerID`     |
| `SaleDate`   | `DATE`        | Date of the sale                          |
| `TotalAmount`| `DECIMAL(10, 2)`| Total amount of the sale                 |

### Sales_Products Table

Associates products with sales.

| Column      | Type       | Description                                  |
|-------------|------------|----------------------------------------------|
| `SaleID`    | `INT`      | Foreign key to `Sales.SaleID`                 |
| `ProductID` | `INT`      | Foreign key to `Products.ProductID`           |
| `Quantity`  | `INT`      | Quantity of the product sold                 |
| Primary Key  | (`SaleID`, `ProductID`) | Composite primary key              |

### Queries Table

Stores customer queries and their responses.

| Column        | Type         | Description                               |
|---------------|--------------|-------------------------------------------|
| `QueryID`     | `INT`        | Primary key, auto-incremented ID           |
| `CustomerID`  | `INT`        | Foreign key to `Customers.CustomerID`      |
| `QueryDate`   | `DATE`       | Date of the query                         |
| `QueryText`   | `TEXT`       | Text of the query                         |
| `ResponseText`| `TEXT`       | Response to the query                     |

# API Endpoints

## 1. POST /chat

**Functionality:**

- **Purpose:** This endpoint is used for handling chat messages sent from the frontend and generating responses based on the message content.

- **Workflow:**
  1. **Receive Message:** Receives a `POST` request with a `message` in the request body.
  2. **Process Message with LLM:** Sends the message to the Google Generative AI (LLM) to generate a SQL query or response.
  3. **Validate Query:** Checks the response from the LLM for validity. If the response contains a valid SQL query, it is executed against the database.
  4. **Execute SQL Query:** Sends the SQL query to the database via the `queryDatabase` function to fetch or manipulate data.
  5. **Respond to Frontend:** Sends the result from the database query or an error message back to the frontend as the response to the chat message.

- **Usage in the Project:**

  This endpoint is crucial for handling user input in the chatbot and interacting with the database based on user queries. It integrates natural language processing and SQL query execution to provide meaningful responses.

## 2. GET /query

**Functionality:**

- **Purpose:** This endpoint is used for executing raw SQL queries provided as query parameters and returning the results.

- **Workflow:**
  1. **Receive Query:** Receives a `GET` request with a SQL query string in the query parameters.
  2. **Execute Query:** Executes the SQL query against the database using the `queryDatabase` function.
  3. **Respond with Results:** Returns the results of the SQL query to the client in JSON format.

- **Usage in the Project:**

  This endpoint allows for direct execution of SQL queries, which can be used for debugging or running specific queries. In this project, it is not directly used by the frontend but can be useful for testing or administrative tasks.

# Version Control Setup

### 1. Clone the Repository
1. **Git Installation**
   -Check whether Git is present or not,if not install it

2. **Clone the Repository**:
   - Open a terminal (or Command Prompt on Windows).
   - Clone the repository with:
     ```sh
     git clone https://github.com/Priyadharshini0113/C5I-ASSIGNMENT.git
     ```

3. **Navigate to the Project Directory**:
   - Change to the project directory using:
     ```sh
     cd C5I-ASSIGNMENT
     ```

### 2. Create and Manage Branches

1. **Create a New Branch**:
   - Create and switch to a new branch with:
     ```sh
     git checkout -b your-branch-name
     ```
   - The `your-branch-name` which is created here are ( frontend , backend , database )

2. **Start Working**:
   - Make your changes or additions in the project files.
   - Use `git status` to check the status of your changes.

3. **Stage and Commit Changes**:
   - Stage your changes using:
     ```sh
     git add .
     ```
   - Commit your changes with a descriptive message:
     ```sh
     git commit -m "Your commit message"
     ```

4. **Push Your Branch to Remote**:
   - Push your branch to the remote repository with:
     ```sh
     git push origin your-branch-name
     ```
  

### 3. Merging Branches

1. **Switch to the Main Branch**:
   - Before merging, switch to the branch you want to merge into, usually `main` or `master`:
     ```sh
     git checkout main
     ```
   - Ensure you have the latest changes from the remote repository:
     ```sh
     git pull origin main
     ```

2. **Merge Your Branch**:
   - Merge the branch you’ve been working on into the main branch:
     ```sh
     git merge your-branch-name
     ```
   - Resolve any merge conflicts if they arise. Git will prompt you with instructions on how to resolve conflicts.

3. **Push the Merged Changes**:
   - After successfully merging, push the updated main branch to the remote repository:
     ```sh
     git push origin main
     ```
# Running the Project

1. **Start the Backend:**

   - Open a terminal and navigate to the `chatbot-backend` directory:
     ```bash
     cd chatbot-backend
     ```
   - Start the backend server:
     ```bash
     npm start
     ```
   - Ensure the backend is running and accessible at [http://localhost:5000](http://localhost:5000).

2. **Start the Frontend:**

   - Open another terminal and navigate to the `chatbot-frontend` directory:
     ```bash
     cd chatbot-frontend
     ```
   - Start the frontend server:
     ```bash
     npm start
     ```
   - The frontend should be running and accessible at [http://localhost:3000](http://localhost:3000).

# LLM Integration: Challenges and Solutions

### LLM Used
- **LLM:** Google Generative AI
- **Model:** gemini-1.5-flash

### Challenges Faced and Solutions Implemented

#### Handling Complex Queries
- **Challenge:** Natural language queries can be highly variable and complex, making it difficult for the LLM to consistently generate valid SQL queries that align with the database schema.
- **Solution:** Define a comprehensive schema and use specific prompts to guide the LLM in generating accurate SQL queries. The schema provides context and constraints, ensuring the queries are relevant to the database structure.

#### Validating Query Output
- **Challenge:** The LLM might generate queries that are either invalid or not executable due to syntax errors or logical issues.
- **Solution:** Implement validation mechanisms to check if the generated SQL query is valid. If the query is invalid or contains errors, provide a clear error message to the user, indicating that the query could not be processed.

#### Handling Ambiguous Queries
- **Challenge:** User queries can be ambiguous or unclear, leading to incorrect or incomplete SQL queries.
- **Solution:** Use specific and structured prompts to minimize ambiguity. Provide feedback mechanisms to inform users if their queries are unclear and request additional details or rephrasing if needed.

#### Managing API Integration
- **Challenge:** Integrating with the Google Generative AI API requires proper configuration and handling of API responses, including managing rate limits and error responses.
- **Solution:** Implement robust error handling and logging to manage API integration issues. Ensure that the API keys and configurations are correctly set up and that the system can handle any issues gracefully.

#### Ensuring Performance and Scalability
- **Challenge:** Real-time query processing might impact performance, especially if the LLM is used frequently or with large volumes of data.
- **Solution:** Optimize the API calls and query handling to ensure efficient processing. Consider implementing caching strategies and load balancing to manage performance and scalability.

By leveraging the `gemini-1.5-flash` model from Google Generative AI and addressing these challenges with targeted solutions, the integration ensures effective handling of natural language queries and reliable generation of SQL queries, enhancing the overall functionality and usability of the chatbot system.

# Results

![Screenshot 2024-09-16 015252](https://github.com/user-attachments/assets/15cd9d3c-40be-4419-972a-335a85b0ac5f)

![Screenshot 2024-09-16 015446](https://github.com/user-attachments/assets/a35dc0c0-1365-4cbd-b2cc-6c3313b368df)

![Screenshot 2024-09-16 015532](https://github.com/user-attachments/assets/85923098-310d-4128-a0c6-9b07233e6c3e)

![Screenshot 2024-09-16 015734](https://github.com/user-attachments/assets/489c280e-80e0-41c3-bdbd-6a14ab983d1b)

![Screenshot 2024-09-16 015748](https://github.com/user-attachments/assets/44619c0a-1f14-4f35-a650-b698449b7be5)

![Screenshot 2024-09-16 022724](https://github.com/user-attachments/assets/f3530100-570b-4918-836a-02babf569ce7)

![Screenshot 2024-09-16 023549](https://github.com/user-attachments/assets/87a69396-0652-494b-a47a-4da135c58169)

![Screenshot 2024-09-16 023733](https://github.com/user-attachments/assets/fbf32049-a5c1-4cf1-adbb-65b38855b368)

# Database Schema
![Screenshot 2024-09-16 023925](https://github.com/user-attachments/assets/08306035-0c41-4a5a-851f-a93cd8c75f61)


