require './lib/caesar_cipher.rb'

describe '#caesar_cipher' do
  it 'works with a spaceless string' do
    expect(caesar_cipher('whatastring', 5)).to eql('bmfyfxywnsl')
  end

  it 'works with spaces' do
    expect(caesar_cipher('what a string', 5)).to eql('bmfy f xywnsl')
  end

  it 'works with punctuation' do
    expect(caesar_cipher('what a string!', 5)).to eql('bmfy f xywnsl!')
  end

  it 'is case sensitive' do
    expect(caesar_cipher('What a string!', 5)).to eql('Bmfy f xywnsl!')
  end

  it 'works when the factor is negative' do
    expect(caesar_cipher('What a string!', -1)).to eql('Vgzs z rsqhmf!')
  end

  it 'works when the factor is zero' do
    expect(caesar_cipher('What a string!', 0)).to eql('What a string!')
  end

  it 'works when the factor is greater than 26' do
    expect(caesar_cipher('What a string!', 31)).to eql('Bmfy f xywnsl!')
  end
end
