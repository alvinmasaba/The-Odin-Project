# frozen_string_literal: true

require_relative './board_square'

# Class to create gameboard object
class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board(board = [], position_board = [], row = 1)
    # Creates a 2 dimensional 8x8 array
    8.times do
      board << Array.new(8) { |col| [row, col + 1] }
      row += 1
    end

    board.each do |line|
      # Create a BoardSquare object for each set of coordinates in the row
      line.each { |pos| position_board << BoardSquare.new(pos) }
    end

    position_board
  end
end
