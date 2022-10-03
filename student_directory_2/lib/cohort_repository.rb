require 'cohort'
require 'student'
require 'database_connection'

class CohortRepository
  def finds_with_students(id)
    sql = 'SELECT cohorts.id,
                  cohorts.name,
                  cohorts.starting_date,
                  students.id AS student_id,
                  students.name,
          FROM cohorts
          JOIN students ON students.cohort_id = cohorts.id
          WHERE cohorts.id = $1;'

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)
    cohort = Cohort.new
  
    cohort.id = result.first['id']
    cohort.name = result.first['name']
    cohort.starting_date = result.first['starting_date']

    result.each do |record|
    student = Student.new
    student.id = record['cohort_id']
    student.name = record['name']
  
    cohort.students << student
    end
    return cohort
  end
end
  class ArtistRepository
    def find_with_albums(id)
      sql = 'SELECT artists.id,
                    artists.name,
                    artists.genre,
                    albums.id AS album_id,
                    albums.title,
                    albums.release_year
            FROM artists
            JOIN albums ON albums.artist_id = artists.id
            WHERE artists.id = $1;'
  
      params = [id]
  
      result = DatabaseConnection.exec_params(sql, params)
      artist = Artist.new
  
      artist.id = result.first['id']
      artist.name = result.first['name']
      artist.genre = result.first['genre']
  
      result.each do |record|
        album = Album.new
        album.id = record['album_id']
        album.title = record['title']
        album.release_year = record['release_year']
  
        artist.albums << album
      end
  
      return artist
    end
  end