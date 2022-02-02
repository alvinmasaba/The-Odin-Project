# frozen_string_literal: true

require_relative './knights_module'

class Board
  # Class to create knight object
  class Knight
    # mixin
    include Knights

    attr_accessor :current_pos

    def initialize(position = nil)
      @current_pos = position
      @moves = find_moves
    end

    # A function that builds a graph of all the moves a knight can make
    # starting from its position.
    def build_move_tree(root = @position)
      return if root == @position
    end

    def find_moves(position)
      moves = []

      # Push to moves [position[0] - 1, position[1] +/- 2]
      moves << [position[0] - 1, position[1] + 2]
      moves << [position[0] - 1, position[1] - 2]

      # Push to moves [position[0] + 1, position[1] +/- 2]
      moves << [position[0] + 1, position[1] + 2]
      moves << [position[0] + 1, position[1] - 2]

      # Push to moves [position[0] - 2, position[1] +/- 1]
      moves << [position[0] - 2, position[1] + 1]
      moves << [position[0] - 2, position[1] - 1]

      # Push to moves [position[0] + 2, position[1] +/- 1]
      moves << [position[0] + 2, position[1] + 1]
      moves << [position[0] + 2, position[1] - 1]

      moves.reject { |move| !move.between? }
    end
  end
end
