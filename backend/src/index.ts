import express from 'express';
import http from 'http';
import authRoutes from './routes/authRoutes';
import chatRoutes from './routes/chatRoutes';
import { setupWebSocket } from './websocket/wsServer';
import mongoose from 'mongoose';
import dotenv from 'dotenv';
import cors from 'cors';

dotenv.config();
const app = express();
const server = http.createServer(app);

app.use(cors({ origin: 'http://localhost:5173', credentials: true }));
app.use(express.json());
app.use('/api/auth', authRoutes);
app.use('/api/chat', chatRoutes);

mongoose.connect(process.env['MONGODB_URI'] || 'mongodb://localhost:27017/chat-app')
  .then(() => console.log('Connected to MongoDB'))
  .catch((err) => console.error('MongoDB error:', err));

setupWebSocket(server);

const PORT = process.env['PORT'] || 8080;
server.listen(PORT, () => console.log(`Server running on http://localhost:${PORT}`));
