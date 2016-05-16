require('pg')
require('pry-byebug')
require_relative('../db/sql_runner')
require_relative('../models/match')
require_relative('../models/league')
require_relative('../models/team')


class FixtureGenerator

  attr_accessor(:teams, :no_of_rounds, :league_id)


  def initialize(teams, no_of_rounds, league_id)

    @teams = teams
    @no_of_rounds = no_of_rounds
    @league_id = league_id

  end



  def generate

    array = []
    num = @no_of_rounds/2
    num = num.to_i
    num.times do array << two_rounds
    end

    if @no_of_rounds%2 != 0
      array << one_round
    end

    array.flatten!

    pairs = []
    i = 0
    while i <= array.length - 2
      j = i + 1
      pairs << [array[i], array[j]]
      i += 2
    end

    array = pairs.shuffle.flatten

    i = 0
    while i <= array.length - 2
      j = i + 1
      Match.new({'league_id' => @league_id, 'home_id' => array[i].id, 'away_id' => array[j].id, 'result' => 0}).save
      i += 2
    end

  end



  def two_rounds

    fixtures = []
    i = 0
    while i <= @teams.length - 2
      j = i + 1
      while j <= @teams.length - 1
          fixtures << [@teams[i], @teams[j]]
          fixtures << [@teams[j], @teams[i]]
          j += 1
      end
      i += 1
    end

    return fixtures

  end



  def one_round

    fixtures = []
    i = 0
    while i <= @teams.length - 2
      j = i + 1
      while j <= @teams.length - 1
          fixtures << [@teams[i], @teams[j]]
          j += 1
      end
      i += 1
    end

    n = 2
    for pair in fixtures
      if n%2 == 0
        pair.reverse!
      end
      n += 1
    end

    return fixtures

  end


end


# binding.pry
# nil

