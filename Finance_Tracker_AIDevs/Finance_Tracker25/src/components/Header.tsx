// src/components/Header.tsx
import React from 'react';
import { useAuth } from '../hooks/useAuth';
import { useAuthStore } from '../stores/useAuthStore';

interface HeaderProps {
  title: string;
}

const Header: React.FC<HeaderProps> = ({ title }) => {
  const { user } = useAuth();
  const { signOut } = useAuthStore();

  return (
    <header>
      <h1>{title}</h1>
      {user && (
        <div>
          <span>{user.email}</span>
          <button onClick={signOut}>Sign Out</button>
        </div>
      )}
    </header>
  );
};

export default Header;