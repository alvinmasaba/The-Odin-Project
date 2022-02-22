# frozen_string_literal: true

require './lib/connect_four/game'
require './lib/connect_four/player'

describe Game do
  subject(:game_board) { described_class.new(9, 7) }

  describe '#initialize' do
    # Creates a board of a specified size.
    it 'has 9 rows' do
      expect(game_board.board.size).to eql(9)
    end

    it 'has 7 spaces in each row' do
      board = game_board.board
      result = board.all? { |row| row.size == 7 }
      expect(result).to be(true)
    end
  end

  describe '#drop_marker' do
    # When drop_marker is called, a player picks a column to place
    # their symbol.
    marker = "\u2600".encode('utf-8')

    context 'when the column is empty' do
      subject(:empty_col) { described_class.new(6, 7) }

      it 'places the marker in the lowest row of the chosen column' do
        column = 3
        empty_col.drop_marker(marker, column)
        result = empty_col.board[-1][column]
        expect(result).to eql(marker)
      end
    end

    context 'when there are 2 makers already in the column' do
      subject(:nonempty_col) {described_class.new(6, 7) }

      it 'places the marker in the 3rd lowest row' do
        column = 3
        nonempty_col.board[-1][3] = marker
        nonempty_col.board[-2][3] = marker

        nonempty_col.drop_marker(marker, column)
        result = nonempty_col.board[-3][column]
        expect(result).to eql(marker)
      end
    end

    context 'when column is full' do
      subject(:full_col) {described_class.new(6, 7) }
      other_marker = 'O'

      it 'does not place the marker in the column' do
        column = 3
        full_col.board.each { |row| row[column] = other_marker }
        full_col.drop_marker(marker, column)

        result = full_col.board.any? { |row| row[column] == marker }
        expect(result).to be(false) and expect(full_col.board[0][column]).to eql(other_marker)
      end
    end
  end
end

describe Player do
end
