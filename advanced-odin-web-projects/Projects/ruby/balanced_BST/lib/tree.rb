# frozen_string_literal: true

class Tree
  attr_accessor :root, :array

  def initialize(array)
    @array = array.sort
  end

  def build_tree(array = @array, start = 0, tail = @array.size - 1)
    return nil if start > tail
    mid = (start + tail) / 2
    @root = Node.new(array[mid])
    
    @root.left_child = build_tree(array, start, mid - 1)
    @root.right_child = build_tree(array, mid + 1, tail)
    @root
  end
end





