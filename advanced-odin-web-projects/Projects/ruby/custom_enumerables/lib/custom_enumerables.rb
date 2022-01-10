# frozen_string_literal: true

# Custom methods for Enumerable module.
module Enumerable
  def my_each
    # Performs function identical to #each
    arr = to_a
    i = 0

    return to_enum unless block_given?

    arr.count.times do
      yield arr[i]
      i += 1
    end

    self
  end

  def my_each_with_index
    arr = to_a
    i = 0

    return to_enum unless block_given?

    arr.count.times do
      yield arr[i], i
      i += 1
    end

    self
  end

  def my_select
    arr = to_a
    true_values = []

    # Call my_each on arr to pass each item to the block

    arr.my_each do |item|

      # if the expression in the block evaluates to true when given item, push to true_values

      if yield item
        true_values << item
      end
    end

    true_values
  end
end
