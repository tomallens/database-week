-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE artists RESTART IDENTITY;
TRUNCATE TABLE albums RESTART IDENTITY;

-- Below this line there should only be `INSERT` statements.ß
-- Replace these statements with your own seed data.

INSERT INTO artists (name, genre) VALUES ('Pixies', 'Rock');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Bossanova', '1999', '1');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Sufer Rosa', '2001', '1');