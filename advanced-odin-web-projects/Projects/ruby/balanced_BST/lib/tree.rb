# frozen_string_literal: true

require_relative './node'


class Tree
  attr_accessor :root, :array, :tree

  def initialize(array)
    @array = array.sort.uniq
    @tree = {}
    @root = self.build_tree
  end

  def build_tree(array = @array, start = 0, tail = array.size - 1)
    if start > tail
      return nil 
    end

    mid = (start + tail) / 2
    root = Node.new(array[mid])
    root.left_child = build_tree(array, start, mid - 1)
    root.right_child = build_tree(array, mid + 1, tail)
    root
  end

  def insert(root = @root, val)
    return Node.new(val) if root.nil?

    case val <=> root.data
    when 0
      root
    when -1
      root.left_child = insert(root.left_child, val)
    else
      root.right_child = insert(root.right_child, val)
    end

    root
  end

  def delete(root = @root, val)
    # Compare value the value at root, if less, call delete on left child, if more, call delete on right child.
    case val <=> root.data
    when -1
      delete(root.left_child, val)

    # If value == root,   
    when 0
      if root.left_child && root.right_child.nil?
        root.data = root.left_child.data
        root.left_child = root.left_child.left_child
      elsif root.right_child
        root.data = root.right_child.data
        root.right_child = root.right_child.right_child
      # When root is a leaf node, simply set its value to nil
      else
        root.data = nil
      end
    when 1
      delete(root.right_child, val)
    end
  end

  def traverse_tree(root = @root, nodes = [])
    puts root.data
    nodes << root.data

    if root.left_child
      traverse_tree(root.left_child, nodes)
    end
    
    if root.right_child
      traverse_tree(root.right_child, nodes)
    end

    nodes
  end

  def rebalance_tree
    @array = self.traverse_tree.sort
    @root = self.build_tree
    @root
  end
end





