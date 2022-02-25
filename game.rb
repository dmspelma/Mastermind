# frozen_string_literal: true

require_relative 'mastermind_owner'

# handles game initialization + processes for playing game
class MastermindGame
  attr_accessor :turns_remaining, :state

  TURNS = 10

  def initialize
    @turns_remaining = nil
    @code_maker = nil
    @state = :in_progress
  end

  def start_game
    @turns_remaining ||= TURNS
    @code_maker = Owner.new
  end

  def take_turn(player_guess)
    if validate(player_guess)
      @turns_remaining -= 1
      ans = @code_maker.compare_guess(player_guess)
      if ans == true
        won
      else
        ans
      end
    else
      false # invalid input, cannot take a turn
    end
  end

  def won
    @turns_remaining = 0
    puts "Congrats! You have cracked the code!"
    @state = :winner
  end

  def lost
    @state = :loser
    puts "Oh no! You have lost."
    puts "The Mastermind's code was: #{Owner.answer}"
  end

  private

  def validate(guess)
    result = true
    result &= guess.instance_of?(Array)
    result &= guess.length == 4
    guess.each do |i|
      result &= (Owner::OPTIONS).include?(i) ? true : false
    end

    result
  end
end
