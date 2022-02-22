# frozen_string_literal: true

require_relative 'player'

# class for playing a game of connect four
class Game
  attr_accessor :player1, :player2, :board

  def initialize(player1 = Player.new('Player 1'), player2 = Player.new('Player 2'), board = nil)
    @player1 = player1
    @player2 = player2
    @board = board
  end
end