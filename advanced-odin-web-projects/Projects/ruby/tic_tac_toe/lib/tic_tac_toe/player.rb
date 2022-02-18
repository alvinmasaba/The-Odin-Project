# frozen_string_literal: true

# class for an tic-tac-toe player
class Player
  attr_accessor :symbol, :name

  def initialize(name = nil, symbol = nil)
    @name = name
    @symbol = symbol
  end

  def enter_name
    puts "#{@name}, please enter a name. Your name may be up to 10 chars max:\n\n"

    new_name = gets.chomp
    new_name = gets.chomp until new_name.size <= 10 && !new_name.nil?

    @name = new_name
  end

  def choose_symbol
    puts <<~HEREDOC

      #{@name}, choose a symbol. Your symbol can be any char
      except a white-space or #.

    HEREDOC

    sym = gets.chomp
    sym = gets.chomp until valid_symbol?(sym)

    @symbol = sym.to_sym
  end

  def valid_symbol?(sym)
    # sym can be any non-whitespace character except '#'
    if /\S/.match(sym) && sym != '#' && sym.size == 1
      true
    else
      false
    end
  end
end
