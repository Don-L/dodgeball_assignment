class MenuPrompt

attr_accessor(:query, :options_list)

def initialize(query, options_list)
  @query = query
  @options_list = options_list
end



def print_and_check_response
  puts ' '
  puts @query
  puts ' '
  for option in @options_list
    puts"[#{option[0]}] > #{option[1]}"
  end
  puts ' '
  response = gets.chomp.to_i
  check_response(response)
end



def check_response(response)
  option_numbers = []
  for option in @options_list
    option_numbers << option[0]
  end
  if
    option_numbers.include?(response)
    return response
  else
      puts ' '
      puts 'Input not recognised. Please enter a number from the listed options.'
      puts ' '
      print_and_check_response
  end
end

end


# question = MenuPrompt.new('how are you?', {1 => 'fine', 2 => 'great'})

# response = question.print_and_check_response

# puts response





