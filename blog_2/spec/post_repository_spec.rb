require 'post_repository'

RSpec.describe PostRepository do
  def reset_students_table
    seed_sql = File.read('spec/seeds_posts.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'blog_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_students_table
  end

  it 'finds all posts with given tag' do
    repo = PostRepository.new

    posts = repo.find_by_tag(1)
    p posts
    expect(posts.length).to eq 1 # =>  1

    expect(posts[0].id).to eq '1' # =>  1
    expect(posts[0].title).to eq 'dogs' # =>  'dogs'
  end
end