module Farkle
  class Game

    def initialize
      @rules = Farkle::Rules.new
      @dice = Farkle::Dice.new
      @input = ""
      @score = 0
      @farkle = false
    end

    def start
      @rules.prompt
      announce_play
      prompt_initial_roll
    end

    def announce_play
      puts "Let's play Farkle!"
      puts ""
    end

    def prompt_initial_roll
      @input = ""

      until @input.downcase == "y" || @input.downcase == "n" do
        print "Are you ready to roll? (y/n) "
        @input = gets.chomp
      end

      do_round if @input == "y"
    end

    def do_round
      @dice.roll
      @dice.display
      process_round
    end

    def process_round
      if @dice.straight?
        puts "\n\nYou rolled a straight!"
        add_score_and_prompt(1500, :all)
      elsif @dice.four_kind_and_pair?
        puts "\n\nYou rolled a four-of-a-kind and a pair!"
        add_score_and_prompt(1500, :all)
      elsif @dice.two_three_kind?
        puts "\n\nYou rolled two three-of-a-kinds!"
        add_score_and_prompt(2500, :all)
      elsif @dice.three_two_pair?
        puts "\n\nYou rolled three pairs!"
        add_score_and_prompt(1500, :all)
      elsif @dice.six_kind?
        puts "\n\nYou rolled a six-of-a-kind!"
        add_score_and_prompt(3000, :all)
      elsif @dice.five_kind?
        puts "\n\nYou rolled a five-of-a-kind!"
        add_score_and_prompt(2000, :remaining)
      elsif @dice.four_kind?
        puts "\n\nYou rolled a four-of-a-kind!"
        add_score_and_prompt(1000, :remaining)
      elsif @dice.three_kind?
        puts "\n\nYou rolled a three-of-a-kind!"
        add_score_and_prompt(three_kind_points(@dice.dice_array), :remaining)
      elsif @dice.one_five?
        puts "\n\nGreat! You at least rolled a 1 or a 5!"

        #ask whether or not to keep the 1s or 5s rolled and score them
        @dice.dice_array.each do |die|
          prompt_keep if die == 1 || die == 5
        end

        prompt_reroll
      else
        puts "\n\nFARKLE! Bummer, your turn is over!"
        @farkle = true
        end_and_score
      end
    end

    def prompt_keep
      @input = ""
      until @input.downcase == "y" || @input.downcase == "n" do
        print "Would you like to keep the #{die}? (y/n) "
        @input = gets.chomp
      end

      if @input.downcase == "n"
        @dice.remaining_dice.push(die)
      else
        if die == 1
          @score += 100
        elsif die == 5
          @score += 50
        end
      end
    end

    def add_score_and_prompt score, reroll_type = :all
      @score += score
      if reroll_type == :all
        prompt_reroll_all
      else
        prompt_reroll
      end
    end

    def prompt_reroll
      @input = ""
      until @input.downcase == "y" || @input.downcase == "n" do
        print "Would you like to re-roll the following dice: #{$dice_array}? (y/n) "
        @input = gets.chomp
      end

      if @input.downcase == 'y'
        @dice.reroll_dice.clear

        @dice.dice_hash.each do |key, value|
          if $dice_array.include?(value)
            $dice_array.delete_at($dice_array.index(value))
            rand_num = NewRandomNum.new
            rand_num = rand_num.generate
            $dice_hash[key] = rand_num
            $re_roll_array.push(rand_num)
          end

        end
        re_roll_sim($re_roll_array)
        test_roll($re_roll_array)
      else
        end_and_score
      end
    end

    #ask if re-roll all dice or quit turn and determine score
    def prompt_reroll_all
      @input = ""
      puts "Your running score for this roll is now #{@score}!!!"
      sleep 0.25
      until @input.downcase == "y" || @input.downcase == "n" do
        puts "Would you like to re-roll all dice (If not your current roll will be added to your score)? (y/n) "
        @input = gets.chomp
      end

      if @input == "y"
        do_round
      else
        end_and_score
      end
    end

    def end_and_score
      if @farkle
        @score = 0
        puts "Press [enter] to start next roll..."
        gets
        $farkle = false
        puts ""
        puts "Here we go again!"
        new_dice
        roll_dice
      else
        $player_total_score += $player_running_score
        if $player_total_score >= 10000
          abort("Your score is now #{$player_total_score}!!! You win!!!")
        else
          puts "Your score is now #{$player_total_score}!!!"
          puts "Press [enter] to start next roll..."
          gets
          $player_running_score = 0
          puts "Here we go again!"
          new_dice
          roll_dice
        end
      end
    end


    def three_kind_points(dice_array)
      dup = dice_array.select{|element| dice_array.count(element) == 3}
      if dup.uniq.include?(1)
        $player_running_score += 300
      else
        $player_running_score += dup.pop * 100
      end
    end
  end
end
