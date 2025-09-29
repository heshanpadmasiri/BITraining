-- Create Books table matching BookData type from types.bal
CREATE TABLE IF NOT EXISTS books (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    edition INTEGER NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create index on title and author for better query performance
CREATE INDEX IF NOT EXISTS idx_books_title_author ON books(title, author);

-- Insert dummy data
INSERT INTO books (title, author, edition, price) VALUES
    ('The Great Gatsby', 'F. Scott Fitzgerald', 1, 12.99),
    ('To Kill a Mockingbird', 'Harper Lee', 1, 14.99),
    ('1984', 'George Orwell', 1, 13.99),
    ('Pride and Prejudice', 'Jane Austen', 1, 11.99),
    ('The Catcher in the Rye', 'J.D. Salinger', 1, 15.99),
    ('Lord of the Flies', 'William Golding', 1, 12.99),
    ('The Hobbit', 'J.R.R. Tolkien', 1, 16.99),
    ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 1, 18.99),
    ('The Chronicles of Narnia', 'C.S. Lewis', 1, 17.99),
    ('The Da Vinci Code', 'Dan Brown', 1, 14.99),
    ('The Great Gatsby', 'F. Scott Fitzgerald', 2, 13.99),
    ('1984', 'George Orwell', 2, 14.99),
    ('Pride and Prejudice', 'Jane Austen', 2, 12.99),
    ('The Hobbit', 'J.R.R. Tolkien', 2, 17.99),
    ('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 2, 19.99);

-- Create a function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ language 'plpgsql';

-- Create trigger to automatically update updated_at
CREATE TRIGGER update_books_updated_at 
    BEFORE UPDATE ON books 
    FOR EACH ROW 
    EXECUTE FUNCTION update_updated_at_column();