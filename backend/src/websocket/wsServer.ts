import { Server } from 'ws';
import jwt from 'jsonwebtoken';
import { Server as HttpServer } from 'http';
import url from 'url';
import dotenv from 'dotenv';

dotenv.config();
const JWT_SECRET = process.env.JWT_SECRET!;

export const setupWebSocket = (server: HttpServer) => {
  const wss = new Server({ server });

  wss.on('connection', (ws, req) => {
    
    const query = url.parse(req.url || '', true).query;
    const token = query.token as string;

    if (!token) {
      ws.close(1008, 'No token provided');
      return;
    }

    try {
      const decoded = jwt.verify(token, JWT_SECRET) as { userId: string };
      console.log(`User ${decoded.userId} connected via WebSocket`);

      // messages
      ws.on('message', (message: string) => {
        console.log(`Received: ${message}`);
        ws.send(`Echo: ${message}`);
      });

      ws.on('close', () => {
        console.log(`User ${decoded.userId} disconnected`);
      });
    } catch (error) {
      ws.close(1008, 'Invalid token');
    }
  });

  return wss;
};
