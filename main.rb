require './game.rb'

print "Enter number of players: "
num = gets.chomp
while !(num.match(/[0-9]+/) && num.to_i >=2)
  print "Input should be an integer greater than 2, please re-enter: "
  num = gets.chomp
end
game = Game.new(num.to_i)
game.play_game
