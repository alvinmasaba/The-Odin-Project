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

  def points_to?(rtx, rty, sqrx, sqry)
    # A knight can move to [x +/- 1, y +/- 2] or [x +/- 2, y +/- 1]
    if sqrx.between?(rtx - 1, rtx + 1) && sqry.between?(rty - 2, rty + 2)
      true
    elsif sqrx.between?(rtx - 2, rtx + 2) && sqry.between?(rty - 1, rty + 1)
      true
    else
      false
    end
  end
end
