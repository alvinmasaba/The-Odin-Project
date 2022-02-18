describe '#enter_name' do
  subject(:player_name) { described_class.new }
  valid_name = 'first name'
  invalid_name = '1234567891011'

  context 'when a valid name is input' do
    before do
      allow(player_name).to receive(:puts)
      allow(player_name).to receive(:gets).and_return(valid_name)
    end

    it 'returns the name' do
      player_name.enter_name
      result = player_name.name
      expect(result).to eql(valid_name)
    end
  end

  context 'when an invalid name is input twice' do
    before do
      allow(player_name).to receive(:puts)
      allow(player_name).to receive(:gets).and_return(invalid_name, invalid_name, valid_name)
    end

    it 'calls enter_name twice' do
      expect(player_name).to receive(:puts).with("#{player_name.name}, please enter a name. Your name may be up to 10 chars max:\n\n").twice
      player_name.enter_name
    end

    it 'returns only the valid name' do
      player_name.enter_name
      result = player_name.name
      expect(result).to eql(valid_name)
    end
  end
  