# frozen_string_literal: true

require_relative 'mastermind_owner'
require_relative '../../helper/color_options_choice'

# handles game initialization + processes for playing game
module Mastermind
  # The Game class. This handles game mechanics
  class MastermindGame
    attr_reader :game_counter,
                :code_maker
    attr_accessor :turns_remaining,
                  :state

    TURNS = 10

    def initialize
      @turns_remaining = nil
      @code_maker = nil
      @state = nil
      @game_counter = 0
    end

    def start_game
      @turns_remaining ||= TURNS
      @state = :in_progress
      @code_maker = Mastermind::Owner.new
    end

    def g_turns
      @turns_remaining.to_s.red
    end

    def take_turn(player_guess)
      if validate(player_guess)
        @turns_remaining -= 1
        ans = @code_maker.compare_guess(player_guess)
        if ans == true
          won
        else
          [ans[0].to_s.green,
           ans[1].to_s.yellow]
        end
      else
        false # invalid input, cannot take a turn
      end
    end

    def won
      print 'Congrats! You have cracked the code with '.green
      print @turns_remaining.to_s.blue
      puts ' turns left!'.green
      @state = :winner
    end

    def lost
      puts 'GAME OVER!'.red
      puts 'You have ran out of turns!'.red
      print "The Mastermind's code was: ".red
      puts @code_maker.answer.join.to_s.white
      @state = :loser
    end

    def add_game
      @game_counter += 1
    end

    private

    def validate(guess)
      result = true
      result &= guess.instance_of?(Array)
      result &= guess.length == 4
      guess.each do |i|
        result &= (OPTIONS).include?(i)
      end

      result
    end
  end
end
