require './farkle_dice'
require './farkle_score'

#test for scoring dice and record score (refer to rules for types of scoring dice)
def test_roll(dice_array)
  if straight(dice_array)
    puts "\n\nYou rolled a straight!"
    $player_running_score += 1500
    keep_all_dice?
  elsif four_kind_and_pair(dice_array)
    puts "\n\nYou rolled a four-of-a-kind and a pair!"
    $player_running_score += 1500
    keep_all_dice?
  elsif two_three_kind(dice_array)
    puts "\n\nYou rolled two three-of-a-kinds!"
    $player_running_score += 2500
    keep_all_dice?
  elsif three_two_pair(dice_array)
    puts "\n\nYou rolled three pairs!"
    $player_running_score += 1500
    keep_all_dice?
  elsif six_kind(dice_array)
    puts "\n\nYou rolled a six-of-a-kind!"
    $player_running_score += 3000
    keep_all_dice?
  elsif five_kind(dice_array)
    puts "\n\nYou rolled a five-of-a-kind!"
    $player_running_score += 2000
    re_roll_dice
  elsif four_kind(dice_array)
    puts "\n\nYou rolled a four-of-a-kind!"
    $player_running_score += 1000
    re_roll_dice
  elsif three_kind(dice_array)
    puts "\n\nYou rolled a three-of-a-kind!"
    three_kind_points(dice_array)
    re_roll_dice
  elsif one_five(dice_array)
    puts "\n\nGreat! You at least rolled a 1 or a 5!"

    #ask whether or not to keep the 1s or 5s rolled and score them
    dice_array.each do |die|
      if die == 1 || die == 5
        answer = ""
        until answer.downcase == "y" || answer.downcase == "n" do
          print "Would you like to keep the #{die}? (y/n) "
          answer = gets.chomp
        end

        if answer.downcase == "n"
          $dice_array.push(die)
        else
          if die == 1
            $player_running_score += 100
          elsif die == 5
            $player_running_score += 50
          end
        end

      end
    end
    re_roll_dice
  else
    puts "\n\nFARKLE! Bummer, your turn is over!"
    $farkle = true
    end_and_score
  end
end


#arrangements of scoring dice, return true if applicable
def straight(dice_array)
  dice_array.sort.eql?([1,2,3,4,5,6])
end

def four_kind_and_pair(dice_array)
  dup = dice_array.select{|element| dice_array.count(element) == 2}
  dup2 = dice_array.select{|element| dice_array.count(element) == 4}
  (dup.any? && dup2.any?)
end

def two_three_kind(dice_array)
  dup = dice_array.select{|element| dice_array.count(element) == 3}
  dup.uniq.length == 2
end

def three_two_pair(dice_array)
  dup = dice_array.select{|element| dice_array.count(element) == 2}
  dup.uniq.length == 3
end

def six_kind(dice_array)
  dup = dice_array.select{|element| dice_array.count(element) == 6}
  dup.any?
end

def five_kind(dice_array)
  $dice_array.clear
  dup = dice_array.select{|element| dice_array.count(element) == 5}

  #return non-scoring dice for possible re-roll
  dice_array.each do |die|
    unless dup.include?(die)
      $dice_array.push(die)
    end
  end

  dup.any?
end

def four_kind(dice_array)
  $dice_array.clear
  dup = dice_array.select{|element| dice_array.count(element) == 4}

  #return non-scoring dice for possible re-roll
  dice_array.each do |die|
    unless dup.include?(die)
      $dice_array.push(die)
    end
  end

  dup.any?
end

def three_kind(dice_array)
  $dice_array.clear
  dup = dice_array.select{|element| dice_array.count(element) == 3}

  #return non-scoring dice for possible re-roll
  dice_array.each do |die|
    unless dup.include?(die)
      $dice_array.push(die)
    end
  end

  dup.any?
end

def one_five(dice_array)
  $dice_array.clear

  #pull out 1s and 5s
  dice_array.each do |die|
    if die != 1 && die != 5
      $dice_array.push(die)
    end
  end

  (dice_array.include?(1) || dice_array.include?(5))
end

