# frozen_string_literal: true

require_relative './node'
require 'pry-byebug'

# Tree class for balanced binary search tree
class Tree
  attr_accessor :root, :array

  def initialize(array = [])
    @array = array.sort.uniq
    @root = build_tree(@array)
  end

  def build_tree(array)
    return nil if array.empty?

    mid = (array.size - 1) / 2
    root = Node.new(array[mid])

    root.left_child = build_tree(array[0...mid])
    root.right_child = build_tree(array[(mid + 1)..-1])

    root
  end

  def insert(val, root = @root)
    return Node.new(val) if root.nil?

    case val <=> root.data
    when 0
      root
    when -1
      root.left_child = insert(val, root.left_child)
    else
      root.right_child = insert(val, root.right_child)
    end

    root
  end

  def delete(val, root = @root)
    return root if root.nil?

    # Compare value the value at root, if less, call delete on left child, if more, call delete on right child.
    if val < root.data
      root.left_child = delete(val, root.left_child)
    elsif val > root.data
      root.right_child = delete(val, root.right_child)
    # When equivalent, this is the key to be deleted
    else
      # When the node has only one child or no children
      return root.right_child if root.left_child.nil?
      return root.left_child if root.right_child.nil?

      # When the node has two children
      # Get the inorder successor
      # (smallest value in the right subtree)
      min = min_value_node(root.right_child)
      root.data = min.data
      root.right_child = delete(min.data, root.right_child)
    end

    root
  end

  def find(value, node = @root)
    return nil if node.nil?

    if node.data == value
      node
    elsif node.data < value
      node = find(value, node.right_child)
    elsif node.data > value
      node = find(value, node.left_child)
    end

    node
  end

  def level_order(node = @root, queue = [], tree = [], &block)
    return if node.nil?

    # Push node to the tree and the children to the queue
    tree << node.data
    queue << node.left_child unless node.left_child.nil?
    queue << node.right_child unless node.right_child.nil?

    # Yield if a block is given
    if block_given?
      yield node
    elsif queue.empty?
      return tree
    end

    level_order(queue.shift, queue, tree, &block)
  end

  def inorder(node = @root, tree = [], &block)
    # Left - Root - Right
    return nil if node.nil?

    # Go to the left sbutree until a leafnode is reached
    inorder(node.left_child, tree, &block) if node.left_child

    # Yield if block given, else push node data to tree
    block_given? ? (yield node) : tree << node.data

    inorder(node.right_child, tree, &block)

    tree unless tree.none?
  end

  def preorder(node = @root, tree = [], &block)
    # Root - Left - Right
    return nil if node.nil?

    # Pass node to the block
    if block_given?
      yield node
    else
      tree << node.data
    end

    preorder(node.left_child, tree, &block)
    preorder(node.right_child, tree, &block)

    tree unless tree.none?
  end

  def postorder(node = @root, tree = [], &block)
    # Left - Right - Root
    return nil if node.nil?

    # Traverse the left subtree and then traverse the right subtree before visiting the root
    postorder(node.left_child, tree, &block) if node.left_child
    postorder(node.right_child, tree, &block)

    block_given? ? (yield node) : tree << node.data

    tree unless tree.none?
  end

  def height(node, depth = 0)
    node = find(node)

    # Traverse the left subtree until a leaf node is reached
    left = node.left_child.nil? ? depth : height(node.left_child.data, depth + 1)
    # Traverse the right subtree until a leaf node is reached
    right = node.right_child.nil? ? depth : height(node.right_child.data, depth + 1)

    # Return the greater of right and left depth
    if left >= right
      left
    elsif right > left
      right
    else
      depth
    end
  end

  def traverse_tree(root = @root, nodes = [])
    nodes << root.data
    traverse_tree(root.left_child, nodes) if root.left_child
    traverse_tree(root.right_child, nodes) if root.right_child
    nodes
  end

  def rebalance_tree
    @array = traverse_tree.sort
    @root = build_tree
    pretty_print
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
  end

  private

  def min_value_node(node = @root)
    # Find the smallest value in the list by continually taking
    # the left child and the leftmost leaf node is found
    node.left_child.nil? ? node : min_value_node(node.left_child)
  end
end
