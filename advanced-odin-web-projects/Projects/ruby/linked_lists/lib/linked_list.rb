# frozen_string_literal: true

require_relative './node.rb'

class LinkedList
  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    @tail = Node.new(value)
  end

  def prepend(value)
    @head = Node.new(value, @head)
  end
 
end