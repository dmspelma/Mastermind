# frozen_string_literal: true
require_relative 'mastermindOwner'

# handles game initialization + processes for playing game
class MastermindGame
  attr_accessor :turns_remaining
  TURNS = 10.freeze

  def initialize
    @turns_remaining = nil
    @code_maker = nil
  end

  def start_game
    @turns_remaining ||= TURNS
    @code_maker = Owner.new
  end

  def take_turn(player_guess)
    v = validate(player_guess)
    puts "Invalid Input, please verify you are entering correct information" if v == false

    @turns_remaining -= 1

    
  end

  private

  def validate(guess)
    result = true
    result &= (guess.class == Array) ? true : false
    result &= (guess.length == 4) ? true : false

    guess.each do |i|
      result &= (Owner::OPTIONS).include?(i) ? true : false
    end

    return result
  end
end
