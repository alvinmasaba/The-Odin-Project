# frozen_string_literal: true

# Class to create gameboard object
class Board
  attr_accessor :board

  def initialize
    @board = create_board
  end

  def create_board
    board = []
    row = 1

    8.times do
      board << Array.new(8) { |i| [row, i + 1] }
      row += 1
    end

    board
  end
end