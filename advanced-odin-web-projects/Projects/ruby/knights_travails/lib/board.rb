# frozen_string_literal: true

require_relative './board/board_square'
require_relative './board/knights_module'
require_relative './board/knight'

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
    return unless valid_pos?(position)

    square = place_knight(position)
    square.contains_knight = true
    @knight = Knight.new(square)
  end

  private

  def place_knight(position)
    @board.find { |sqr| sqr.coordinates == position }
  end

  def find_moves(knight = @knight)
    # Make the current position the root
    root = knight.current_pos
    x = root.coordinates[0]
    y = root.coordinates[1]

    @board.each do |sqr|
      # Check if our root points to the square, if so, update incoming for square
      # and outgoing for the root.
      if points_to?(x, y, sqr.coordinates[0], sqr.coordinates[1])
        sqr.incoming << root
        root.outgoing << sqr
      end
    end
  end

end
