# frozen_string_literal: true

# Class for players
class Player
  attr_reader :name
  attr_accessor :points, :is_code_maker, :is_code_breaker, :game, :first_guess

  def initialize(game)
    @game = game
    @points = 0
    @is_code_maker = false
    @is_code_breaker = false
    @first_guess = true
  end
end
