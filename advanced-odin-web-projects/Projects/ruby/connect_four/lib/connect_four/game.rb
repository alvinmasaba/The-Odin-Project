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

  def drop_marker(marker, column)
    # Starting in reverse order, change the first empty space ('#')
    # to the marker, then break.

    if is_full?(marker, column)
      puts 'This column is full. Please choose another column.'
      drop_marker(marker, column)
    else
      board.reverse_each do |row|
        next unless row[column] == '#'
        
        row[column] = marker
        break
      end
    end
  end

  def is_full?(marker, column)
    board.all? { |row| row[column] == marker }
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
end