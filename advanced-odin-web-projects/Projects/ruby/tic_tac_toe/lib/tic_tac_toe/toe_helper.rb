# frozen_string_literal: true

module ToeHelper
  def check_rows(board, result = false)
    # Return true only if all values of a single row are 'X' or all 'O'
    board.each do |row|
      result = row.all? { |square| square == 'X' } ? true : result
      result = row.all? { |square| square == 'O' } ? true : result
    end

    result
  end

  def check_columns(board, result = false)
    # Return true only if all values of a single column are 'X' or all 'O'.

    (0..2).each do |n|
      sym = board[0][n]

      unless sym == '#'
        # Toggle 'result' to true only if all values of a single column match
        result = sym == board[1][n] && sym == board[2][n] ? true : result
      end
    end

    result
  end

  def check_diagonals(board)
    # Return true only if all values of a diagonal are 'X' or all 'O'
    
    sym_1 = board[0][0]
    sym_2 = board[0][2]

    unless sym_1 == '#'
      return true if sym_1 == board[1][1] && sym_1 == board[2][2]
    end

    unless sym_2 == '#'
      return true if sym_2 == board[1][1] && sym_2 == board[2][0]
    end

    false
  end

  def check_if_full(board)
    # Return true only if the board has no more spaces ('#')
    !board.join.include?('#')
  end
end
