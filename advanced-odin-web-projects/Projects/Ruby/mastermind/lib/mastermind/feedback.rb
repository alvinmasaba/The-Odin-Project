# frozen_string_literal: true

# Provides feedback after each guess while game is being played
class Feedback
  attr_reader :guess, :code
  attr_accessor :game, :num_misplaced, :correct

  def initialize(game)
    @game = game
    @guess = @game.guess
    @code = @game.secret_code
    @num_misplaced = num_misplaced(@code, @guess)
    @game.num_misplaced = @num_misplaced
    @correct = correct(@code, @guess)
    feedback
  end

  private

  def feedback
    puts "\n#{@game.code_breaker.name} guessed #{@guess}"
    if @guess == @code
      puts "\nSUCCESS. The SECRET CODE was: #{@game.secret_code}.
      \n#{@game.code_breaker.name} guessed the secret code!"
      @game.correct_guess = true
      @game.code_breaker.points += 1
    else
      @game.guesses_left -= 1
      puts "#{correct(@code, @guess)} correct guesses.\nAnd #{@num_misplaced} misplaced guesses.
      \nYou have #{@game.guesses_left} guesses left."
      @game.code_maker.points += 1
    end
    @game.code_breaker.first_guess = false
  end

  def correct(code, guess)
    @game.cpu_correct_guesses = (0..3).count { |i| code[i] == guess[i] }
  end

  def num_misplaced(code, guess)
    # Create an array of the colors from the secret code which were not guessed correctly
    unguessed = (0..3).map { |i| code[i] if code[i] != guess[i] }
    # Create an array of the incorrect colors from the guess
    incorrect = (0..3).map { |i| guess[i] if code[i] != guess[i] }
    # Increment sum for each color in "incorrect" that is found in "unguessed" not including nil
    # Then change the value of that color in "unguessed" to nil to avoid duplicate counts
    (0..3).reduce(0) do |sum, i|
      if unguessed.include?(incorrect[i]) && incorrect[i] # will evaluate to false if incorrect[i] is nil
        unguessed[unguessed.find_index(incorrect[i])] = nil
        sum += 1
      else
        sum
      end
    end
  end
end
