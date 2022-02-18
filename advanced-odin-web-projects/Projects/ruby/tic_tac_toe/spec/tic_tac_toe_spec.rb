# frozen_string_literal: true

require './lib/tic_tac_toe/game'
require './lib/tic_tac_toe/toe_helper'

describe Game do
  subject(:game_board) { described_class.new }

  describe '#initialize' do
    # Initialize -> No test necessary as its only creating
    # instance variables.
  end

  describe '#run' do
    # No testing necessary as it only calls a single method
  end

  describe '#play' do
    subject(:finished_game) { described_class.new }

    context 'when finished? returns true' do
      before do
        allow(finished_game).to receive(:create_players)
        allow(finished_game).to receive(:turn)
        allow(finished_game).to receive(:show_board)
        allow(finished_game).to receive(:finished?).and_return(true)
      end

      it 'does not call play_turn' do
        expect(finished_game).to_not receive(:play_turn)
      end
    end

    context 'when finished? returns false once' do
      before do
        allow(finished_game).to receive(:create_players)
        allow(finished_game).to receive(:turn)
        allow(finished_game).to receive(:show_board)
        allow(finished_game).to receive(:finished?).and_return(false, true)
      end

      it 'does calls play_turn once' do
        expect(finished_game).to receive(:play_turn).once
        finished_game.play
      end
    end

    context 'when finished? returns false twice' do
      before do
        allow(finished_game).to receive(:create_players)
        allow(finished_game).to receive(:turn)
        allow(finished_game).to receive(:show_board)
        allow(finished_game).to receive(:finished?).and_return(false, false, true)
      end

      it 'does calls play_turn twice' do
        expect(finished_game).to receive(:play_turn).twice
        finished_game.play
      end
    end
  end

  describe '#play_turn' do
    # No testing necessary as it only contains puts
    # and previously tested method calls.
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

  describe '#full?' do
    context 'when board is full' do
      subject(:full_board) { described_class.new }

      it 'returns true' do
        full_board.board = Array.new(3) { %w[x x x] }
        expect(full_board).to be_full
      end
    end

    context 'when board is not full' do
      subject(:full_board) { described_class.new }

      it 'returns false' do
        full_board.board = Array.new(2) { %w[x x x] }
        # Adds a single empty space to the last row
        full_board.board << %w[x # x]

        expect(full_board).to_not be_full
      end
    end
  end

  describe '#check_if_finished' do
    # No testing necessary it only contains puts and calls for
    # previously tested methods.
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

  describe '#valid_symbol?' do
    it 'returns true when the symbol is valid' do
      invalid_symbol = '@'
      result = new_player.valid_symbol?(invalid_symbol)

      expect(result).to eql(true)
    end

    it 'returns false when the symbol is an empty string' do
      invalid_symbol = ''
      result = new_player.valid_symbol?(invalid_symbol)

      expect(result).to eql(false)
    end

    it 'returns false when the symbol is an empty space' do
      invalid_symbol = ' '
      result = new_player.valid_symbol?(invalid_symbol)

      expect(result).to eql(false)
    end

    it 'returns false when the symbol is a #' do
      invalid_symbol = '#'
      result = new_player.valid_symbol?(invalid_symbol)

      expect(result).to eql(false)
    end

    it 'returns false when the symbol length is > 1' do
      invalid_symbol = '@@'
      result = new_player.valid_symbol?(invalid_symbol)

      expect(result).to eql(false)
    end
  end
end
