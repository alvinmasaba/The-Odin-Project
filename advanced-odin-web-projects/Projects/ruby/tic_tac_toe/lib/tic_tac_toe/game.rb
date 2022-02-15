# frozen_string_literal: true

require 'toe_helper'

# Class for playing a game of tic-tac-toe
class Game
  include ToeHelper

  attr_reader :finished
  attr_accessor :turn

  def initialize
    @finished = false
    puts 'Player 1 enter your name: '
    @player1 = gets.chomp
    puts 'Player 2 enter your name: '
    @player2 = gets.chomp
    @turn = @player1
    @board = Array.new(3) { |_n| ['#', '#', '#'] }
    puts "\nCall #yourgame.play to start the game."
  end

  def update_board
    puts "\n"
    move = gets.chomp.split(',')
    row = move[0].to_i
    col = move[1].to_i

    # A move is valid when the row and column are between 1,3
    # and the prospective square is empty
    if (row.between?(1, 3) && col.between?(1, 3)) && (@board[row - 1][col - 1] == '#')
      @board[row - 1][col - 1] = @turn == @player1 ? 'X' : 'O'
    else
      puts "\nPlease enter a valid row and column."
      update_board
    end
  end

  def check_if_finished
    @finished = (check_rows(@board) || check_columns(@board) || check_diagonals(@board))
    # If the game is finished, print the winner, else change the turn
    if @finished
      puts "#{@turn} wins!"
      @turn = "\nThe game is finished. #{@turn} won."
    elsif check_if_full(@board)
      puts "\nIt's a tie!"
      @finished = true
      @turn = "\nThe game finished in a tie."
    else
      @turn = @turn == @player1 ? @player2 : @player1
    end
  end

  def show_board
    puts "\n"
    @board.each { |row| p row.join }
  end

  def play
    show_board
    until @finished
      puts "\n#{@turn} it's your turn. Enter the row and column you wish to place your mark separated by a comma:"
      update_board
      show_board
      check_if_finished
    end
  end

  def run
    play
  end
end
