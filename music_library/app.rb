# require_relative 'lib/database_connection'
# require_relative 'lib/artist_repository'
# require_relative 'lib/album_repository'

# Make sure this connects to your test database
# (its name should end with '_test')
DatabaseConnection.connect('music_library')

# artist_repository = ArtistRepository.new
# album_repository = AlbumRepository.new

# artist_repository.all.each { |artist| p artist }
# album_repository.all.each { |album| p album }

