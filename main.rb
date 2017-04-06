require './game.rb'

print "Enter number of players: "
num = gets.chomp.to_i
while !(num >=2 && num.to_s.match(/[0-9]+/))
  print "Input should be an integer greater than 2, please re-enter: "
  num = gets.chomp.to_i
end
game = Game.new(num)
game.play_game
