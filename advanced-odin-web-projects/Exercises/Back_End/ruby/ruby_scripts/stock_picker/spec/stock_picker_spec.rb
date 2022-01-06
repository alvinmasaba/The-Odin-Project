require 'spec_helper'
require './lib/stock_picker'

RSpec.describe 'Stock Picker' do
  describe '#stock_picker' do
    it 'works when the highest day is the first day' do
      expect(stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 10])).to eql([1, 4])
    end

    it 'works when the lowest day is the first day' do
      expect(stock_picker([0, 3, 6, 9, 15, 8, 6, 1, 10])).to eql([0, 4])
    end

    it 'works when the highest day is the last day' do
      expect(stock_picker([17, 3, 6, 9, 15, 8, 6, 1, 25])).to eql([7, 8])
    end

    it 'works when the lowest day is the last day' do
      expect(stock_picker([11, 3, 6, 9, 15, 8, 6, 1, 0])).to eql([1, 4])
    end

    it 'works when there is negative returns' do
      expect(stock_picker([-17, -3, -6, -9, -15, -8, -6, -1, -10])).to eql([0, 7])
    end

    it 'works when there is positive and negative returns' do
      expect(stock_picker([-17, 2, -6, 109, -15, -8, 16, -1, 10])).to eql([0, 3])
    end

    it 'works with only two dates' do
      expect(stock_picker([-17, -3])).to eql([0, 1])
    end

    it 'returns nil when there is less than 2 dates' do
      expect(stock_picker([17])).to eql(nil)
    end

    it 'returns nil when there is 0 dates' do
      expect(stock_picker([])).to eql(nil)
    end

    it 'works with floating point returns' do
      expect(stock_picker([17.111, 3.4, 6, 9, 15.3, 8, 6, 1.12, 25.2])).to eql([7, 8])
    end

    it 'works with negative floating point returns' do
      expect(stock_picker([17.111, 3.4, 6, -9, 15, 32.35, 8, 6, 1.12, 25.2])).to eql([3, 5])
    end
  end
end
