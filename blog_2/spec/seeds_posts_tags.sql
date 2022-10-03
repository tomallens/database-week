
TRUNCATE TABLE posts_tags RESTART IDENTITY CASCADE; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts_tags (post_id, tag_id) VALUES ('1', '1');
INSERT INTO posts_tags (post_id, tag_id) VALUES ('2', '2');