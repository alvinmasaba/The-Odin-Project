# frozen_string_literal: true

# instances of class node serve as nodes an instance of a LinkedList class object
class Node
  attr_accessor :value, :next_node, :index

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end
