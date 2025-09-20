// types/database.ts

// Custom types for enums
export type TransactionType = 'income' | 'expense';
export type BudgetPeriod = 'monthly' | 'weekly';

// Interface for the users table
export interface User {
  id: string; // uuid
  email: string;
  created_at: string; // timestamp
  updated_at: string; // timestamp
  full_name?: string;
  avatar_url?: string;
}

// Interface for the categories table
export interface Category {
  id: string; // uuid
  name: string;
  color?: string;
  icon?: string;
  type: TransactionType;
  user_id?: string; // uuid
  is_default: boolean;
}

// Interface for the transactions table
export interface Transaction {
  id: string; // uuid
  user_id: string; // uuid
  amount: number; // decimal
  description?: string;
  category_id: string; // uuid
  date: string; // date
  created_at: string; // timestamp
  updated_at: string; // timestamp
}

// Interface for the budgets table
export interface Budget {
  id: string; // uuid
  user_id: string; // uuid
  category_id: string; // uuid
  amount: number; // decimal
  period: BudgetPeriod;
  start_date: string; // date
  end_date?: string; // date
}

// Form types for creating/editing records
export type CategoryFormData = Omit<Category, 'id' | 'user_id' | 'is_default'>;
export type TransactionFormData = Omit<Transaction, 'id' | 'user_id' | 'created_at' | 'updated_at'>;
export type BudgetFormData = Omit<Budget, 'id' | 'user_id'>;

// API response types
export interface ApiResponse<T> {
  data: T | null;
  error: Error | null;
}
