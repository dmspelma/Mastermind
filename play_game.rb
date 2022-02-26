# frozen_string_literal: true
require './game'
require './helper/string_color_helper'

QUIT_CONTENTS = ['quit','q','n','no','exit']
@game_counter = 0

loop do
  puts 'Starting Masterminds...'.yellow
  game = MastermindGame.new
  puts "Creating Game...".yellow
  game.start_game

  if game.game_counter < 1
    print 'Type '.blue
    print 'help'.cyan
    puts ' if you require instructions.'.blue
  end

  while game.turns_remaining.positive?
    print "What is your guess? ".green
    puts "(Turns Remaining: #{game.get_turns})".magenta
    player_guess = gets.chomp.upcase.chars
    case player_guess.join.downcase
    when 'help'
      puts "-".cyan * 83
      puts 'Your goal is to crack the code! The code is a 4-color combination of the following:'.green
      puts "`R` for Red".red
      puts "`G` for Green".green
      puts "`B` for Blue".blue
      puts "`Y` for Yellow".yellow
      puts "`W` for White".white
      puts "`K` for Black".black
      print 'NOTE: '.red
      puts 'There can be multiples of the same color.'.green
      puts "-".cyan * 83
    when 'q', 'quit', 'exit'
     puts "Terminating Game...".red
     break
    else
      attempt = game.take_turn(player_guess)
      if !attempt
        puts 'Invalid Guess. Please take a look at your input, and ensure it is valid.'.red
        puts 'If you are unsure, please try command \'help\'.'.red
      elsif attempt == :winner
        break
      else
        print "Correct: #{attempt[0]} ".cyan
        puts "| Correct Color, Wrong Spot: #{attempt[1]}".cyan
      end
    end
    if game.turns_remaining == 0
      puts 'GAME OVER!'.red
      puts 'Ran Out Of Turns'.red
    end
  end
  break if QUIT_CONTENTS.include?(player_guess.join.downcase)
  game.lost if game.state == :loser

  print 'Would you like to play again?'.green
  puts ' (Press Q to quit)'.yellow
  case gets.chomp.downcase
  when 'q', 'quit', 'exit'
    puts "Thank you for playing. Goodbye.".green
    break
  else
    puts 'Loading another round...'.yellow
  end

  game.add_game
end
