# frozen_string_literal: true

# Game methods and instance for connect 4
class Game
  def initialize
    @board = [%w[O O O O O O],
              %w[O O O O O O],
              %w[O O O O O O],
              %w[O O O O O O],
              %w[O O O O O O],
              %w[O O O O O O],
              %w[O O O O O O]]
  end
  # Possible lines containing a win condition cartesian coordinates of points due to set up of @board
  # Generated using methods in connect_4_win.rb
  HORIZONTAL_LINES = [
    [[0, 0], [1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [6, 0]],
    [[0, 1], [1, 1], [2, 1], [3, 1], [4, 1], [5, 1], [6, 1]],
    [[0, 2], [1, 2], [2, 2], [3, 2], [4, 2], [5, 2], [6, 2]],
    [[0, 3], [1, 3], [2, 3], [3, 3], [4, 3], [5, 3], [6, 3]],
    [[0, 4], [1, 4], [2, 4], [3, 4], [4, 4], [5, 4], [6, 4]],
    [[0, 5], [1, 5], [2, 5], [3, 5], [4, 5], [5, 5], [6, 5]],
    [[0, 6], [1, 6], [2, 6], [3, 6], [4, 6], [5, 6], [6, 6]]
  ].freeze
  VERTICAL_LINES = [*0..6].freeze
  DIAGONAL_LINES = [
    [[3, 0], [4, 1], [5, 2], [6, 3]],
    [[2, 0], [3, 1], [4, 2], [5, 3], [6, 4]],
    [[1, 0], [2, 1], [3, 2], [4, 3], [5, 4], [6, 5]],
    [[0, 0], [1, 1], [2, 2], [3, 3], [4, 4], [5, 5]],
    [[0, 1], [1, 2], [2, 3], [3, 4], [4, 5]],
    [[0, 2], [1, 3], [2, 4], [3, 5]],
    [[0, 3], [1, 2], [2, 1], [3, 0]],
    [[0, 4], [1, 3], [2, 2], [3, 1], [4, 0]],
    [[0, 5], [1, 4], [2, 3], [3, 2], [4, 1], [5, 0]],
    [[1, 5], [2, 4], [3, 3], [4, 2], [5, 1], [6, 0]],
    [[2, 5], [3, 4], [4, 3], [5, 2], [6, 1]],
    [[3, 5], [4, 4], [5, 3], [6, 2]]
  ].freeze
  def place_piece(column, player)
    i = @board[column].index('O')
    return false if i.nil?

    @board[column][i] = player.symbol unless i.nil?
  end

  def check_win(player)
    vertical = check_vertical(player)
    return true if vertical.true?

    horizontal = check_horizontal(player)
    return true if horizontal.true?

    diagonal = check_diagonal(player)
    return true if diagonal.true?

    false
  end

  def check_vertical(player)
    VERTICAL_LINES.each do |column|
      if @board[column].join.include?("#{player.symbol}#{player.symbol}#{player.symbol}#{player.symbol}")
        @winner = player
        return true
      end
    end
    false
  end

  def check_horizontal(player)
    HORIZONTAL_LINES.each do |array|
      line = []
      array.each { |coordinate| line << @board[coordinate[0]][coordinate[1]] }
      if line.join.include?("#{player.symbol}#{player.symbol}#{player.symbol}#{player.symbol}")
        @winner = player
        return true
      end
    end
    false
  end

  def check_diagonal(player)
    DIAGONAL_LINES.each do |array|
      line = []
      array.each { |coordinate| line << @board[coordinate[0]][coordinate[1]] }
      if line.join.include?("#{player.symbol}#{player.symbol}#{player.symbol}#{player.symbol}")
        @winner = player
        return true
      end
    end
    false
  end

  def check_piece (player)
    loop do
      puts 'Enter column to place your piece'
      break if place_piece(gets.chomp, player)

      puts 'Invalid column or column is full please enter column'
    end
  end

  def print_board
    HORIZONTAL_LINES.reverse.each do |array|
      output = []
      array.each { |coordinate| output << @board[coordinate[0]][coordinate[1]] }
      puts output.join(' ')
    end
  end
end

class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

