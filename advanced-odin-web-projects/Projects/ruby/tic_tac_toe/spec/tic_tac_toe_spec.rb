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
    # No test necessary as it only calls enter_name which has been tested.
  end

  describe '#set_symbols' do
    # No test necessary as it only calls choose_symbols and change_turn which
    # have been tested.
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

  describe '#show_board' do
    # No tests necessary as it only contains puts.
  end

  describe '#place_symbol' do
    symbol = 'X'
    subject(:game_symbol) { described_class.new }

    context 'when player1 inputs a valid move' do
      move = [0, 0]

      before do
        allow(game_symbol).to receive(:enter_position).and_return(move)
        allow(game_symbol).to receive(:valid_move?).and_return(true)
        allow(game_symbol).to receive(:<=>).and_return(true)
      end

      it "it changes the value of board at the position to the player's symbol" do
        game_symbol.p1_sym = symbol
        game_symbol.place_symbol
        result = game_symbol.board[move[0]][move[1]]
        expect(result).to eql(symbol)
      end
    end

    context 'when player1 inputs an invalid move twice' do
      move1 = [9, 8]
      move2 = [7, 88]
      move3 = [1, 1]

      before do
        allow(game_symbol).to receive(:enter_position).and_return(move1, move2, move3)
        allow(game_symbol).to receive(:valid_move?).and_return(false, false, true)
        allow(game_symbol).to receive(:<=>).and_return(true)
      end

      it 'prompts to enter a valid move twice' do
        expect(game_symbol).to receive(:puts).with("\nPlease enter a valid row and column.").twice
        game_symbol.place_symbol
      end

      it "it changes the value of board at the position to the player's symbol" do
        game_symbol.p1_sym = symbol
        game_symbol.place_symbol
        result = game_symbol.board[move3[0]][move3[1]]
        expect(result).to eql(symbol)
      end
    end
  end

  describe '#finished?' do
    subject(:finished_game) {described_class.new }

    context 'when there is a full row of like symbols' do
      it 'returns true' do
        finished_game.board[0] = %i[x x x]
        expect(finished_game).to be_finished
      end
    end
  end
end
