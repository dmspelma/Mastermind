# frozen_string_literal: true
require 'game'
require 'mastermind_owner'

loop do
  puts '*Starting Masterminds...*'
  game = MastermindGame.new
  game.start_game

  puts 'Type \'help\' if you require instructions.'

  while game.turns_remaining.positive?
    puts "What is your guess? (Turns Remaining: #{game.turns_remaining})"
    player_guess = gets.chomp.upcase.chars
    case player_guess
    when 'help'
      puts 'Your goal is to crack the code! The code is a 4-color combination of the following: '
      puts "`R` for Red\n"
      puts "`G` for Green\n"
      puts "`B` for Blue\n"
      puts "`Y` for Yellow\n"
      puts "`W` for White\n"
      puts "`K` for Black\n"
    else
      attempt = game.take_turn(player_guess)
      if !attempt
        puts 'Invalid Guess. Please take a look at your input, and ensure it is valid.'
        puts 'If you are unsure, please try command \'help\''
      elsif attempt == :winner
        game.won
        break
      else
        puts "Correct: #{attempt[0]} | Correct Color, Wrong Spot: #{attempt[1]}."
      end
    end
  end

  game.lost if game.state = :loser

  puts 'Would you like to play again? (Press Q to quit)'
  case gets.chomp.downcase
  when 'q', 'quit', 'exit'
    puts "Thank you for playing. Goodbye."
    break
  else
    puts 'Loading another round.'
  end
end
