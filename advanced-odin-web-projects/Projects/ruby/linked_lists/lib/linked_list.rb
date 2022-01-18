# frozen_string_literal: true

require_relative './node.rb'

class LinkedList
  attr_accessor :head, :tail, :nodes
  
  def initialize(head = nil, tail = nil)
    @head = head
    @tail = tail
    @nodes = []
  end

  def append(value)
    @tail = Node.new(value, nil, @nodes.size)
    @nodes << @tail
  end

  def prepend(value)
    @head = Node.new(value, @head, 0)

    # increment the index number of each node except the head
    @nodes.each { |node| node.index += 1}

    # add head to the front of the list
    @nodes.unshift(@head)
  end

  def size
    @nodes.size
  end

  def head
    @head.value
  end

  def tail
    @tail.value
  end

  def at(idx)
    node = @nodes.find { |node| node.index == idx }
    node.value
  end

  def pop
    node = @tail.value
    @nodes = @nodes[0...-1]
    @tail = @nodes[-1]
    node
  end

  def contains?(value)
    @nodes.any? { |node| node.value == value }
  end

  def find(value)
    result = nil
    @nodes.each { |node| node.index == value ? node.value : result }
  end

  def to_s
    string = ""
    @nodes.each do |node|
      string += ""

end