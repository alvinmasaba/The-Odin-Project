describe '#enter_name' do
  subject(:player_name) { described_class.new }
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