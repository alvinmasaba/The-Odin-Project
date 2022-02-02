# frozen_string_literal: true

require_relative './knights_module'

class Board
  # Class representing a board position
  class BoardSquare
    # mixin
    include Knights

    attr_accessor :coordinates, :contains_knight, :incoming, :outgoing, :dist_from_pos

    def initialize(pos)
      @coordinates = valid_pos?(pos)
      @contains_knight = false
      @incoming = []
      @outgoing = []
      @dist_from_pos = 0
    end
  end
end
