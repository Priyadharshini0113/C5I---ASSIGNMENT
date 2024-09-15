import mysql from 'mysql';

// MySQL database connection
const connection = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'Priya@131', // Ensure you provide the correct password
  database: 'retail_support',
});

// Connect to the database
connection.connect((err) => {
  if (err) {
    console.error('Error connecting to the database:', err.stack);
    return;
  }
  console.log('Connected to the database');
});

/**
 * Execute a database query based on the query type and parameters.
 * @param {string} queryType - The type of query to execute.
 * @param {Array} [params=[]] - Parameters for the SQL query.
 * @returns {Promise} - A promise that resolves with the query results or rejects with an error.
 */
export async function queryDatabase(queryType, params = []) {
  return new Promise((resolve, reject) => {
    let sqlQuery = queryType;

    // Execute the SQL query with parameters
    connection.query(sqlQuery, params, (error, results) => {
      if (error) {
        console.error('Error executing query:', error);
        return reject(error);
      }
      resolve(results); // Resolve with the results directly
    });
  });
}

// Close connection when done
export function closeConnection() {
  connection.end((err) => {
    if (err) {
      console.error('Error closing the connection:', err);
    } else {
      console.log('Database connection closed');
    }
  });
}

