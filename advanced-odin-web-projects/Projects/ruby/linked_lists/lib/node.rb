# frozen_string_literal: true

class Node
  attr_accessor :value, :next_node, :index

  def initialize(value=nil, next_node=nil, index)
    @value = value
    @next_node = next_node
    @index = index
  end
end