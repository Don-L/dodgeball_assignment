require_relative('menu_prompt')
require_relative('fixture_generator')
require_relative('../models/league')
require_relative('../models/team')
require_relative('../models/match')

class System


  def initialize

  end



  def start_menu

    puts ' '
    puts '----------------------------------'
    puts 'DODGEBALL LEAGUE MANAGEMENT SYSTEM'
    puts '----------------------------------'
    puts ' '
    puts 'Start Menu'
    puts ' '
    response = MenuPrompt.new('Please enter a number to choose one of the options below: ', {1 => 'Create new league;', 2 => 'View existing league;', 0 => 'Quit'}).print_and_check_response
    puts ' '

    if response == 0
      abort('See you later!')
    elsif response == 1
      create_league
    elsif response =+ 2
      league_menu
    end
  end



  def create_league
    puts ' '
    puts "Please enter the name of your new dodgeball league, or enter QUIT to quit: "
    puts ' '
    response = gets.chomp
    if response == 'QUIT'
      abort('See you later!')
    else league = League.new({'name' => response}).save
      puts ' '
      puts 'Your new league has been created!'
      puts ' '
    end
    puts "Now to set up the teams in your league. Please enter the name of the first team you'd like to add or enter 'QUIT' to quit:"
    puts ' '
    response = gets.chomp
    if response == 'QUIT'
      abort('See you later!')
    else Team.new({'name' => response, 'points' => 0, 'matches_played' => 0, 'league_id' => league.id}).save
      puts 'Team created!'
      puts ' '
    end
    puts "You'll need to add at least one more team to complete league setup. Please enter a team name or enter 'QUIT' to quit:"
    puts ' '
    response = gets.chomp
    if response == 'QUIT'
      abort('See you later!')
    else Team.new({'name' => response, 'points' => 0, 'matches_played' => 0, 'league_id' => league.id}).save
      puts 'Team created!'
      puts ' '
      league_setup_completion(league.id)
    end
  end



  def league_setup_completion(league_id)
    response = MenuPrompt.new('League setup can now be completed. Please choose one of the options below: ', {1 => 'Complete league setup and arrange fixtures;', 2 => 'Add another team to the league', 3 => 'Return to Start Menu;', 0 => 'Quit'}).print_and_check_response
    if response == 0
      abort('See you later!')
    elsif response == 2 
      puts ' '
      puts "Enter team name or enter 'QUIT' to quit: "
      response2 = gets.chomp
      if response2 == 'QUIT'
        abort('See you later!')
      else Team.new({'name' => response2, 'points' => 0, 'matches_played' => 0, 'league_id' => league_id}).save
        puts ' '
        puts 'Team created!'
        puts ' '
        league_setup_completion(league_id)
      end
    elsif
      response == 3
      start_menu
    elsif response == 1
      arrange_fixtures(league_id)
    end
  end

  def arrange_fixtures(league_id)

    puts ' '
    puts 'How many times would you like each team to compete against each opponent? Please enter a number: '
    puts ' '
    response = gets.chomp.to_i
    response2 = MenuPrompt.new("You entered '#{response}'. Are you sure you would like each team to play #{response} time(s) against each opponent?", {1 => 'Yes, please generate a list of matches to be played in the league;', 2 => 'No, I would like to pick a different number of rounds'}).print_and_check_response
    if response2 == 2
      arrange_fixtures(league_id)
    elsif response2 == 1
      puts ' '
      puts "The fixtures for your league have been generated! You can use the league management menu to make alterations to the fixtures list or to amend team information. Returning to Start Menu."
      puts ' '
      teams = Team.all_by_league(league_id)
      FixtureGenerator.new(teams, response, league_id).generate
      start_menu
    end



  end

# system = System.new

# system.start_menu

















end