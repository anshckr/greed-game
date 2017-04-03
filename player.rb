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
      num_rolling_dice = dice.non_scoring
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
      input_taken = false
      quit = false
      user_choice = gets.chomp
      while !input_taken
        if user_choice == "y"
          input_taken = true
          quit = false
        elsif user_choice == "n"
          input_taken = true
          quit = true
          puts
        else
          input_taken = false
          quit = false
          print "Sorry only y/n are accepted, please re-enter: "
          user_choice = gets.chomp
        end
      end
      break if quit
    end
    return turn_score
  end
end
