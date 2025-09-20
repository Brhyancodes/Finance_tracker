-- supabase/seed.sql

-- Default expense categories
INSERT INTO public.categories (name, color, icon, type, is_default) VALUES
('Food', '#FF6347', '🍔', 'expense', true),
('Transportation', '#4682B4', '🚗', 'expense', true),
('Entertainment', '#FFD700', '🎬', 'expense', true),
('Housing', '#8A2BE2', '🏠', 'expense', true),
('Utilities', '#00CED1', '💡', 'expense', true),
('Health', '#32CD32', '❤️', 'expense', true),
('Shopping', '#FF69B4', '🛍️', 'expense', true),
('Other', '#778899', '📦', 'expense', true);

-- Default income categories
INSERT INTO public.categories (name, color, icon, type, is_default) VALUES
('Salary', '#2E8B57', '💰', 'income', true),
('Freelance', '#DAA520', '💼', 'income', true),
('Investment', '#4169E1', '📈', 'income', true),
('Gift', '#FFC0CB', '🎁', 'income', true),
('Other', '#778899', '📦', 'income', true);
