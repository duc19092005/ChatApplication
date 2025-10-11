import { createContext, useContext, useEffect, useState } from 'react';
import { useAuth } from './AuthContext';

interface WebSocketContextType {
  ws: WebSocket | null;
  sendMessage: (message: string) => void;
  messages: string[];
}

const WebSocketContext = createContext<WebSocketContextType | null>(null);

export const WebSocketProvider = ({ children }: { children: React.ReactNode }) => {
  const { token } = useAuth();
  const [ws, setWs] = useState<WebSocket | null>(null);
  const [messages, setMessages] = useState<string[]>([]);

  useEffect(() => {
    if (token) {
      const socket = new WebSocket(`ws://localhost:8080?token=${token}`);
      socket.onopen = () => console.log('WebSocket connected');
      socket.onmessage = (event) => setMessages((prev) => [...prev, event.data]);
      socket.onclose = () => console.log('WebSocket closed');
      socket.onerror = (error) => console.error('WebSocket error:', error);
      setWs(socket);
      return () => socket.close();
    }
  }, [token]);

  const sendMessage = (message: string) => {
    if (ws && ws.readyState === WebSocket.OPEN) ws.send(message);
  };

  return (
    <WebSocketContext.Provider value={{ ws, sendMessage, messages }}>
      {children}
    </WebSocketContext.Provider>
  );
};

export const useWebSocket = () => useContext(WebSocketContext)!;
