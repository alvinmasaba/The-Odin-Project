# frozen_string_literal: true

require './lib/tic_tac_toe/game'
require './lib/tic_tac_toe/toe_helper'

describe Game do
  subject(:game_board) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary as its only creating
    # instance variables and calling methods.
  end

  describe '#choose_symbol' do
    context 'when a valid string is input' do
      # Symbol required in both before and it blocks
      valid_sym = '@'

      before do
        allow(game_board).to receive(:puts)
        allow(game_board).to receive(:gets).and_return(valid_sym)
      end

      it 'returns the string as a symbol' do
        sym = valid_sym.to_sym
        result = game_board.choose_symbol('player')
        expect(result).to eql(sym)
      end
    end

    context 'when an invalid string is input, then a valid input' do
      valid_sym = '$'

      before do
        allow(game_board).to receive(:puts)
        allow(game_board).to receive(:gets).and_return('#', valid_sym)
      end

      it 'returns only the valid input' do
        expected = valid_sym.to_sym
        result = game_board.choose_symbol('player')
        expect(result).to eql(expected)
      end
    end
  end

  describe '#enter_name' do
    valid_name = 'first name'
    invalid_name = '1234567891011'

    context 'when a valid name is input' do
      before do
        allow(game_board).to receive(:puts)
        allow(game_board).to receive(:gets).and_return(valid_name)
      end

      it 'returns the name' do
        result = game_board.enter_name('Player1')
        expect(result).to eql(valid_name)
      end
    end

    context 'when an invalid name is input twice' do
      before do
        allow(game_board).to receive(:puts)
        allow(game_board).to receive(:gets).and_return(invalid_name, invalid_name, valid_name)
      end

      it 'calls enter_name twice' do
        expect(game_board).to receive(:puts).with("Please enter a valid name\n\n").twice
        game_board.enter_name('Player1')
      end

      it 'returns only the valid name' do
        result = game_board.enter_name('Player1')
        expect(result).to eql(valid_name)
      end
    end
  end

  describe '#choose_names' do
    # No test necessary as it only calls enter_name which has been tested
  end

  describe '#set_symbols' do
    # No test necessary as it only calls choose_symbols which has been tested and change_turn
  end

  describe '#change_turn' do
    context 'when @turn == @player1' do
      it 'changes @turn to @player2' do
        game_board.player1 = 'Player 1'
        game_board.player2 = 'Player 2'
        game_board.turn = game_board.player1
        expect { game_board.change_turn }.to change { game_board.turn }.to(game_board.player2)
      end
    end

    context 'when @turn == @player2' do
      it 'changes @turn to @player1' do
        game_board.player1 = 'Player 1'
        game_board.player2 = 'Player 2'
        game_board.turn = game_board.player2
        expect { game_board.change_turn }.to change { game_board.turn }.to(game_board.player1)
      end
    end
  end
end
