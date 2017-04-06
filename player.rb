require './dice_set.rb'

class Player
  attr_reader :id

  def initialize(id)
    @id = id
  end

  def play_turn
    turn_score = 0
    num_rolling_dice = 5
    dice = DiceSet.new

    while num_rolling_dice > 0
      print "Player #{id} rolls: "
      dice.roll(num_rolling_dice)
      dice.display_dice_values
      current_score = dice.score
      num_rolling_dice = dice.num_non_scoring
      puts "Score in this round: #{current_score}"
      if current_score == 0
        turn_score = 0
        num_rolling_dice = 5
        puts
        break
      else
        turn_score += current_score
      end
      puts "Total score: #{turn_score}"
      num_rolling_dice = 5 if num_rolling_dice == 0
      print "Roll all 5 dices again? (y/n): " if num_rolling_dice == 5
      print "Do you want to roll the non-scoring #{num_rolling_dice} dice? (y/n): " if num_rolling_dice < 5
      while true
        case gets.chomp
        when "y"
          quit = false
          break
        when "n"
          quit = true
          break
        else
          print "Sorry only y/n are accepted, please re-enter: "
          next
        end
      end
      break if quit
    end
    return turn_score
  end
end
