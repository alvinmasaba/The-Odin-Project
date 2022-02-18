# frozen_string_literal: true

module ToeHelper
  def check_rows(result = false)
    # Return true only if all values of a single row are 'X' or all 'O'
    board.each do |row|
      result = row.all? { |square| square == player1.symbol } ? true : result
      result = row.all? { |square| square == player2.symbol } ? true : result
    end

    result
  end

  def check_columns(result = false)
    # Return true only if all values of a single column are the same symbol
    (0..2).each do |n|
      sym = board[0][n]

      unless sym == '#'
        # Toggle 'result' to true only if all values of a single column match
        result = sym == board[1][n] && sym == board[2][n] ? true : result
      end
    end

    result
  end

  def check_diagonals
    # Return true only if all values of a diagonal are 'X' or all 'O'
    diagonals = [[board[0][0], board[1][1], board[2][2]],
                 [board[0][2], board[1][1], board[2][0]]]

    diagonals.any? do |diagonal|
      result = diagonal.uniq
      result.count == 1 unless result == ['#']
    end
  end

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
end
