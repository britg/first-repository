require './farkle_rules'
require './farkle_dice'
require './farkle_roll_tester'

#ask if player would like the rules printed

def start_rules
  answer = ""
  
  until answer.downcase == "y" || answer.downcase == "n" do
    print "Would you like to review the Farkle rules? (y/n) "
    answer = gets.chomp
  end

  if answer.downcase == "y"
    puts "\nRules:\n\n"
    display_rules
    puts "\n\nPress [enter] to continue..."
    gets
    puts "\nScoring:\n\n"
    print_scoring
  end
end

#start game (obviously) w/ first roll
def start_game
  puts "Let's play Farkle!"
  puts ""
  answer = ""

  until answer.downcase == "y" || answer.downcase == "n" do
    print "Are you ready to roll? (y/n) "
    answer = gets.chomp
  end

  if answer.downcase == "y"
    new_dice
  else
    abort("Ok, maybe later!")
  end
end

start_rules
start_game
roll_dice