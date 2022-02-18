# frozen_string_literal: true

# class for an tic-tac-toe player
class Player
  attr_accessor :symbol, :name

  def initialize(name = nil, symbol = nil)
    @name = name
    @symbol = symbol
  end

  def enter_name
    puts "\n#{@name}, please enter a name. Your name may be up to 10 chars max:\n\n"

    new_name = gets.chomp

    if valid_name?(new_name)
      new_name
    else
      new_name = enter_name
    end

    @name = new_name
  end

  def choose_symbol
    puts <<~HEREDOC

      #{@name}, choose a symbol. Your symbol can be any char except a white-space or #.

    HEREDOC

    sym = gets.chomp

    if valid_symbol?(sym)
      sym
    else
      sym = choose_symbol
    end

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

  def valid_name?(name_string)
    if /\S/.match(name_string) && name_string.size.between?(1, 10)
      true
    else
      false
    end
  end
end
