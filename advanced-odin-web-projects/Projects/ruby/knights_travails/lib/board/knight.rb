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
    end

    # A function that builds a graph of all the moves a knight can make
    # starting from its position.
    def build_move_tree(root = @position)
      return if root == @position
    end
  end
end
