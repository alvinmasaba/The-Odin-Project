# frozen_string_literal: true

require 'time'
require_relative './hangman/game'

puts "

Welcome to the Hangman Console Game

# Game instructions

If you would like to start a new game press [1].
If you would like to load a saved game press [2].

"

def show_saved_games(games)
  puts "
Saved Games:
  "
  games.each_with_index do |fname, i|
    puts "#{i + 1}: #{fname}
    "
  end

  puts "Enter the number of the game you would like to load.
  "
end

def check_for_saved_games
  if Dir.exist?('saved_games') && !Dir.empty?('saved_games/*')
    saved_games = Dir.glob('saved_games/*')
    show_saved_games(saved_games)
    saved_game = gets.chomp.to_i - 1
    game = Game.new
    game.load(saved_games[saved_game])

  else
    puts "You don't have any saved games. Starting a new game."
    Game.new
  end
end

def pick_game
  case gets.chomp
  when '1'
    game = Game.new
  when '2'
    game = check_for_saved_games
  else
    puts "\nPlease enter 1 or 2:"
    game = pick_game
  end

  game
end

game = pick_game
game.play_game
