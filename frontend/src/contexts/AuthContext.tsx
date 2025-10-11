import { createContext, useContext, useState, ReactNode } from 'react';
import axios from 'axios';

interface AuthContextType {
  token: string | null;
  login: (username: string, password: string) => Promise<void>;
  register: (username: string, email: string, password: string, bio?: string) => Promise<void>;
  logout: () => void;
}

const AuthContext = createContext<AuthContextType | null>(null);

export const AuthProvider = ({ children }: { children: ReactNode }) => {
  const [token, setToken] = useState<string | null>(localStorage.getItem('token'));

  const login = async (username: string, password: string) => {
    try {
      const res = await axios.post('http://localhost:8080/api/auth/login', { username, password }, { withCredentials: true });
      const { token } = res.data;
      setToken(token);
      localStorage.setItem('token', token);
    } catch (error) {
      console.error('Axios login error:', error);
      throw error;
    }
  };

 const register = async (username: string, email: string, password: string, bio?: string) => {
    await axios.post('http://localhost:8080/api/auth/register', { username, email, password, bio }, { withCredentials: true });
  };

  const logout = () => {
    setToken(null);
    localStorage.removeItem('token');
  };

  return (
    <AuthContext.Provider value={{ token, login, register, logout }}>
      {children}
    </AuthContext.Provider>
  );
};

export const useAuth = () => useContext(AuthContext)!;
