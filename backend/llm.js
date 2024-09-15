// import fetch from 'node-fetch';
// import dotenv from 'dotenv';

// // Load environment variables from .env file
// dotenv.config();

// export async function queryLLM(message) {
//   try {
//     const schema = `
//     CREATE TABLE customers (
//   customer_id INT AUTO_INCREMENT PRIMARY KEY,
//   first_name VARCHAR(255) NOT NULL,
//   last_name VARCHAR(255) NOT NULL,
//   email VARCHAR(255) NOT NULL UNIQUE,
//   phone VARCHAR(20),
//   address VARCHAR(255),
//   city VARCHAR(100),
//   state VARCHAR(100),
//   postal_code VARCHAR(20),
//   country VARCHAR(100)
// );`
//     const response = await fetch('https://esm.run/@google/generative-ai', {
//       method: 'POST',
//       headers: {
//         'Authorization': `Bearer ${process.env.LLM_API_KEY}`,
//         'Content-Type': 'application/json',
//       },
//       body: JSON.stringify({ inputs: schema+message+"Give a sql query"}),
//     });
     
    
//     if (!response.ok) {
//       console.log("..");
//       throw new Error(`HTTP error! Status: ${response.status}`); 
//     }

//     const data = await response.json();

//     if (data.error) {
//       throw new Error(`API error: ${data.error}`);
//     }

//     return data[0].generated_text || 'I could not understand your question.';
//   } catch (error) {
//     console.error('Error querying LLM:', error);
//     return 'An error occurred while processing your request.';
//   }
// }

import dotenv from 'dotenv';
import { GoogleGenerativeAI } from "@google/generative-ai";

// Load environment variables from .env file
dotenv.config();

// Initialize Google Generative AI with your API key
const genAI = new GoogleGenerativeAI(process.env.LLM_API_KEY);
const model = genAI.getGenerativeModel({ model: "gemini-1.5-flash" });

export async function queryLLM(message) {
  try {
    const schema1 = `
    CREATE TABLE Customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    Address TEXT,
    City VARCHAR(50),
    State VARCHAR(50),
    ZipCode VARCHAR(10)
);`;

    const schema2 = `CREATE TABLE Products (
    ProductID INT AUTO_INCREMENT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10, 2),
    StockQuantity INT
);`;

const schema3 = `
CREATE TABLE Sales (
    SaleID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    SaleDate DATE,
    TotalAmount DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);`;

const schema4 = `CREATE TABLE Sales_Products (
    SaleID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    PRIMARY KEY (SaleID, ProductID)
);`;

const schema5 = `CREATE TABLE Queries (
    QueryID INT AUTO_INCREMENT PRIMARY KEY,
    CustomerID INT,
    QueryDate DATE,
    QueryText TEXT,
    ResponseText TEXT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);`;



    const prompt = schema1 + schema2 + schema3 + schema4 + schema5 + message + " Generate only a SQL query based on this schema,without any extra information.If the invalid query is given,give as 'Invalid Query'";

    // Use the Gemini API to process the prompt
    const result = await model.generateContent(prompt);
    console.log(result.response.text());

    
    // Check if the result contains a response
    if (result && result.response && result.response.text()) {
      
      return result.response.text().replace(/```/g, '').replace(/\n/g, ' ').replace('sql','');
      
    }
    return 'I could not understand your question.';
  } catch (error) {
    console.error('Error querying LLM:', error);
    return 'An error occurred while processing your request.';
  }
}



