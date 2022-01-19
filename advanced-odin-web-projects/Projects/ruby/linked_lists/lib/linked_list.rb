# frozen_string_literal: true

require_relative './node'

# Imitates the functionality of a traditional linked list
class LinkedList
  attr_accessor :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    # If there is no head, then create a new node, set it as the head, and point it to nil
    if @head.nil?
      @head = Node.new(value, nil)

    # If there is no tail, create a new node, set it as the tail, point to nil, and set the head to point to it
    elsif @tail.nil?
      @tail = Node.new(value, nil)
      @head.next_node = @tail

    # Otherwise, create a new node, make the tail point to it, and set it is the tail
    else
      new_tail = Node.new(value, nil)
      @tail.next_node = new_tail
      @tail = new_tail
    end
  end

  def prepend(value)
    # If there is no head, then create a new node, set it as the head, and point it to nil
    if @head.nil?
      @head = Node.new(value, nil)

    # If there is no tail, create a new node and point it to the current head, make the current head the tail,
    # then set the new node to head
    elsif @tail.nil?
      new_head = Node.new(value, @head)
      @tail = @head
      @head = new_head

    # Otherwise, simply make the new node the head
    else
      new_head = Node.new(value, @head)
      @head = new_head
    end
  end

  def size
    i = 0
    current_node = @head

    # Increment i until the end of the list (nil) is reached, then return i
    until current_node.nil?
      current_node = current_node.next_node
      i += 1
    end

    i
  end

  def at(index)
    i = 0
    current_node = @head

    # Move to the next_node #index times. Then return that node.
    until i == index
      current_node = current_node.next_node
      i += 1
    end

    current_node
  end

  def pop
    popped_node = @tail
    current_node = @head

    # Move to the next_node until the penultimate node is reached, make that node the tail, return the previous tail.
    current_node = current_node.next_node until current_node.next_node == @tail
    current_node.next_node = nil
    @tail = current_node
    popped_node
  end

  def contains?(value)
    current_node = @head
    result = false

    # Starting at the head, check each node to see if its value == given value, if so, toggle result to true.
    until current_node.next_node.nil?
      result = current_node.value == value ? true : result
      current_node = current_node.next_node
    end

    result
  end

  def find(value)
    i = 0
    current_node = @head
    result = puts "#{value} is not in the linked list."

    until current_node.next_node.nil?
      if current_node.value == value
        result = i
        current_node = @tail
      end

      current_node = current_node.next_node
      i += 1
    end

    result
  end

  def to_s
    string = ''
    current_node = @head

    until current_node.next_node.nil?
      string += "( #{current_node.value} ) -> "
      current_node = current_node.next_node
    end

    string + "( #{@tail.value} ) -> nil "
  end

  def insert_at(value, index)
    # Create a new node that points to the node already at index. Unless index is 0, set the preceding node to point
    # to the new node.
    if index.zero?
      prepend(value)
    elsif index == size
      append(value)
    else
      new_node = Node.new(value, at(index))
      at(index - 1).next_node = new_node
    end
  end

  def remove_at(index)
    if index == size - 1
      pop
    elsif index.zero?
      @head = @head.next_node
    else
      at(index - 1).next_node = at(index + 1)
    end
  end
end
