import express from 'express';
import cors from 'cors';
import bodyParser from 'body-parser';
import { queryDatabase } from './database.js';
import { queryLLM } from './llm.js';

const app = express();
app.use(cors());
app.use(bodyParser.json());

// Chatbot core logic
app.post('/chat', async (req, res) => {
  const { message } = req.body; 
  console.log(message);

  // Send message to LLM for response
  const llmResponse = await queryLLM(message);

  // Simple keyword-based logic for integrating SQL queries
  let finalResponse = llmResponse;
  if (finalResponse.toLowerCase().includes('invalid query')) {
    console.log('Invalid query detected.');
    res.json({ response : 'There seems to be an issue with the query.Please check the details and try again later' , type : 1 } );

  
  } else {
    console.log('Valid query.');
    const dbResponse = await queryDatabase(finalResponse);
   finalResponse = `\n${JSON.stringify(dbResponse, null, 2)}`;
    res.json({ response: finalResponse , type : 0});
    
  }
  console.log(finalResponse);
  // if (message.toLowerCase().includes('customer')) {
  
});

// Extract customer ID from message (simple example, adapt as needed)
function extractCustomerId(message) {
  const match = message.match(/customer id (\d+)/i);
  return match ? parseInt(match[1], 10) : null;
}

// Start server
app.listen(5000, () => {
  console.log('Chatbot backend running on http://localhost:5000');
});


