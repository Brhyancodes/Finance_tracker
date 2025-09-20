// src/stores/useAuthStore.ts
import {create} from 'zustand';
import { supabase } from '../lib/supabase';
import { AuthState } from '../types/auth';
import { Session, User } from '@supabase/supabase-js';

export const useAuthStore = create<AuthState>((set) => ({
  session: null,
  user: null,
  loading: true,
  getSession: async () => {
    const { data: { session }, error } = await supabase.auth.getSession();
    if (error) {
      console.error('Error getting session:', error.message);
      set({ loading: false });
      return;
    }
    set({ session, user: session?.user ?? null, loading: false });
  },
  signInWithPassword: async (email, password) => {
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) {
      console.error('Error signing in:', error.message);
    }
  },
  signOut: async () => {
    const { error } = await supabase.auth.signOut();
    if (error) {
      console.error('Error signing out:', error.message);
    } else {
      set({ session: null, user: null });
    }
  },
}));
