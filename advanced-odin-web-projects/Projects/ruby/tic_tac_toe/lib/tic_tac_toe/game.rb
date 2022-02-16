# frozen_string_literal: true

require_relative 'toe_helper'

# Class for playing a game of tic-tac-toe
class Game
  include ToeHelper

  attr_reader :finished
  attr_accessor :turn, :player1, :player2, :p1_sym, :p2_sym

  def initialize
    intro
    @finished = false
    choose_names
    set_symbols
    @turn = @player1
    @board = Array.new(3) { |_n| ['#', '#', '#'] }
  end

  def update_board
    move = enter_position
    row = move[0]
    col = move[1]

    if valid_move?(row, col)
      @board[row][col] = @turn == @player1 ? p1_sym : p2_sym
    else
      puts "\nPlease enter a valid row and column."
      update_board
    end
  end

  def check_if_finished
    # If the game is finished, print the winner, else change the turn
    if finished?
      puts "#{@turn} wins!"
      @turn = "\nThe game is finished. #{@turn} won."
    elsif is_full?(@board)
      puts "\nIt's a tie!"
      @finished = true
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
    show_board
    until @finished
      puts "\n#{@turn} it's your turn. Enter the row and column you wish to
      place your mark separated by a comma:"
      update_board
      show_board
      check_if_finished
    end
  end

  def run
    play
  end

  private

  def intro
    puts <<~HEREDOC

      Welcome to TIC-TAC-TOE: command line version

      The rules are simple. There are two players.
      Each player will choose their symbol and take
      turns placing that symbol on the game board.

      A player can only place a symbol on an empty
      space, which looks like this: #.

      A symbol is placed by entering the row and
      column you would like to position it. The
      board positions are numbered like this:

                      0 1 2
                    0 # # #
                    1 # # #
                    2 # # #

      So, for example, in order to place your symbol
      in the middle space, you would enter 1,1. To
      place it on the top left square, you would enter
      0,0 etc...

      The first player to place three of their own
      symbol in a row, column, or diagonal wins the
      game.

      Have fun!

    HEREDOC
  end

  def choose_names
    puts "Player 1 please enter your name:\n\n"
    @player1 = gets.chomp
    puts "\nPlayer 2 please enter your name:\n\n"
    @player2 = gets.chomp
  end

  def choose_symbol(player)
    puts <<~HEREDOC

      #{player}, choose a symbol. Your symbol can be any char
      except a white-space or #.

    HEREDOC

    sym = gets.chomp

    # sym can be any non-whitespace character except #
    if /\S/.match(sym) && sym != '#' && sym.size == 1
      sym.to_sym
    else
      choose_symbol(player)
    end
  end

  def set_symbols
    @p1_sym = choose_symbol(@player1)
    @p2_sym = choose_symbol(@player2)
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
end
