# frozen_string_literal: true

# Class representing a board position
class BoardSquare
  attr_accessor :pos

  def initialize(pos)
    if pos.all? { |n| n.between?(1, 8) && pos.size == 2 } 
      @pos = pos
    else
      puts "Invalid position."
      nil
    end
  end
end

