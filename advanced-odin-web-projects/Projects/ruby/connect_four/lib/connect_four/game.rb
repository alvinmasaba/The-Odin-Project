# frozen_string_literal: true

require_relative 'player'

# class for playing a game of connect four
class Game
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
end