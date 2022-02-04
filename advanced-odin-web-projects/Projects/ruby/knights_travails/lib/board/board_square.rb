# frozen_string_literal: true

require_relative './knights_module'

# Class representing a board position
class BoardSquare
  # mixin
  include Knights

  attr_accessor :location, :children

  TRANSFORMATIONS = [[1, 2], [-2, -1], [-1, 2], [2, -1],
                     [1, -2], [-2, 1], [-1, -2], [2, 1]].freeze

  def initialize(pos)
    @location = pos
    @children = find_children
  end

  def find_children
    TRANSFORMATIONS.map { |t| [@location[0] + t[0], @location[1] + t[1]] }
                   .select { |e| valid_pos?(e) }
  end
end
