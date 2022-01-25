# frozen_string_literal: true

# Node class for balanced binary search tree
class Node
  include Comparable
  attr_accessor :data, :left_child, :right_child

  def <=>(other)
    @data <=> other.data
  end

  def initialize(data, left = nil, right = nil)
    @data = data
    @left_child = left
    @right_child = right
  end
end
