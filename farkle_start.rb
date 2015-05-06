require './farkle_rules'
require './farkle_dice'
require './farkle_roll_tester'

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

start_game
roll_dice