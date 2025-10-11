import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import { WebSocketProvider } from './contexts/WebSocketContext';
import Login from './components/Login';
import Register from './components/Register';
import Chat from './components/Chat';

const App = () => (
  <AuthProvider>
    <WebSocketProvider>
      <Router>
        <Routes>
          <Route path="/login" element={<Login />} />
          <Route path="/register" element={<Register />} />
          <Route path="/chat" element={<Chat />} />
          <Route path="/" element={<Login />} />
        </Routes>
      </Router>
    </WebSocketProvider>
  </AuthProvider>
);

export default App;
