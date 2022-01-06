require 'spec_helper'
require './lib/bubble_sort'

RSpec.describe 'Bubble Sort' do
  describe '#bubble_sort' do
    it 'returns a sorted list of numbers from lowest highest when given an unsorted list' do
      expect(bubble_sort([4, 3, 78, 2, 0])).to eql([0, 2, 3, 4, 78])
    end

    it 'returns a sorted list when there are duplicates in the unsorted list' do
      expect(bubble_sort([4, 3, 78, 2, 0, 2])).to eql([0, 2, 2, 3, 4, 78])
    end

    it 'works when all the numbers are the same' do
      expect(bubble_sort([2, 2, 2, 2, 2])).to eql([2, 2, 2, 2, 2])
    end

    it 'works when the highest number is at the beginning' do
      expect(bubble_sort([4, 3, 2, 0, 2])).to eql([0, 2, 2, 3, 4])
    end

    it 'works when the highest number is at the end' do
      expect(bubble_sort([4, 3, 2, 0, 2, 78])).to eql([0, 2, 2, 3, 4, 78])
    end

    it 'works when the lowest number is at the beginning' do
      expect(bubble_sort([0, 4, 3, 2, 5, 2])).to eql([0, 2, 2, 3, 4, 5])
    end

    it 'works when the lowest number is at the end' do
      expect(bubble_sort([4, 3, 2, 5, 2, 1])).to eql([1, 2, 2, 3, 4, 5])
    end

    it 'works with negative numbers' do
      expect(bubble_sort([4, 3, -78, 2, 0, 2])).to eql([-78, 0, 2, 2, 3, 4])
    end

    it 'works with floating point numbers' do
      expect(bubble_sort([0.4, 3.5, -78, 2, 0, 2])).to eql([-78, 0, 0.4, 2, 2, 3.5])
    end

    it 'returns [] when given an empty list' do
      expect(bubble_sort([])).to eql([])
    end
  end
end
