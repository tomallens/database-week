require_relative 'lib/database_connection'
require_relative 'lib/book_repository'
require 'pg'

# Make sure this connects to your test database
# (its name should end with '_test')
DatabaseConnection.connect('book_store_test')

book_repository = BookRepository.new

book_repository.all.each { |book| p book }


