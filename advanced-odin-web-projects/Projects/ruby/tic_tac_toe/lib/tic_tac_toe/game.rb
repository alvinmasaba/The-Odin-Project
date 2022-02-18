# frozen_string_literal: true

require_relative 'toe_helper'
require_relative 'player'

# class for playing a game of tic-tac-toe
class Game
  include ToeHelper

  attr_accessor :turn, :player1, :player2, :board

  def initialize
    # intro
    @player1 = Player.new('Player 1')
    @player2 = Player.new('Player 2')
    @board = Array.new(3) { |_n| ['#', '#', '#'] }
  end

  def place_symbol
    move = enter_position
    row = move[0]
    col = move[1]

    if valid_move?(row, col)
      @board[row][col] = @turn == @player1 ? p1_sym : p2_sym
    else
      puts "\nPlease enter a valid row and column."
      place_symbol
    end
  end

  def check_if_finished
    # If the game is finished, print the winner, else change the turn
    if finished?
      puts "#{@turn} wins!"
      @turn = "\nThe game is finished. #{@turn} won."
    elsif is_full?(@board)
      puts "\nIt's a tie!"
    else
      change_turn
    end
  end

  def show_board
    puts "\n"
    @board.each do |row|
      puts row.join
    end
  end

  def play
    choose_names
    @turn = @player1
    set_symbols
    show_board
    play_turn until finished?
  end

  def play_turn
    puts <<~HEREDOC

      #{@turn} it's your turn. Enter the row and column you wish to
      place your mark separated by a comma:"

    HEREDOC

    place_symbol
    show_board
    check_if_finished
  end

  def run
    play
  end

  def change_turn
    @turn = @turn == @player1 ? @player2 : @player1
  end

  def finished?
    # Returns true if a player has a full row, column, or diagonal
    if check_rows(@board) || check_columns(@board) || check_diagonals(@board)
      true
    else
      false
    end
  end

  private

  def create_players
    choose_name_symbol(@player1)
    choose_name_symbol(@player2)
  end

  def choose_name_symbol(player)
    player.enter_name
    player.choose_symbol
  end


  def valid_move?(row, col)
    # As both conditions must be true to return true, return false if the first
    # condition fails. Otherwise, evaluate and return the result of the second
    # condition.

    # A move is valid when the row and column are between 0,2.
    return false unless row.between?(0, 2) && col.between?(0, 2)

    # And the prospective square is empty.
    @board[row][col] == '#'
  end

  def enter_position
    puts "\n"
    move = gets.chomp.split(',')
    row = move[0].to_i
    col = move[1].to_i

    # Returns an array containing the entered row and column.
    [row, col]
  end
end
