# Two Tables Design Recipe Template

_Copy this recipe template to design and create two related database tables from a specification._

## 1. Extract nouns from the user stories or specification

```
# EXAMPLE USER STORY:
# (analyse only the relevant part - here the final line).

As a coach
So I can get to know all cohort
I want to see a list of cohort' names.

As a coach
So I can get to know all cohort
I want to see a list of cohorts' names.

As a coach
So I can get to know all cohort
I want to see a list of cohorts' starting dates.

As a coach
So I can get to know all cohort
I want to see a list of cohort' cohorts.
```

```
Nouns:

cohort, names, starting_dates, cohorts
```

## 2. Infer the Table Name and Columns

Put the different nouns in this table. Replace the example with your own nouns.

| Record                | Properties          |
| --------------------- | ------------------  |
| student               | name
| cohort                | name, starting_date

1. Name of the first table (always plural): `cohort` 

    Column names: `name`

2. Name of the second table (always plural): `cohorts` 

    Column names: `name`, `starting_date`

## 3. Decide the column types.

[Here's a full documentation of PostgreSQL data types](https://www.postgresql.org/docs/current/datatype.html).

Most of the time, you'll need either `text`, `int`, `bigint`, `numeric`, or `boolean`. If you're in doubt, do some research or ask your peers.

Remember to **always** have the primary key `id` as a first column. Its type will always be `SERIAL`.

```
# EXAMPLE:

Table: cohort
id: SERIAL
name: text

Table: cohorts
id: SERIAL
name: text
starting_date: text
```

## 4. Decide on The Tables Relationship

Most of the time, you'll be using a **one-to-many** relationship, and will need a **foreign key** on one of the two tables.

To decide on which one, answer these two questions:

1. Can one [TABLE ONE] have many [TABLE TWO]? (Yes/No)
2. Can one [TABLE TWO] have many [TABLE ONE]? (Yes/No)

You'll then be able to say that:

1. **[A] has many [B]**
2. And on the other side, **[B] belongs to [A]**
3. In that case, the foreign key is in the table [B]

Replace the relevant bits in this example with your own:

```
# EXAMPLE

1. Can one cohort have many cohort? YES
2. Can one student have many cohorts? NO

-> Therefore,
-> An cohort HAS MANY cohort
-> A student BELONGS TO a cohort

-> Therefore, the foreign key is on the cohort table.
```

*If you can answer YES to the two questions, you'll probably have to implement a Many-to-Many relationship, which is more complex and needs a third table (called a join table).*

## 4. Write the SQL.

```sql
file: cohort_table.sql

-- Replace the table name, columm names and types.

-- Create the table without the foreign key first.
CREATE TABLE cohorts (
  id SERIAL PRIMARY KEY,
  name text,
  starting_date text
);

-- Then the table with the foreign key first.
CREATE TABLE cohort (
  id SERIAL PRIMARY KEY,
  name text,
-- The foreign key name is always {other_table_singular}_id
  cohort_id int,
  constraint fk_cohort foreign key(cohort_id)
    references cohorts(id)
    on delete cascade
);

```

## 5. Create the tables.

```bash
psql -h 127.0.0.1 student_directory_2 < cohort_table.sql
```
## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE cohort, cohorts RESTART IDENTITY;
 -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.
--PROBABLY NEED TO SPECIFY COHORT_ID
INSERT INTO cohort (name) VALUES ('David'); 
INSERT INTO cohort (name) VALUES ('Anna');

INSERT INTO cohorts (name, starting_date) VALUES ('April 2022', '1/4/2022');
INSERT INTO cohorts (name, starting_date) VALUES ('May 2022', '1/5/2022');
```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{student_directory_2}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: cohort

# Model class
# (in lib/student.rb)
class Student
end

class Cohort
end

# Repository class
# (in lib/student_repository.rb)
class CohortRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: cohort

# Model class
# (in lib/student.rb)

class Student

  # Replace the attributes by your own columns.
  attr_accessor :id, :name, :cohort_id
end

class Cohort
  attr_accessor :id, :name, :starting_date
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# student = Student.new
# student.name = 'Jo'
# student.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: cohort

# Repository class
# (in lib/student_repository.rb)

class StudentRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM cohort;

    # Returns an array of Student objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM cohort WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  # def create(student)
  # end

  # def update(student)
  # end

  # def delete(student)
  # end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all cohort

repo = CohortRepository.new
cohort = repo.find_with_students(1)


cohort.name # =>  'April 2022'
cohort.students.length # =>  1

# expect(artist.albums.length).to eq(3)

# Add more examples for each method
# describe ArtistRepository do

#   # (...)

#   it 'finds artist 1 with related albums' do
#     repository = ArtistRepository.new
#     artist = repository.find_with_albums(1)

#     expect(artist.name).to eq('Pixies')
#     expect(artist.albums.length).to eq(3)
#   end
# end


```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_cohort_table
  seed_sql = File.read('spec/seeds_cohort.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'cohort' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_cohort_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._