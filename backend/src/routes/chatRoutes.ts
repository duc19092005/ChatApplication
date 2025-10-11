import express, { Request, Response } from 'express';
import { authMiddleware } from '../middleware/authMiddleware';
import Message from '../models/Message';

const router = express.Router();

// Get all messages
router.get('/messages', authMiddleware, async (_: Request, res: Response) => {
  try {
    const messages = await Message.find().populate('sender', 'username');
    res.json(messages);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

// Send a message
router.post('/messages', authMiddleware, async (req: Request & { user?: { userId: string } }, res: Response) => {
  const { content } = req.body;
  try {
    const message = new Message({ sender: req.user!.userId, content });
    await message.save();
    res.status(201).json(message);
  } catch (error) {
    res.status(500).json({ message: 'Server error' });
  }
});

export default router;
