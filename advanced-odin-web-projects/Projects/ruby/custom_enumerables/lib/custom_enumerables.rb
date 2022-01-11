# frozen_string_literal: true

# Custom methods for Enumerable module.
module Enumerable
  def my_each
    # Performs function identical to #each
    arr = to_a
    i = 0

    return to_enum unless block_given?

    arr.size.times do
      yield arr[i]
      i += 1
    end

    self
  end

  def my_each_with_index
    arr = to_a
    i = 0

    return to_enum unless block_given?

    arr.size.times do
      yield arr[i], i
      i += 1
    end

    self
  end

  def my_select
    true_values = []

    return to_enum unless block_given?

    # Call my_each on arr to pass each item to the block
    to_a.my_each do |item|
      # if the expression in the block evaluates to true when given item, push to true_values
      true_values << item if yield item
    end

    true_values
  end

  def my_any?(*arg)
    # if block given, pass the array to my_each and return true if any value evaluates to true in the block
    if block_given?
      to_a.my_each { |item| return true if yield item }

      # if argument given, return true if any elements in self === argument
    elsif arg != []
      to_a.my_each { |item| return true if arg[0] === item }

    # if no block or argument given (arg is an empty array), return true if any elements in self evaluate to true
    else
      to_a.my_each { |item| return true if item }
    end

    false
  end

  def my_none?(*arg)
    # if block given, pass the array to my_each and return false if any value evaluates to true in the block
    if block_given?
      to_a.my_each { |item| return false if yield item }

    # if argument given, return false if any elements in self === argument
    elsif arg != []
      to_a.my_each { |item| return false if arg[0] === item }

    # if no block or argument given (arg is an empty array), return false if any elements in self evaluate to true
    else
      to_a.my_each { |item| return false if item }
    end

    true
  end

  def my_count(*arg)
    i = 0

    # if block given, pass each item in array to my_each and increment i for each element that yields a true value
    if block_given?
      to_a.my_each { |item| i += 1 if yield item }

    # if arg given, increment i for each element that is equal to arg
    elsif arg != []
      to_a.my_each { |item| i += 1 if arg[0] === item }

    else
      to_a.my_each { i += 1 }
    end

    i
  end

  def my_map
    return to_enum unless block_given?

    new_arr = []

    # Push to new_arr the yield of each item after it is passed to the block
    to_a.my_each { |item| new_arr << (yield item) }

    new_arr
  end
end
