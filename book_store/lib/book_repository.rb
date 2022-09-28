require_relative '../lib/book'
require 'pg'
require_relative '../lib/database_connection'

class BookRepository
  def all
    sql = 'SELECT id, title, author_name FROM books;'
    # result_set = DatabaseConnection.exec_params(sql, [])
    connection = DatabaseConnection.new
    connection.connect('book_store_test')
    connection.exec_params(sql, [])
    
    books = []
    result_set.each do |record|
      book = Book.new
      
      book.id = record['id']
      book.title = record['title']
      book.author_name = record['author_name']
      
      books << book
    end

    return books
  end
end