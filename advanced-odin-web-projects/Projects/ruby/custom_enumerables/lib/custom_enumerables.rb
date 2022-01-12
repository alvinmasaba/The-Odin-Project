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

  def my_map(&my_proc)
    new_arr = []
    if block_given?
      # Push to new_arr the yield of each item after it is passed to the block
      to_a.my_each { |item| new_arr << (yield item) }

    elsif my_proc.instance_of?(Proc)
      to_a.my_each { |item| new_arr << my_proc.call(item) }
    
    else
      to_enum
    end

    new_arr
  end

  def my_reduce(*args)
    # Accumulator 'memo' takes on the value of first item in self unless a value is passed to args 
    if args[0].instance_of?(Symbol) || args.size == 0
      memo = to_a[0]
      arr = to_a[1..-1]
    else
      memo = args[0]
      arr = to_a
    end
    
    # Control for presence of operator in args
    op = args.size == 2 ? args[1] : args[0]

    if block_given?
      arr.my_each { |item| memo = yield memo, item }

    elsif !op.nil?
      arr.my_each { |item| memo = memo.send(op.to_sym, item) }
    end

    memo
  end
end

def multiply_els(arr)
  arr.my_reduce(:*)
end