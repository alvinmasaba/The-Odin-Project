# frozen_string_literal: true

require_relative './player'

# Class for computer Mastermind player
class ComputerPlayer < Player
  @@num_cpu_players = 0
  
  def initialize(game)
    super
    @name = "Computer #{@@num_cpu_players}"
    @@num_cpu_players += 1
  end

  def secret_code
    puts "\nThe #{@name} is creating a secret code."
    (1..4).map { @game.COLORS.sample }
  end

  def input_guess
    puts "\nThe #{@name} is guessing."
    @first_guess ? (1..4).map { @game.COLORS.sample } : subsequent_guess
  end

  private

  def pick_index(used_idx)
    # Generates a random number between 0-3 not included in the given array,
    # then pushes the number to that array to avoid reuse.
    idx = rand(0..3)
      until !used_idx.include?(idx)
        idx = rand(0..3)
      end
    used_idx << idx
    idx
  end

  def keep_correct(used_idx, new_guess)
    # For each "correct guess", keep a random color from the original guess at the same index
    # in the new guess.
    (1..@game.cpu_correct_guesses).each do |i|
      idx_1 = pick_index(used_idx)
      new_guess[idx_1] = @game.guess[idx_1]
    end
    new_guess
  end

  def keep_misplaced(used_idx, new_guess)
    # Works the same as keep_correct except in this case we put the random color we are keeping
    # at a random index in 'new_guess'.
    (1..@game.num_misplaced).each do |i|
      idx_2 = pick_index(used_idx)
      idx_3 = rand(0..3)
      # Generate a random index to put our random "carryover" color at in 'new_guess'.
      # The index must have a value of nil. If not generate a new random index.
      until new_guess[idx_3].nil?
        idx_3 = rand(0..3)
      end
      new_guess[idx_3] = @game.guess[idx_2]
    end
    new_guess
  end

  def subsequent_guess
    used_indices = []
    # Create a nil array of length 4 which we will populate with either carryover or
    # new random colors 
    new_guess = Array.new(4) { nil } 
    new_guess = keep_correct(used_indices, new_guess)
    new_guess = keep_misplaced(used_indices, new_guess)
    new_guess.map { |color| color.nil? ? @game.COLORS.sample : color }
  end
end
