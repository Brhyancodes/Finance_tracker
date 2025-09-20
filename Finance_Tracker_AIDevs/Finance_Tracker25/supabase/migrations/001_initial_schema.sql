-- supabase/migrations/001_initial_schema.sql

-- Create custom enum types
CREATE TYPE public.transaction_type AS ENUM ('income', 'expense');
CREATE TYPE public.budget_period AS ENUM ('monthly', 'weekly');

-- Users table
CREATE TABLE public.users (
    id uuid NOT NULL DEFAULT auth.uid() PRIMARY KEY,
    email text NOT NULL UNIQUE,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    full_name text,
    avatar_url text
);
COMMENT ON TABLE public.users IS 'Stores user profile information.';

-- Categories table
CREATE TABLE public.categories (
    id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    name text NOT NULL,
    color text,
    icon text,
    type public.transaction_type NOT NULL,
    user_id uuid REFERENCES public.users(id) ON DELETE CASCADE,
    is_default boolean NOT NULL DEFAULT false,
    CONSTRAINT user_category_unique UNIQUE (user_id, name, type)
);
COMMENT ON TABLE public.categories IS 'Stores user-defined and default transaction categories.';
CREATE INDEX idx_categories_user_id ON public.categories(user_id);

-- Transactions table
CREATE TABLE public.transactions (
    id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    amount numeric(10, 2) NOT NULL,
    description text,
    category_id uuid NOT NULL REFERENCES public.categories(id),
    date date NOT NULL,
    created_at timestamp with time zone NOT NULL DEFAULT now(),
    updated_at timestamp with time zone NOT NULL DEFAULT now(),
    CONSTRAINT amount_must_be_positive CHECK (amount > 0)
);
COMMENT ON TABLE public.transactions IS 'Stores individual financial transactions.';
CREATE INDEX idx_transactions_user_id ON public.transactions(user_id);
CREATE INDEX idx_transactions_category_id ON public.transactions(category_id);

-- Budgets table
CREATE TABLE public.budgets (
    id uuid NOT NULL DEFAULT gen_random_uuid() PRIMARY KEY,
    user_id uuid NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    category_id uuid NOT NULL REFERENCES public.categories(id),
    amount numeric(10, 2) NOT NULL,
    period public.budget_period NOT NULL,
    start_date date NOT NULL,
    end_date date,
    CONSTRAINT amount_must_be_positive_budgets CHECK (amount > 0),
    CONSTRAINT valid_dates CHECK (start_date <= end_date)
);
COMMENT ON TABLE public.budgets IS 'Stores user-defined budgets for specific categories.';
CREATE INDEX idx_budgets_user_id ON public.budgets(user_id);
CREATE INDEX idx_budgets_category_id ON public.budgets(category_id);

-- Function to update updated_at timestamp
CREATE OR REPLACE FUNCTION public.handle_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Triggers to update updated_at timestamp
CREATE TRIGGER on_users_updated
BEFORE UPDATE ON public.users
FOR EACH ROW
EXECUTE FUNCTION public.handle_updated_at();

CREATE TRIGGER on_transactions_updated
BEFORE UPDATE ON public.transactions
FOR EACH ROW
EXECUTE FUNCTION public.handle_updated_at();
