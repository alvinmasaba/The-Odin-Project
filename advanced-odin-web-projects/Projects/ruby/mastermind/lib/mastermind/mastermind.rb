# frozen_string_literal: true

module MasterMind
  private

  def num_human_players(game)
    puts "Enter the number of human players (1 or 2):\n\n"
    num = gets.chomp.to_i
    case num
    when 0 
      [ComputerPlayer.new(game), ComputerPlayer.new(game)]
    when 1
      [HumanPlayer.new(game), ComputerPlayer.new(game)] 
    when 2 
      [HumanPlayer.new(game), HumanPlayer.new(game)] 
    else
      num_human_players(game)
    end
  end

  def choose_code_maker(player1, player2, players)
    puts "\nDecide who will be the codemaker.\n\n"
    puts "Enter 1 for #{player1} or 2 for #{player2}.\n\n"
    case gets.chomp.to_i
    when 1
      players[0].is_code_maker = true
    when 2
      players[1].is_code_maker = true
    else
      choose_code_maker(player1, player2, players)
    end
  end

  def choose_code_breaker(players)
    if players[0].is_code_maker
      players[1].is_code_breaker = true
    else
      players[0].is_code_breaker = true
    end
  end

  def switch(game, players)
    game.code_maker = players.reduce { |x, player| player.is_code_breaker ? player : x }
    game.code_breaker = players.reduce { |x, player| player.is_code_maker ? player : x }
  end
  
  def set_players(game, players)
    # Sets the codemaker and codebreaker for a match
    game.code_maker = players.reduce { |x, player| player.is_code_maker ? player : x }
    game.code_breaker = players.reduce { |x, player| player.is_code_breaker ? player : x }
  end

  def code_gen(game)
    game.secret_code = game.code_maker.secret_code
  end

  def set_num_rounds(game)
    puts "\nEnter the number of rounds you wish to play (1-12): \n\n"
    num_rounds = gets.chomp.to_i
    num_rounds.between?(1,12) ? game.num_rounds = num_rounds : set_num_rounds
  end
end
