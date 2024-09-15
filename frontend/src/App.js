import React, { useState, useEffect, useRef } from 'react';
import './App.css';
import BasicTable from './table';

function App() {
  const [messages, setMessages] = useState([]);
  const [input, setInput] = useState('');
  const [isTyping, setIsTyping] = useState(false);
  const [currentSession, setCurrentSession] = useState(null);
  const [sessions, setSessions] = useState([]);
  const messagesEndRef = useRef(null);

  // Function to scroll to the bottom automatically
  const scrollToBottom = () => {
    messagesEndRef.current?.scrollIntoView({ behavior: 'smooth' });
  };

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

  const sendMessage = async () => {
    if (input.trim() === '') return;  // Prevent sending empty messages

    const newMessage = { text: input, user: 'User' };
    setMessages([...messages, newMessage]);
    setInput('');  // Clear input after sending
    setIsTyping(true);  // Show typing indicator

    try {
      const response = await fetch('http://localhost:5000/chat', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ message: input }),
      });

      const data = await response.json();

      const botMessage = { text: data.response, type: data.type, user: 'Chatbot' };
      setMessages((prevMessages) => [...prevMessages, botMessage]);

      // Update sessions with the new chat history
      if (currentSession !== null) {
        const updatedSessions = sessions.map((session, index) =>
          index === currentSession ? [...session, botMessage] : session
        );
        setSessions(updatedSessions);
      }
    } catch (error) {
      console.error('Error fetching response:', error);
      setMessages((prevMessages) => [
        ...prevMessages,
        { text: 'Error: Could not connect to the server.', user: 'Chatbot' },
      ]);
    } finally {
      setIsTyping(false);  // Hide typing indicator
    }
  };

  const handleSessionClick = (index) => {
    setCurrentSession(index);
    setMessages(sessions[index] || []);
  };

  const createNewSession = () => {
    const newSessionIndex = sessions.length;
    setSessions([...sessions, []]);
    setCurrentSession(newSessionIndex);
    setMessages([]);
  };

  return (
    <div className="chat-container">
      <div className="session-list">
        <button onClick={createNewSession}>New Chat</button>
        <ul>
          {sessions.map((session, index) => (
            <li
              key={index}
              className={currentSession === index ? 'active-session' : ''}
              onClick={() => handleSessionClick(index)}
            >
              Chat {index + 1}
            </li>
          ))}
        </ul>
      </div>
      <div className="chat-body">
        <div className="messages">
          {messages.map((msg, index) => (
            <div key={index} className={msg.user === 'User' ? 'user-message' : 'bot-message'}>
              {msg.user === 'User' ? msg.text : (
                <div>
                  {msg.type && msg.type === 1 ? msg.text : <BasicTable customers={msg.text} />}
                </div>
              )}
            </div>
          ))}
          {isTyping && <div className="bot-message typing">Query is processing....</div>}
          <div ref={messagesEndRef} />
        </div>
        <div className="input-container">
          <input
            type="text"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            placeholder="Type your message..."
            disabled={isTyping}  // Disable input while waiting for chatbot response
          />
          <button onClick={sendMessage} disabled={isTyping}>
            {isTyping ? '...' : 'Send'}
          </button>
        </div>
      </div>
    </div>
  );
}

export default App;
