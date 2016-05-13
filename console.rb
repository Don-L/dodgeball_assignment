require_relative('models/team.rb')
require_relative('models/match.rb')
require('pry-byebug')


Match.delete_all
Team.delete_all


team1 = Team.new({'name' => 'Dynamo Dalkeith'}).save
team2 = Team.new({'name' => 'Spartak Moredun'}).save
team3 = Team.new({'name' => 'Real Danderhall'}).save
team4 = Team.new({'name' => 'South Ed Ecstasy'}).save


match1 = Match.new({'home_id' => team1.id, 'away_id' => team2.id}).save
match2 = Match.new({'home_id' => team2.id, 'away_id' => team1.id}).save
match3 = Match.new({'home_id' => team3.id, 'away_id' => team4.id}).save
match4 = Match.new({'home_id' => team4.id, 'away_id' => team3.id}).save
match5 = Match.new({'home_id' => team1.id, 'away_id' => team3.id}).save


# match2.delete
# team1.delete


# match1.update({'result' => 1})
# match2.update({'result' => 2})

# a = Match.matches_in_order
# b = Match.next_match

# team1.update({'name' => 'The Ecclefechan Ecstasy'})
team1.update({'points' => 12})
team2.update({'points' => 2})
team3.update({'points' => 23})
team4.update({'points' => 7})

a = Team.league_table_order

# puts team1.points

# a = Match.all
# b = Team.all

# team1.print_team

# match1.print_match











binding.pry
nil