require './player.rb'

class Game
  attr_reader :score_board

  def initialize(num_of_players)
    @turn = 1
    @score_board = Hash.new(0)
    @players = num_of_players.times.map { |i|
      Player.new(i + 1)
    }
  end

  def play_game
    play_round
    while top_score < 3000
      play_round
    end
    puts "Final Round"
    play_round(true)
    display_score_board
    display_toppers
    puts "--------------"
  end

  def display_score_board
    sort_score_board.each { |player, score| puts "Player #{player.id} --> #{score}" }
    puts
  end

  def display_toppers
    top_players = top_scorers
    puts "Player #{top_players[0]} wins the game" if top_players.size < 1
    puts "Players #{top_players.join(', ')} win the game" if top_players.size > 1
  end

  private

  def play_round(final_round = false)
    puts "Turn #{@turn}: " unless final_round
    puts "--------"
    @players.each { |player|
      player_score = player.play_turn
      total_score = @score_board[player] + player_score
      @score_board[player] = total_score >= 300 ? total_score : 0
    }
    @turn += 1
  end

  def sort_score_board
    @score_board.sort { |a1, a2| a2[1] <=> a1[1] }
  end

  def top_scorers
    top_players = []
    sort_score_board.each { |player, score|
      break if score < top_score
      top_players << player.id
    }
    top_players
  end

  def top_score
    sort_score_board[0][1]
  end
end
