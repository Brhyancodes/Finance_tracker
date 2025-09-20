// src/hooks/useAuth.ts
import { useEffect } from 'react';
import { useAuthStore } from '../stores/useAuthStore';

export const useAuth = () => {
  const { session, user, loading, getSession, signInWithPassword, signOut } = useAuthStore();

  useEffect(() => {
    getSession();
  }, [getSession]);

  return { session, user, loading, signInWithPassword, signOut };
};
