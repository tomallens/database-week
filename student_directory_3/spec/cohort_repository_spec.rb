require 'cohort_repository'

def reset_name_table
  seed_sql = File.read('spec/seeds_student_directory_2.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'student_directory_3' })
  connection.exec(seed_sql)
end

describe CohortRepository do
  before(:each) do 
    reset_name_table
  end

  # (your tests will go here).  
  it 'finds the cohort we want' do
    repo = CohortRepository.new
    cohort = repo.finds_with_students(1)

    expect(cohort.name).to eq 'April 2022' # =>  'April 2022'
    expect(cohort.students.length).to eq '1' # =>  1
  end
end
