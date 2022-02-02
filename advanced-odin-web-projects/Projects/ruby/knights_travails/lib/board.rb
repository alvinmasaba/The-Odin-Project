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
    build_move_tree(knight.current_pos)
  end

  def knight_moves() end

  private

  def place_knight(position)
    @board.find { |sqr| sqr.coordinates == position }
  end

  def find_adjacent_moves(pos, depth)
    @board.each do |sqr|
      # Check that root points to the square
      next unless points_to?(pos.coordinates[0], pos.coordinates[1], sqr.coordinates[0], sqr.coordinates[1])

      pos.outgoing << sqr
      sqr.incoming << pos
      sqr.dist_from_pos += depth
    end
  end

  def build_move_tree(square, depth = 1)
    return if square == knight.current.pos && depth.positive?

    find_adjacent_moves(square, depth)
    square.outgoing.each { |child| build_move_tree(child, depth + 1) }
  end
end
