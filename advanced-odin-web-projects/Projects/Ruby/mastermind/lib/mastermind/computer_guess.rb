# frozen_string_literal: true

# Created when computer is the code breaker
class ComputerGuess
  attr_accessor :game

  def initialize(game)
    @game = game
  end

  def cpu_guess
    (1..4).map { COLORS.sample }
  end
end  
