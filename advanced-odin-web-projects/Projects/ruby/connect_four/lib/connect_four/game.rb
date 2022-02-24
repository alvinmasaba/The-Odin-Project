# frozen_string_literal: true

require_relative 'player'
require_relative 'constants'

# class for playing a game of connect four
class Game
  include Constants

  attr_accessor :player1, :player2, :board, :turn, :num_cols

  def initialize(rows = 6, cols = 7)
    @player1 = Player.new('Player 1')
    @player2 = Player.new('Player 2')
    @board = Array.new(rows) { Array.new(cols) { |_n| '#' } }
    @turn = player1
    @num_cols = cols
    intro
  end

  def drop_marker
    # Starting in reverse order, change the first empty space ('#')
    # to the marker, then break.
    puts "\nEnter a valid column to drop your marker in:"
    col = gets.chomp.to_i

    if full_column?(col)
      puts "\nThis column is full. Please choose another column."
      drop_marker
    else
      valid_column?(col) ? place_marker(col) : drop_marker
    end
  end

  def place_marker(col)
    board.reverse_each do |row|
      next unless row[col] == '#'

      row[col] = turn.marker
      break
    end
  end

  def full_column?(column)
    board.all? { |row| row[column] == turn.marker }
  end

  def full?
    board.all? { |row| row.none?('#') }
  end

  def change_turn
    @turn = @turn == player1 ? player2 : player1
  end

  def four_in_a_row?
    # Return whether any row in board when joined includes
    # 4 of a particular marker in a row.
    board.any? { |row| row.join.include?(turn.marker * 4) }
  end

  def four_in_a_column?
    i = 0

    while i < board[0].size
      # Push to an empty array the value of each row for each given
      # index.
      col = []
      board.each { |row| col << row[i] }

      # Return true if it contains 4 adjacent identical markers
      # when joined.
      return true if col.join.include?(turn.marker * 4)

      i += 1
    end

    false
  end

  def find_marker(arr = [])
    # Collect the [row, col] of each instance of a marker on the board.
    board.each_with_index do |row, idx|
      row.each_with_index do |value, col|
        arr << [idx, col] if value == turn.marker
      end
    end

    arr
  end

  def four_diagonally?
    arr = find_marker

    # For each coordinate in arr, find all its diagonal transformations.
    arr.each do |coord|
      TRANSFORMATIONS.each do |set|
        set = set.map { |t| [coord[0] + t[0], coord[1] + t[1]] }

        # For each diagonal, check to see if all of its coordinates are
        # included in arr, which indicates they have an identical marker.
        return true if set.all? { |e| arr.include?(e) }
      end
    end

    false
  end

  def finished?
    four_in_a_row? || four_in_a_column? || four_diagonally?
  end

  def play
    sleep(2)
    choose_markers
    show_board

    until game_over?
      play_turn
      change_turn unless game_over?
      show_board
      sleep(2)
    end

    puts "\nThanks for playing!"
  end

  def choose_markers
    @player1.choose_marker
    @player2.choose_marker
  end

  private

  def intro
    puts <<~HEREDOC
      Welcome to Connect Four. The rules are simple.
      Each player will first choose a marker, then
      take turns dropping that marker into the column
      of their choosing.

      The first player to connect four of their marker
      horizontally, vertically, or diagonally is the
      winner.

      Empty spaces are represented by '#' and the column
      numbers start at 0 increasing from left to right as
      follows:

      0   1   2   3   4   5   6
      # | # | # | # | # | # | #
      # | # | # | # | # | # | #
      # | # | # | # | # | # | #
      # | # | # | # | # | # | #
      # | # | # | # | # | # | #
      # | # | # | # | # | # | #

      The player who's turn it is will be prompted to enter
      a column. If the column is full, or not on the board,
      they will be prompted to enter a valid column.

      That's it! Have Fun!

    HEREDOC
  end

  def valid_column?(column)
    return false if column.nil? || !column.is_a?(Integer)

    column.between?(0, @num_cols - 1)
  end

  def game_over?
    finished? || full?
  end

  def play_turn
    puts "\nIt's #{turn.name}'s turn!"
    drop_marker

    if finished?
      puts "\n#{turn.name} wins!"
    elsif full?
      puts "\nThe board is full. There is NO winner."
    end
  end

  def show_board
    puts "\n"
    @board.each do |row|
      puts row.join(' | ')
    end
  end
end
