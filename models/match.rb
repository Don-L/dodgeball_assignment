require_relative('../db/sql_runner')
require_relative('team')

class Match

  attr_accessor(:home_id, :away_id, :result)
  attr_reader(:id)



  def initialize(options)

    @id = options['id'].to_i
    @home_id = options['home_id'].to_i
    @away_id = options['away_id'].to_i
    @result = options['result'].to_i

  end



  def save

    sql = "INSERT INTO matches (

                home_id, away_id, result )

            VALUES (

                #{@home_id}, #{@away_id}, 0 )

            RETURNING *;"

    return Match.map_item(sql)

  end



  def self.delete_all

    sql = "DELETE FROM matches;"
    SqlRunner.run(sql)

  end


  def delete

    sql = "DELETE FROM matches WHERE id = #{@id};"
    SqlRunner.run(sql)

  end


  def update(options_hash)

    sql = "UPDATE matches

          SET #{options_hash.keys[0]} = #{options_hash.values[0]}

          WHERE id = #{@id};"

    SqlRunner.run(sql)

  end



  def self.all

    sql = "SELECT * from matches;"

    return Match.map_items(sql)

  end



  def print_match

    sql = "SELECT * FROM teams WHERE id IN(SELECT home_id FROM matches 
          WHERE id = #{@id});"

    home_team = Team.new(SqlRunner.run(sql).first)

    sql = "SELECT * FROM teams WHERE id IN(SELECT away_id FROM matches 
          WHERE id = #{@id});"

    away_team = Team.new(SqlRunner.run(sql).first)

    puts "#{home_team.name} (h)".ljust(20) + "Vs".center(10) + "#{away_team.name} (a)".rjust(20)

  end



  def self.matches_in_order

    sql = "SELECT * FROM matches WHERE result = 0 ORDER BY id ASC;"

    Match.map_items(sql)

  end



  def self.next_match

    sql = "SELECT * FROM matches WHERE result = 0 ORDER BY id ASC;"

    Match.map_item(sql)

  end


  def self.map_items(sql)
    matches = SqlRunner.run( sql )
    result = matches.map { |match| Match.new( match ) }
    return result
  end



  def self.map_item(sql)
    result = Match.map_items(sql)
    return result.first
  end










end





