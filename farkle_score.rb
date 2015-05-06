require './farkle_rules'
require './farkle_dice'

def end_and_score
  if $farkle
    $player_running_score = 0
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