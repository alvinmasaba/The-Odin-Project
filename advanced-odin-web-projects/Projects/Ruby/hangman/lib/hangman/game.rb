# frozen_string_literal: true

require 'json'
require_relative './game_serializer'
require_relative './illustrator'

class Game
  include GameSerializer
  include Illustrator

  attr_accessor :current_guess, :guesses_left, :secret_word, :hangman, :body_part

  def initialize
    @secret_word = pick_secret_word.chomp.upcase.split(//)
    # Converts the secret word to an array of uppercase letters

    @current_guess = @secret_word.map { |_char| '_' }
    # initializes current_guess as an array of '_' for each character of secret_word

    @guesses_left = 7
    @hangman = SCAFFOLD
  end

  private

  def pick_secret_word
    dictionary = File.open('../hangman/dictionary.txt')
    words = dictionary.readlines
    dictionary.close
    word = words.sample
    word.length.between?(5, 12) ? word : pick_secret_word
  end

  def guess_letter
    puts "
  Please enter a single letter!
    "
    guess = gets.chomp

    guess = guess_letter unless guess.length == 1 && /[a-zA-Z]/.match(guess)

    guess.upcase
  end

  def display_current_guess
    puts "
    #{@current_guess.join(' ')}
    "
  end

  def draw_hangman
    if @guesses_left > 4
      @hangman += BODY[@guesses_left]
    else
      @hangman = SCAFFOLD + HEAD + NECK + BODY[@guesses_left]
    end

    puts @hangman
  end

  def play_round
    display_current_guess
    guess = guess_letter

    if @secret_word.include?(guess)
      @secret_word.each_with_index do |ch, i|
        ch == guess ? @current_guess[i] = guess : next
      end
      puts "
    Lucky you. You guessed #{guess} correctly.
    "
      display_current_guess

    else
      @guesses_left -= 1
      puts "
      Sorry, that letter is not in the word. You have #{@guesses_left} body part(s) left before death.
      "
      sleep(2)
      draw_hangman
    end
  end

  def name_file
    i = 1
    fname = gets.chomp.strip
    original_fname = fname
    while File.exist?("saved_games/#{fname}.json")
      fname = original_fname + "(#{i})"
      i += 1
    end

    fname.gsub(' ', '_')
  end

  def create_game_file(fname)
    game_file = File.open("saved_games/#{fname}.json", 'w')
    data = save
    game_file.write(data)
    game_file.close
  end

  def save_game
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    puts "
  Enter a name for your save game:
    "
    create_game_file(name_file)
  end

  public

  def play_game
    until @guesses_left <= 0
      puts "
    Guess the secret word below!"
      play_round

      puts "
    Would you like to save your game? (Enter 'Y' for 'Yes' otherwise press any other key to continue)
      "
      answer = gets.chomp
      answer.downcase == 'y' || answer.downcase == 'yes' ? save_game : next
    end
  end
end
