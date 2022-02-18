# frozen_string_literal: true

module ToeHelper
  def check_rows(game, result = false)
    # Return true only if all values of a single row are 'X' or all 'O'
    game.board.each do |row|
      result = row.all? { |square| square == game.player1.symbol } ? true : result
      result = row.all? { |square| square == game.player2.symbol } ? true : result
    end

    result
  end

  def check_columns(game, result = false)
    # Return true only if all values of a single column are the same symbol
    board = game.board

    (0..2).each do |n|
      sym = board[0][n]

      unless sym == '#'
        # Toggle 'result' to true only if all values of a single column match
        result = sym == board[1][n] && sym == board[2][n] ? true : result
      end
    end

    result
  end

  def check_diagonals(game)
    # Return true only if all values of a diagonal are 'X' or all 'O'
    board = game.board
    player = game.turn
    diagonals = [[board[0][0], board[1][1], board[2][2]],
                 [board[0][2], board[1][1], board[2][0]]]

    full = Array.new(3) { player.symbol }

    diagonals.any? { |diagonal| diagonal == full }
  end

  def full?(board)
    # Return true only if the board has no more spaces ('#')
    !board.join.include?('#')
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
