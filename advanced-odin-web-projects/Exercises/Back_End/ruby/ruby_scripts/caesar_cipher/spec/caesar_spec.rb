require 'spec_helper'
require './lib/caesar_cipher'

RSpec.describe 'Caesar Cipher' do
  describe '#caesar_cipher' do
    it 'works with a small positive increment' do
      expect(caesar_cipher('Ll', 4)).to eql('Pp')
    end

    it 'works with a small negative increment' do
      expect(caesar_cipher('Bb', -4)).to eql('Xx')
    end

    it 'works with a large positive increment' do
      expect(caesar_cipher('Qq', 60)).to eql('Yy')
    end

    it 'works with a large negative increment' do
      expect(caesar_cipher('Pp', -60)).to eql('Hh')
    end

    it 'works with a string that has punctuation' do
      expect(caesar_cipher('Hello party people!!', 5)).to eql('Mjqqt ufwyd ujtuqj!!')
    end

    it 'works with a phrase with a large positive increment' do
      expect(caesar_cipher('Hello, World!', 75)).to eql('Ebiil, Tloia!')
    end

    it 'works with a phrase with a large negative increment' do
      expect(caesar_cipher('Hello, World!', -55)).to eql('Ebiil, Tloia!')
    end
  end
end
