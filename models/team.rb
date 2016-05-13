require_relative('../db/sql_runner')

class Team

attr_accessor(:name, :points, :matches_played)
attr_reader(:id)


def initialize(options)

  @id = options['id'].to_i
  @name = options['name']
  @matches_played = options['matches_played'].to_i
  @points = options['points'].to_i
  
end



def save

  sql = "INSERT INTO teams (

              name, matches_played, points )

          VALUES (

              '#{@name}', 0, 0 )

          RETURNING *"

  return Team.map_item(sql)

end



def self.delete_all

  sql = "DELETE FROM teams"
  SqlRunner.run(sql)

end



def delete

  sql = "DELETE FROM teams WHERE id = #{@id}"
  SqlRunner.run(sql)

end



def update(options_hash)

  sql = "UPDATE teams

        SET #{options_hash.keys[0]} = '#{options_hash.values[0]}'

        WHERE id = #{@id}"

  SqlRunner.run(sql)

end



def self.all

  sql = "SELECT * from teams;"

  return Team.map_items(sql)

end



def print_team

  puts "#{@name}".ljust(25) + @matches_played.to_s.rjust(15) + @points.to_s.rjust(10)

end


def self.league_table_order

  sql = "SELECT * FROM teams ORDER BY points DESC;"

  Team.map_items(sql)

end



def self.map_items(sql)

  teams = SqlRunner.run( sql )
  result = teams.map { |team| Team.new( team ) }
  return result

end



def self.map_item(sql)

  result = Team.map_items(sql)
  return result.first

end




















end









