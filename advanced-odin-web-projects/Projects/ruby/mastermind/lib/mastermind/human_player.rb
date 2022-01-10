# frozen_string_literal: true

require_relative './player'
require 'io/console'

# Class for a human Mastermind player
class HumanPlayer < Player
  def initialize(game)
    super
    puts "\nPlayer please enter your name:"
    puts "\n"
    @name = gets.chomp
  end

  def secret_code
    puts "\n#{@name} it's time to make your secret code. Be sure to keep it hidden on a piece of paper!"
    puts "\nWhen prompted enter: #{(0..6).map { |i| "#{i} for #{@game.COLORS[i]}" }}"
    (1..4).map do |n|
      color = nil
      puts "\nEnter secret color ##{n}:"
      @game.COLORS[STDIN.noecho(&:gets).chomp.to_i]
    end
  end

  def input_guess
    puts "\n#{@name}, it's time to make your guess!"
    puts "\nWhen prompted enter: #{(0..6).map { |i| "#{i} for #{@game.COLORS[i]}" }}"
    (1..4).map do |n|
      puts "\nEnter guess ##{n}:\n"
      @game.COLORS[gets.chomp.to_i]
    end
  end
end
