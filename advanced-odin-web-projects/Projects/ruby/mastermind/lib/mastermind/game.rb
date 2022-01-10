# frozen_string_literal: true

require_relative './player'
require_relative './human_player'
require_relative './computer_player'
require_relative './feedback'
require_relative './computer_guess'
require_relative './mastermind'

# Plays a single round of Mastermind match
class Game
  prepend MasterMind

  attr_reader :players, :score, :player1, :player2, :COLORS
  attr_accessor :guesses_left, :correct_guess, :secret_code, :guess, :code_maker, :code_breaker,
                :cpu_correct_guesses, :num_misplaced, :round, :num_rounds

  def initialize
    @players = num_human_players(self)
    @guesses_left = 12
    @correct_guess = false
    @score = "#{@players[0].points} - #{@players[1].points}"
    @player1 = @players[0].name
    @player2 = @players[1].name
    @COLORS = %w[RED ORANGE BLUE GREEN YELLOW PURPLE BLACK]
    @round = 1
    play
  end

  private

  def play_round
    code_gen(self)
    puts "\n#{@code_maker.name} is the code maker and #{@code_breaker.name} is the code breaker!"
    until @guesses_left.zero? || @correct_guess
      @guess = @code_breaker.input_guess
      sleep 3 if @code_breaker.instance_of?(ComputerPlayer)
      Feedback.new(self)
      @correct_guess
    end
    puts "The score is...

    #{@player1}:    #{@players[0].points}
    #{@player2}:    #{@players[1].points}"
    @round += 1
    @correct_guess = false
  end

  def play
    set_num_rounds(self)
    choose_code_maker(@player1, @player2, @players)
    choose_code_breaker(@players)
    set_players(self, @players)
    while @round <= @num_rounds
      switch(self, @players) if @round > 1
      puts "\nROUND #{@round}\n\n"
      play_round
    end
  end
end
