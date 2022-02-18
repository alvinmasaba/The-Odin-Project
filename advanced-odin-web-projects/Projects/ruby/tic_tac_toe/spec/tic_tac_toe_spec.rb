# frozen_string_literal: true

require './lib/tic_tac_toe/game'
require './lib/tic_tac_toe/toe_helper'

describe Game do
  subject(:game_board) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary as its only creating
    # instance variables and calling methods.
  end

  describe '#change_turn' do
    subject(:game_turn) { described_class.new }

    context 'when @turn == @player1' do
      it 'changes @turn to @player2' do
        game_turn.turn = game_turn.player1
        player2 = game_turn.player2
        expect { game_turn.change_turn }.to change { game_turn.turn }.to(player2)
      end
    end

    context 'when @turn == @player2' do
      it 'changes @turn to @player1' do
        game_turn.turn = game_turn.player2
        player1 = game_turn.player1
        expect { game_turn.change_turn }.to change { game_turn.turn }.to(player1)
      end
    end
  end

  describe '#show_board' do
    # No tests necessary as it only contains puts.
  end

  describe '#place_symbol' do
    subject(:game_symbol) { described_class.new }
    let(:random_player) { instance_double(Player, name: 'Alvin', symbol: :X) }

    context 'when player1 inputs a valid move' do
      move = [0, 0]

      before do
        allow(game_symbol).to receive(:enter_position).and_return(move)
      end

      it "it changes the value at the position to the player's symbol" do
        game_symbol.turn = random_player
        game_symbol.place_symbol
        result = game_symbol.board[move[0]][move[1]]
        expect(result).to eql(random_player.symbol)
      end
    end

    context 'when player inputs an invalid move twice' do
      move1 = [9, 8]
      move2 = [7, 88]
      move3 = [1, 1]

      before do
        allow(game_symbol).to receive(:enter_position).and_return(move1, move2, move3)
      end

      it 'prompts to enter a valid move twice' do
        game_symbol.turn = random_player
        expect(game_symbol).to receive(:puts).with("\nPlease enter a valid row and column.").twice
        game_symbol.place_symbol
      end

      it "it changes the value of board at the position to the player's symbol" do
        game_symbol.turn = random_player
        game_symbol.place_symbol
        result = game_symbol.board[move3[0]][move3[1]]
        expect(result).to eql(random_player.symbol)
      end
    end
  end

  describe '#finished?' do
    subject(:finished_game) { described_class.new }

    context 'when there is a full row of like symbols' do
      it 'returns true' do
        finished_game.turn = finished_game.player1
        x = finished_game.player1.symbol
        finished_game.board[0] = [x, x, x]

        expect(finished_game).to be_finished
      end
    end

    context 'when there is a partially filled row of like symbols' do
      it 'returns false' do
        finished_game.turn = finished_game.player1
        x = finished_game.player1.symbol
        finished_game.board[0] = [x, x, '#']

        expect(finished_game).to_not be_finished
      end
    end

    context 'when there is a full column of like symbols' do
      it 'returns true' do
        finished_game.turn = finished_game.player1
        x = finished_game.player1.symbol

        finished_game.board[0][1] = x
        finished_game.board[1][1] = x
        finished_game.board[2][1] = x

        expect(finished_game).to be_finished
      end
    end

    context 'when there is a partially filled column' do
      it 'returns false' do
        finished_game.turn = finished_game.player1
        x = finished_game.player1.symbol

        finished_game.board[0][1] = x
        finished_game.board[1][1] = '#'
        finished_game.board[2][1] = x

        expect(finished_game).to_not be_finished
      end
    end

    context 'when there is a full diagonal of like symbols' do
      it 'returns true' do
        finished_game.turn = finished_game.player1
        x = finished_game.player1.symbol

        finished_game.board[0][0] = x
        finished_game.board[1][1] = x
        finished_game.board[2][2] = x

        expect(finished_game).to be_finished
      end
    end

    context 'when there is a partially filled diagonal' do
      it 'returns false' do
        finished_game.turn = finished_game.player1
        x = finished_game.player1.symbol

        finished_game.board[0][0] = :O
        finished_game.board[1][1] = '#'
        finished_game.board[2][2] = x

        expect(finished_game).to_not be_finished
      end
    end
  end
end

describe Player do
  subject(:new_player) { described_class.new }

  describe '#choose_symbol' do
    context 'when a valid string is input' do
      # Symbol required in both before and it blocks
      valid_sym = '@'

      before do
        allow(new_player).to receive(:puts)
        allow(new_player).to receive(:gets).and_return(valid_sym)
      end

      it 'returns the string as a symbol' do
        new_player.choose_symbol
        result = new_player.symbol
        expect(result).to eql(valid_sym.to_sym)
      end
    end

    context 'when an invalid string is input, then a valid input' do
      valid_sym = '$'

      before do
        allow(new_player).to receive(:puts)
        allow(new_player).to receive(:gets).and_return('#', valid_sym)
      end

      it 'returns only the valid input' do
        new_player.choose_symbol
        result = new_player.symbol
        expect(result).to eql(valid_sym.to_sym)
      end
    end
  end
end
