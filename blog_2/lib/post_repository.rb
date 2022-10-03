require 'post'
require 'tag'
require 'database_connection'

class PostRepository
  def find_by_tag(id)
    # Executes the SQL query:
    sql = 'SELECT posts.id,
          posts.title
          FROM posts
          JOIN posts_tags ON posts_tags.post_id = posts.id
          JOIN tags ON posts_tags.tag_id = tags.id
          WHERE tags.id = $1
          ;'
    
    # Returns a single Post object.
  end
end