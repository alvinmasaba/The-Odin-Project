# frozen_string_literal: true

# Class to create knight object
class Knight
  attr_accessor :position, :moves

  def initialize(position)
    if position.all? { |n| n.between?(1, 8) && position.size == 2 } 
      @position = position
    else
      @position = [4,4]
      puts "Invalid position, placing knight at the middle of the board (4,4)."
    end

    @moves = find_moves
  end

  def find_moves
    moves = []

    # Push to moves [position[0] - 1, position[1] +/- 2]
    moves << [@position[0] - 1, @position[1] + 2]
    moves << [@position[0] - 1, @position[1] - 2]

    # Push to moves [position[0] + 1, position[1] +/- 2]
    moves << [@position[0] + 1, @position[1] + 2]
    moves << [@position[0] + 1, @position[1] - 2]

    # Push to moves [position[0] - 2, position[1] +/- 1]
    moves << [@position[0] - 2, @position[1] + 1]
    moves << [@position[0] - 2, @position[1] - 1]

    # Push to moves [position[0] + 2, position[1] +/- 1]
    moves << [@position[0] + 2, @position[1] + 1]
    moves << [@position[0] + 2, @position[1] - 1]

    moves.reject { |move| !move.between?
  end
end
