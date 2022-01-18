# frozen_string_literal: true

require_relative './node'

# Imitates the functionality of a traditional linked list
class LinkedList
  attr_accessor :head, :tail, :nodes

  def initialize(nodes = [])
    if nodes.empty?
      @head = nil
      @tail = nil
      @nodes = nodes
    else
      @head = nodes[0]
      @tail = nodes[-1]
      @nodes = []
      nodes.each_with_index { |value, i| @nodes << Node.new(value, nodes[i + 1]) }
    end
  end

  def append(value)
    if @nodes.empty?
      @nodes << Node.new(value, nil)
      @head = value
    elsif @tail.nil?
      @nodes << Node.new(value, nil)
      @nodes[0].next_node = value
    else
      # Make the previous tail point to the value to be appended
      @nodes[-1].next_node = value
      # Append the new value as a node instance to the list of nodes with value 'value' and next_node 'nil'
      @nodes << Node.new(value, nil)
    end
    # Set @tail to value
    @tail = value
  end

  def prepend(value)
    if @nodes.empty?
      # Add a new node to the front of the list with value 'value' and next_node 'nil'
      @nodes.unshift(Node.new(value))
    else
      @nodes.unshift(Node.new(value, @head))
    end

    @head = value
  end

  def size
    @nodes.size
  end

  def at(index)
    @nodes[index].value
  end

  def pop
    node = @tail
    @nodes = @nodes[0...-1]
    @tail = @nodes[-1].value
    node
  end

  def contains?(value)
    @nodes.any? { |node| node.value == value }
  end

  def find(value)
    result = nil
    @nodes.each_with_index { |node, i| node.value == value ? result = i : result }
    result
  end

  def to_s
    string = ''
    @nodes.each do |node|
      string += "( #{node.value} ) -> "
    end
    string += 'nil'
  end
end
