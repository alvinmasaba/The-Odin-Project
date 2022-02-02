# frozen_string_literal: true

require_relative './board/board_square'
require_relative './board/knights_module'

# Class to create gameboard object
class Board
  include Knights

  attr_accessor :board, :knight

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

  def create_knight(position)
    # If the given position is valid, create a new knight with its current position
    # set to the board square with matching coordinates.
    @knight = Knight.new(place_knight(position)) if valid_pos?(position)
  end

  private

  def place_knight(position)
    @board.find { |sqr| sqr.coordinates == position }
  end
end
