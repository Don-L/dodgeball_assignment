require_relative('../db/sql_runner')
require_relative('team')
require_relative('match')


class League

  attr_accessor(:name)
  attr_reader(:id)


  def initialize(options)

    @id = options['id'].to_i
    @name = options['name']

  end



  def save

    sql = "INSERT INTO leagues (

                name )

            VALUES (

                '#{@name}' )

            RETURNING *"

    return League.map_item(sql)

  end



  def update(options)

    sql = "UPDATE leagues

          SET #{options.keys[0]} = '#{options.values[0]}'

          WHERE id = #{@id};"

    SqlRunner.run(sql)

  end



  def self.delete_all

    sql = "DELETE FROM leagues;"
    SqlRunner.run(sql)

  end



  def delete

    sql = "DELETE FROM leagues WHERE id = #{@id}"
    SqlRunner.run(sql)

  end



  def upcoming_matches

    sql = "SELECT * FROM matches WHERE result = 0 AND league_id = #{@id};"
    Match.map_items(sql)

  end

  

  def past_matches

    sql = "SELECT * FROM matches WHERE result > 0 AND league_id = #{@id};"
    Match.map_items(sql)

  end



  def self.map_items(sql)

    leagues = SqlRunner.run( sql )
    result = leagues.map { |league| League.new( league ) }
    return result

  end



  def self.map_item(sql)

    result = League.map_items(sql)
    return result.first

  end





















end










