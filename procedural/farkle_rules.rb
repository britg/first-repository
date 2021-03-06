#create global dice and score containers

$dice_hash = {1 => "", 2 => "", 3 => "", 4 => "", 5 => "", 6 => ""}  #hash to contain all dice
$dice_array = []  #array to contain dice to be re-rolled
$re_roll_array = []  #array to contain new re-roll dice
$player_total_score = 0  #player total score for game
$player_running_score = 0  #player running score per turn (will add to total score unless player Farkles)
$farkle = false

#Farkle Rules:

def display_rules
	puts "Roll the dice and set aside any dice you want that are worth points."
	puts "This forms your running score for the round. Roll the remaining dice,"
	puts "setting aside any worth points and adding them to your running total."
	puts "If you are able to set aside all six dice, you may re-roll all dice"
	puts "and keep building toward your total score. If you are ever not able to"
	puts "set aside any dice, you have Farkled and lose your running point total"
	puts "and your turn is over. Meet or exceed 10,000 points to win the game."
end

#Scoring:

def print_scoring
	puts "5's = 50 points"
	puts "1's = 100 points"
	puts "Three 1's = 300 points"
	puts "Three 2's = 200 points"
	puts "Three 3's = 300 points"
	puts "Three 4's = 400 points"
	puts "Three 5's = 500 points"
	puts "Three 6's = 600 points"
	puts "Four of a kind = 1,000 points"
	puts "Five of a kind = 2,000 points"
	puts "Six of a kind = 3,000 points"
	puts "Straight of 1-6 = 1,500 points"
	puts "Three Pairs = 1,500 points"
	puts "Four of a kind + a pair = 1,500 points"
	puts "Two sets of three of a kind = 2,500 points"
end

