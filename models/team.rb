require_relative('../db/sql_runner')
require_relative('match')
require_relative('league')

class Team

attr_accessor(:name, :points, :matches_played, :league_id)
attr_reader(:id)


def initialize(options)

  @id = options['id'].to_i
  @league_id = options['league_id'].to_i
  @name = options['name']
  @matches_played = options['matches_played'].to_i
  @points = options['points'].to_i
  
end



def save

  sql = "INSERT INTO teams (

              league_id, name, matches_played, points )

          VALUES (

              #{@league_id}, '#{@name}', #{matches_played}, #{points} )

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



def update(options)

  sql = "UPDATE teams

        SET #{options.keys[0]} = '#{options.values[0]}'

        WHERE id = #{@id}"

  SqlRunner.run(sql)

end



def self.all

  sql = "SELECT * from teams;"

  return Team.map_items(sql)

end



def self.all_by_league(league_id)

  sql = "SELECT * from teams WHERE league_id = #{league_id}"

  return Team.map_items(sql)

end



def print_team

  puts "#{@name}".ljust(25) + @matches_played.to_s.rjust(15) + @points.to_s.rjust(10)

end


def self.league_table_order

  sql = "SELECT * FROM teams ORDER BY points DESC;"

  Team.map_items(sql)

end



def team_upcoming_matches

  sql = "SELECT * FROM matches WHERE (result = 0 AND home_id = #{id}) OR (result = 0 AND away_id = #{id});"

  Match.map_items(sql)

end



def team_results

  sql = "SELECT * FROM matches WHERE (result > 0 AND home_id = #{id}) OR (result > 0 AND away_id = #{id});"

  Match.map_items(sql)

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









