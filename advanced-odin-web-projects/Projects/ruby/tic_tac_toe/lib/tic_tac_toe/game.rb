# frozen_string_literal: true

require_relative 'toe_helper'

# class for playing a game of tic-tac-toe
class Game
  include ToeHelper

  attr_accessor :turn, :player1, :player2, :p1_sym, :p2_sym

  def initialize
    # intro
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

  def choose_symbol(player)
    puts <<~HEREDOC

      #{player}, choose a symbol. Your symbol can be any char
      except a white-space or #.

    HEREDOC

    sym = gets.chomp until valid_symbol?(sym)
    sym.to_sym
  end

  def enter_name(player)
    puts "#{player} please enter your name (max: 10 chars):\n\n"
    name = gets.chomp

    if name.size <= 10
      name
    else
      puts "Please enter a valid name\n\n"
      name = enter_name(player)
    end

    name
  end

  def change_turn
    @turn = @turn == @player1 ? @player2 : @player1
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
    @player1 = enter_name('Player 1')
    @player2 = enter_name('Player 2')
  end

  def set_symbols
    @p1_sym = choose_symbol(@player1)
    change_turn
    @p2_sym = choose_symbol(@player2)
    change_turn
  end

  def valid_symbol?(sym)
    # sym can be any non-whitespace character except '#'
    if /\S/.match(sym) && sym != '#' && sym.size == 1
      true
    else
      false
    end
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

  def finished?
    # Returns true if a player has a full row, column, or diagonal
    check_rows(@board) || check_columns(@board) || check_diagonals(@board)
  end
end
