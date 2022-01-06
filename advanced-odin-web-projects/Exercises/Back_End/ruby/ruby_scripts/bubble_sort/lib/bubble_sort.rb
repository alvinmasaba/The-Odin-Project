# frozen_string_literal: true

def bubble_sort(array)
  swapped = true
  while swapped
    swapped = false
    (1..(array.size - 1)).each do |n|
      next unless array[n - 1] > array[n]

      array[n - 1], array[n] = array[n], array[n - 1]
      swapped = true
    end
  end
  array
end
