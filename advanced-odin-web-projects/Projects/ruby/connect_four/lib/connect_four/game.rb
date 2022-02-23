# frozen_string_literal: true

require_relative 'player'
require_relative 'helpers'

# class for playing a game of connect four
class Game
  include Helpers

  attr_accessor :player1, :player2, :board, :turn

  def initialize(rows = 6, cols = 7)
    @player1 = Player.new('Player 1')
    @player2 = Player.new('Player 2')
    @board = Array.new(rows) { Array.new(cols) { |_n| '#' } }
    @turn = player1
  end

  def drop_marker
    # Starting in reverse order, change the first empty space ('#')
    # to the marker, then break.
    puts 'Enter a valid column to drop your marker in: '
    col = gets.chomp.to_i

    if full_column?(col)
      puts 'This column is full. Please choose another column.'
      drop_marker
    else
      valid_column?(col) ? place_marker(col) : drop_marker
    end
  end

  def place_marker(col)
    board.reverse_each do |row|
      next unless row[col] == '#'

      row[col] = turn.marker
      break
    end
  end

  def full_column?(column)
    board.all? { |row| row[column] == turn.marker }
  end

  def full?
    board.all? { |row| row.none?('#') }
  end

  def change_turn
    @turn = @turn == player1 ? player2 : player1
  end

  def four_in_a_row?
    # Return whether any row in board when joined includes
    # 4 of a particular marker in a row.
    board.any? { |row| row.join.include?(turn.marker * 4) } 
  end

  def four_in_a_column?
    i = 0

    while i < board[0].size
      # Push to an empty array the value of each row for each given
      # index.
      col = []
      board.each { |row| col << row[i] }

      # Return true if it contains 4 adjacent identical markers
      # when joined.
      return true if col.join.include?(turn.marker * 4)

      i += 1
    end

    false
  end

  def four_diagonally?(arr = [])
    # Collect the [row, col] of each instance of a marker on the board.
    board.each_with_index do |row, idx|
      row.each_with_index do |value, col|
        arr << [idx, col] if value == turn.marker
      end
    end

    # For each coordinate in arr, find all its diagonal transformations.
    arr.each do |coord|
      TRANSFORMATIONS.each do |set|
        set = set.map { |t| [coord[0] + t[0], coord[1] + t[1]] }

        # For each diagonal, check to see if all of its coordinates are
        # included in arr, which indicates they have an identical marker.
        return true if set.all? { |e| arr.include?(e) }
      end
    end

    false
  end

  def finished?
    four_in_a_row? || four_in_a_column? || four_diagonally?
  end

  def play
    choose_markers

    until game_over?
      play_turn
      change_turn unless game_over?
    end

    puts "\nThanks for playing!"
  end

  def choose_markers
    @player1.choose_marker
    @player2.choose_marker
  end

  private

  def valid_column?(column)
    column.between?(0, board.size - 1)
  end
  
  def game_over?
    finished? || full?
  end

  def play_turn
    puts "It's #{turn.name}'s turn!"
    turn.drop_marker

    if finished?
      puts "\n#{turn.name} wins!"
    elsif full?
      puts "\nThe board is full. There is NO winner."
    end
  end

  def show_board
    puts "\n"
    @board.each do |row|
      puts row.join
    end
  end
end
