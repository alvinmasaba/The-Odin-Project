# frozen_string_literal: true

require_relative './knights_module'

class Board
  # Class representing a board position
  class BoardSquare
    # mixin
    include Knights

    attr_accessor :coordinates, :contains_knight

    def initialize(pos)
      @coordinate = valid_pos?(pos)
      @contains_knight = false
    end
  end
end
