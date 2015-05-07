module Farkle
  class Rules

    def initialize
      @answer = ""
    end

    def prompt
      until @answer.downcase == "y" || @answer.downcase == "n" do
        print "Would you like to review the Farkle rules? (y/n) "
        @answer = gets.chomp
      end

      if @answer.downcase == "y"
        puts "\nRules:\n\n"
        display_rules
        puts "\n\nPress [enter] to continue..."
        gets
        puts "\nScoring:\n\n"
        print_scoring
      end
    end


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
  end
end
