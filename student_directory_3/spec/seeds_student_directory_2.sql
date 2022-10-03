TRUNCATE TABLE students, cohorts RESTART IDENTITY;
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

--INSERT INTO students (name, cohort_id) VALUES ('David', '1');
--INSERT INTO students (name, cohort_id) VALUES ('Anna', '2');

INSERT INTO cohorts (name, starting_date) VALUES ('April 2022', '1/4/2022');
INSERT INTO cohorts (name, starting_date) VALUES ('May 2022', '1/5/2022');