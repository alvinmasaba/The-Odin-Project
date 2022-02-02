# frozen_string_literal: true

# Class representing a board position
class BoardSquare
  attr_accessor :position, :contains_knight

  def initialize(pos)
    @position = valid_pos?(pos)
    @contains_knight = false
  end

  def valid_pos?(arr)
    # Return arr if it contains exactly 2 integers which are both between 1 and 8.
    if arr.size == 2
      arr if arr.all? { |n| n.between?(1, 8) }
    else
      puts 'Invalid position.'
      nil
    end
  end
end
