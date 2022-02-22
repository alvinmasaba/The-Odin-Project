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
    # their marker.
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

    context 'when a filled column is chosen twice, then an unfilled one' do
      subject(:full_col) {described_class.new(6, 7) }
      other_marker = 'O'

      before do
        allow(full_col).to receive(:is_full?).and_return(true, true, false)
      end

      it 'prompts to enter a different column twice' do
        column = 3
        full_col.board.each { |row| row[column] = other_marker }
        expect(full_col).to receive(:puts).with('This column is full. Please choose another column.').twice
        full_col.drop_marker(marker, column)
      end
    end
  end

  # Check if column is full
  describe '#is_full?' do
    marker = "\u2600".encode('utf-8')

    context 'when column is full' do
      subject(:full_column) { described_class.new(6,7) }

      it 'returns true' do
        column = 5
        full_column.board.each { |row| row[column] = marker }
        result = full_column.is_full?(marker, column)
        expect(result).to be(true)
      end
    end

    context 'when column is partially filled' do
      subject(:partial_column) { described_class.new(10, 7) }

      it 'returns false' do
        column = 4
        partial_column.board[-1][column] = marker
        partial_column.board[-2][column] = marker
        partial_column.board[-3][column] = marker
        partial_column.board[-4][column] = marker

        result = partial_column.is_full?(marker, column)
        expect(result).to be(false)
      end
    end

    context 'when column is empty' do
      subject(:empty_column) { described_class.new(6,7) }

      it 'returns false' do
        column = 2
        result = empty_column.is_full?(marker, column)
        expect(result).to be(false)
      end
    end
  end 

  describe '#change_turn' do
    context 'when it is Player 1\'s turn' do
      subject(:player1_turn) { described_class.new }

      it 'changes turn to Player 2' do
        player1_turn.change_turn
        turn = player1_turn.turn
        expect(turn).to eql(player1_turn.player2)
      end
    end

    context 'when it is Player 2\'s turn' do
      subject(:player2_turn) { described_class.new }

      it 'changes turn to Player 1' do
        player2_turn.turn = player2_turn.player2
        player2_turn.change_turn
        turn = player2_turn.turn
        expect(turn).to eql(player2_turn.player1)
      end
    end
  end

  # 
end

describe Player do
end
