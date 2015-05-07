module Farkle
  class Dice

    attr_accessor :remaining_dice, :reroll_dice

    def self.random_die
      Random.rand(6) + 1
    end

    def initialize
      @dice_hash = {}
      @remaining_dice = []
    end

    def roll
      6.times do |i|
        @dice_hash[i] = Farkle::Dice.random_die
      end
    end

    def display
      puts "..shake..shake..shake.."
      puts ""
      sleep 1.25
      @dice_hash.each do |key, value|
        print "#{value} "
        sleep 0.25
      end
    end

    def dice_array
      @dice_array ||= @dice_hash.values
    end

    def straight?
      dice_array.sort.eql?([1,2,3,4,5,6])
    end

    def four_kind_and_pair?
      dup = dice_array.select{|element| dice_array.count(element) == 2}
      dup2 = dice_array.select{|element| dice_array.count(element) == 4}
      (dup.any? && dup2.any?)
    end

    def two_three_kind?
      dup = dice_array.select{|element| dice_array.count(element) == 3}
      dup.uniq.length == 2
    end

    def three_two_pair?
      dup = dice_array.select{|element| dice_array.count(element) == 2}
      dup.uniq.length == 3
    end

    def six_kind?
      dup = dice_array.select{|element| dice_array.count(element) == 6}
      dup.any?
    end

    def five_kind?
      of_a_kind?(5)
    end

    def four_kind?
      of_a_kind?(4)
    end

    def three_kind?
      of_a_kind?(3)
    end

    def of_a_kind? num
      @remaining_dice = []
      dup = dice_array.select{|element| dice_array.count(element) == num}

      #return non-scoring dice for possible re-roll
      dice_array.each do |die|
        unless dup.include?(die)
          @remaining_dice.push(die)
        end
      end

      dup.any?
    end

    def one_five?
      @remaining_dice.clear
      #pull out 1s and 5s
      dice_array.each do |die|
        if die != 1 && die != 5
          @remaining_dice.push(die)
        end
      end

      (dice_array.include?(1) || dice_array.include?(5))
    end
  end
end
