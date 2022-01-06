require 'spec_helper'
require './lib/substrings'

RSpec.describe 'Substrings' do
  describe '#substrings' do
    it 'works with phrases' do
      dictionary = %w[alvin cool]
      expect(substrings('alvin is cool and so are you', dictionary)).to eql({ 'alvin' => 1, 'cool' => 1 })
    end

    it 'works with a phrase that includes punctuation' do
      dictionary = %w[alvin cool]
      expect(substrings('alvin is cool! but , heyyo?', dictionary)).to eql({ 'alvin' => 1, 'cool' => 1 })
    end

    it 'works when words in the dictionary appear multiple times' do
      dictionary = %w[but bird can sing you me]
      expect(substrings('a bird is not a bird but a bird can sing to you and you sing to me', dictionary)).to eql({
                                                                                                                    'bird' => 3, 'but' => 1, 'can' => 1, 'me' => 1, 'sing' => 2, 'you' => 2
                                                                                                                  })
    end

    it 'works with partial matches' do
      dictionary = %w[an be amanda behold]
      expect(substrings('amanda can is one to behold',
                        dictionary)).to eql({ 'an' => 2, 'be' => 1, 'amanda' => 1, 'behold' => 1 })
    end

    it 'is case insensiive with respect to the string' do
      dictionary = %w[an be amanda behold]
      expect(substrings('AMANDA Can Is One To Behold',
                        dictionary)).to eql({ 'an' => 2, 'be' => 1, 'amanda' => 1, 'behold' => 1 })
    end

    it 'is case insensitive with respect to the dictionary' do
      dictionary = %w[An be AMANDA beHOLD]
      expect(substrings('amanda can is one to behold',
                        dictionary)).to eql({ 'An' => 2, 'be' => 1, 'AMANDA' => 1, 'beHOLD' => 1 })
    end

    it 'returns an empty hash when given an empty dictionary' do
      dictionary = []
      expect(substrings('hello my name is steve', dictionary)).to eql({})
    end

    it 'returns an empty hash when given an empty string' do
      dictionary = %w[an be amanda behold]
      expect(substrings('', dictionary)).to eql({})
    end
  end
end
