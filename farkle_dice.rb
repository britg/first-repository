require './farkle_rules'

#generate a new random number to assign to a specific die
class NewRandomNum
  attr_accessor :new_num

  def initialize
    @new_num = new_num
  end

  def generate
    new_num = Random.new
    new_num = new_num.rand(6) + 1
  end
end

#assign new random dice numbers (full roll)
def new_dice
  die_1 = Random.new
  die_2 = Random.new
  die_3 = Random.new
  die_4 = Random.new
  die_5 = Random.new
  die_6 = Random.new
  die_1 = die_1.rand(6) + 1
  die_2 = die_2.rand(6) + 1
  die_3 = die_3.rand(6) + 1
  die_4 = die_4.rand(6) + 1
  die_5 = die_5.rand(6) + 1
  die_6 = die_6.rand(6) + 1
  $dice_hash[1] = die_1
  $dice_hash[2] = die_2
  $dice_hash[3] = die_3
  $dice_hash[4] = die_4
  $dice_hash[5] = die_5
  $dice_hash[6] = die_6
end

#display the dice and send for testing
def roll_dice
  roll_sim
  test_roll($dice_hash.values)
end

#display the re-roll dice and send for testing
def re_roll_dice
  answer = ""

  until answer.downcase == "y" || answer.downcase == "n" do
    print "Would you like to re-roll the following dice: #{$dice_array}? (y/n) "
    answer = gets.chomp
  end

  if answer.downcase == 'y'
    $re_roll_array.clear

    $dice_hash.each do |key, value|
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

#simulate roll and print out the current state of dice hash
def roll_sim
  puts "..shake..shake..shake.."
  puts ""
  sleep 1.25
  $dice_hash.each do |key, value|
    print "#{value} "
    sleep 0.25
  end
end

#simulate re-roll and print out the current state of re-roll dice array
def re_roll_sim(re_roll_array)
  puts "..shake..shake..shake.."
  puts ""
  sleep 1.25
  re_roll_array.each do |value|
    print "#{value} "
    sleep 0.25
  end
end

#ask if re-roll all dice or quit turn and determine score
def keep_all_dice?
  answer = ""

  puts "Your running score for this roll is now #{$player_running_score}!!!"
  sleep 0.25
  until answer.downcase == "y" || answer.downcase == "n" do
    puts "Would you like to re-roll all dice (If not your current roll will be added to your score)? (y/n) "
    answer = gets.chomp
  end

  if answer == "y"
    new_dice
    roll_dice
  else
    end_and_score
  end
end