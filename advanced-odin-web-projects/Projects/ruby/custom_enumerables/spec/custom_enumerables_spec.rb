# frozen_string_literal: true

require 'spec_helper'
require './lib/custom_enumerables'

RSpec.describe 'Custom Enumerables' do
  describe '#my_each' do
    it 'works with arrays of integers in blocks' do
      numbers = [1, 2, 3, 4, 5]
      expect(numbers.my_each { |item| puts item }).to eql(numbers.each { |item| puts item })
    end

    it 'works with arrays of strings in blocks' do
      numbers = %w[a b c d]
      expect(numbers.my_each { |item| puts item }).to eql(numbers.each { |item| puts item })
    end

    it 'works with empty arrays and blocks' do
      numbers = []
      expect(numbers.my_each { |item| puts item }).to eql(numbers.each { |item| puts item })
    end

    it 'works with hashes and blocks' do
      numbers = { a: 1, b: 2, c: 3, d: 4 }
      expect(numbers.my_each { |item| puts item }).to eql(numbers.each { |item| puts item })
    end

    # it 'works with when there is no block' do
    #  numbers = [1,2,3,4,5]
    #  expect(numbers.my_each).to eql(numbers.each)
    # end
  end
end
