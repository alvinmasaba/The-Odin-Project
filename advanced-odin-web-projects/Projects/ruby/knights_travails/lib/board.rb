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
    @knight = nil
  end

  def create_board(board = [], position_board = [], row = 1)
    # Creates a 2 dimensional 8x8 array
    8.times do
      board << Array.new(8) { |col| [row, col + 1] }
      row += 1
    end

    # Creates a BoardSquare object for each set of coordinates in each row
    board.each do |line|
      line.each { |pos| position_board << BoardSquare.new(pos) }
    end

    position_board
  end

  def knight_moves(src, dest, queue = [], visited = [])
    return nil unless valid_pos?(src) && valid_pos?(dest)

    og_src = src

    until src == dest
      # Push src to visited
      src = find_board_square(src)
      visited << src.location

      # Check if any of its children match dest
      if check_for_match(src.children, dest)
        src = dest
      else
        src.children.each { |child| queue << child }
        src = queue.shift
      end
    end

    path = find_path(og_src, dest, visited)
    puts "You made it in #{path.size - 1} moves. Here's your path:

    #{path.each { |location| p location }}"
  end

  private

  def find_path(src, loc, visited, path = [])
    until src == loc
      # Prepend location to path
      path.unshift loc

      # Find its parent node
      loc = visited.find do |sqr|
        find_board_square(sqr).children.include?(loc)
      end
    end

    path.unshift loc
  end

  def find_board_square(position)
    @board.find { |sqr| sqr.location == position }
  end

  def check_for_match(children, dest)
    children.find { |child| child == dest }
  end
end
