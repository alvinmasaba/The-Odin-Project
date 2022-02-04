# frozen_string_literal: true

require_relative './knights_module'

# Class to create knight object
class Knight
  # mixin
  include Knights

  attr_accessor :current_pos

  def initialize(position = nil)
    @current_pos = position.location
  end
end
