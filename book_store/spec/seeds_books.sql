-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE books RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.ß
-- Replace these statements with your own seed data.

INSERT INTO books (title, author_name) VALUES ('The Algebraist', 'Iain M Banks');
INSERT INTO books (title, author_name) VALUES ('The Dispossessed', 'Ursula le Guin');