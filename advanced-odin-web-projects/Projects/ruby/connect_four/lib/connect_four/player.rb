# frozen_string_literal: true

# class for a connect four player
class Player
  attr_accessor :name
  
  def initialize(name = nil)
    @name = name
  end
end