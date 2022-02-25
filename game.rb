# frozen_string_literal: true

require_relative 'mastermind_owner'

# handles game initialization + processes for playing game
class MastermindGame
  attr_accessor :turns_remaining

  TURNS = 10

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
    if v == false
      @turns_remaining -= 1
      ans = @code_maker.compare_guess(player_guess)
      if ans == true
        winner
      else
        puts "Correct Matches: #{ans[0]} | Correct Color But Wrong Spot: #{ans[1]}"
      end
    else
      puts 'Invalid Input, please verify you are entering correct information'
    end
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
