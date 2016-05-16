require_relative('models/team.rb')
require_relative('models/match.rb')
require_relative('models/league.rb')
require_relative('interactive/fixture_generator')
require('pry-byebug')


Match.delete_all
Team.delete_all
League.delete_all

league1 = League.new({'name' => 'Le Chariot Express Superleague'}).save
league2 = League.new({'name' => 'Poundstretcher Dodgeball League'}).save

# league2.delete

team1 = Team.new({'league_id' => league1.id, 'name' => 'Dynamo Dalkeith'}).save
team2 = Team.new({'league_id' => league1.id, 'name' => 'Spartak Moredun'}).save
team3 = Team.new({'league_id' => league1.id, 'name' => 'Real Danderhall'}).save
team4 = Team.new({'league_id' => league1.id, 'name' => 'South Ed Ecstasy'}).save

teams = [team1, team2, team3, team4]

FixtureGenerator.new(teams, 2, league1.id).generate

# match1 = Match.new({'league_id' => league1.id, 'home_id' => team1.id, 'away_id' => team2.id}).save
# match2 = Match.new({'league_id' => league1.id, 'home_id' => team2.id, 'away_id' => team1.id}).save
# match3 = Match.new({'league_id' => league1.id, 'home_id' => team3.id, 'away_id' => team4.id, 'result' => 2}).save
# match4 = Match.new({'league_id' => league1.id, 'home_id' => team4.id, 'away_id' => team3.id}).save
# match5 = Match.new({'league_id' => league1.id, 'home_id' => team1.id, 'away_id' => team3.id}).save


# league1.update({'name' => 'Le Chariot Express Uberleague'})

# match2.delete
# team1.delete





# match3.update({'result' => 1})
# match2.update({'result' => 2})

# a = Match.matches_in_order
# b = Match.next_match

# team1.update({'name' => 'The Ecclefechan Ecstasy'})
# team1.update({'points' => 12})
# team2.update({'points' => 2})
# team3.update({'points' => 23})
# team4.update({'points' => 7})

# a = Team.league_table_order

# puts team1.points

# a = Match.all
# b = Team.all

# team1.print_team

# match1.print_upcoming_match

# u = league1.upcoming_matches
# v = league1.past_matches

# match3.print_match_result

# r = FixtureGenerator.new([team1, team2, team3, team4], 1, league1.id)

# r.generate


binding.pry
nil








