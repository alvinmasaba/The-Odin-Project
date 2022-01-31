# frozen_string_literal: true

require_relative './balanced_bst/node'
require_relative './balanced_bst/tree'

# Create a binary search tree from an array of random numbers.

binary_tree = Tree.new((Array.new(15) { rand(1..100) }))

# Confirm that it is balanced.

def tree_driver(tree)
  if tree.balanced?
    # Print all elements in level order.
    p "Level order: #{tree.level_order}"

    # Print all elements in preorder.
    p "Pre order: #{tree.preorder}"

    # Print all elements in postorder.
    p "Post order: #{tree.postorder}"

    # Print all elements in order.
    p "In order: #{tree.inorder}"

    # Unbalance the tree by adding several numbers > 100.
    rand(5..10).times do
      tree.insert(rand(101..500))
    end

    # Confirm that the tree is unbalanced.
    if tree.balanced?
      puts "The tree is still balanced"
    else
      puts "The tree is now unbalanced."
      tree.rebalance
      puts "The tree has been rebalanced." if tree.balanced?
    end

    p "Level order: #{tree.level_order}"
    p "Pre order: #{tree.preorder}"
    p "Post order: #{tree.postorder}"
    p "In order: #{tree.inorder}"

    tree.pretty_print
  else
    puts "The tree is unbalanced."
    tree_driver(tree)
  end
end

tree_driver(binary_tree)
