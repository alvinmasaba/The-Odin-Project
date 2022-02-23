# frozen_string_literal: true

# class for a connect four player
class Player
  attr_accessor :name, :marker

  SPECIAL_MARKERS = [ "\u2600", "\u2614", "\u2615", "\u2620", "\u2622",
              "\u2639", "\u2660", "\u2661", "\u2663", "\u2665",
              "\u265A", "\u265B", "\u265C", "\u265E", "\u2696",
              "\u269C", "\u2694", "\u26A1"]

  def initialize(name = nil, marker = SPECIAL_MARKERS.sample.strip)
    @name = name
    @marker = marker
  end

  def choose_marker
  end
end
  