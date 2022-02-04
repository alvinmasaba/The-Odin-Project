# frozen_string_literal: true

# Multi-class helper functions
module Knights
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
