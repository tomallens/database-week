require_relative '../lib/book_repository'
require_relative '../lib/book'
require 'pg'

RSpec.describe BookRepository do

  def reset_books_table
    seed_sql = File.read('spec/seeds_books.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'book_store_test' })
    connection.exec(seed_sql)
  end

  before(:each) do 
    reset_books_table
  end

  it 'returns full list of 2 books' do
    repo = BookRepository.new
    books = repo.all

    expect(books.length).to eq 2
    expect(books.first.title).to eq 'The Algebraist'
    expect(books.first.author_name).to eq 'Iain M Banks'
  end


end