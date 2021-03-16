require_relative 'connect_4_game'

def game_start
  game = Game.new
  puts 'Player 1 enter name enter name'
  player1 = Player.new(gets.chomp, 'Y')
  puts 'Player 2 enter name enter name'
  player2 = Player.new(gets.chomp, 'R')
  game.play_game(player1, player2)
end
game_start
