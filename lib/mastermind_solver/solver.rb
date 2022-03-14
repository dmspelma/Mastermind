# frozen_string_literal: true

require_relative '../mastermind/mastermind_owner'

module Mastermind
	class Solver
		attr_reader :correct_answer, :turns_to_solve

		OPTIONS = ['R', # red
		           'G', # green
		           'B', # blue
		           'Y', # yellow
		           'W', # white
		           'K'].freeze # black

		def initialize
			@correct_answer = nil
			@turns_to_solve = 0
      @answer_set = fill_set
      @owner = Mastermind::Owner.new
		end


		private

		def solve
      guess = ['R','R','G','G'] # starting guess is based off of Wikipedia's Five-guess algorithm
      x = [0,0]
      loop do # format is [correct, possible]
        @turns_to_solve += 1
        x = @owner.compare_guess(guess)
        break if x == [4,0]
        @answer_set.delete(guess)
        # remove from S any code that would not give the same response if it (the guess) were the code.
        prune_set(@answer_set, guess, x)
        # Apply minimax theory

      end
      return [guess, @turns_to_solve]
		end

		def fill_set
    s = Set.new
			OPTIONS.each do |i|
				OPTIONS.each do |j|
					OPTIONS.each do |k|
						OPTIONS.each do |l|
							s.add([i, j, k, l])
						end
					end
				end
			end
    return s
		end

    def prune_set(set, guess, response)
      set.each do |guess_set|
        x = Mastermind::Owner.compare_guess(guess, guess_set)
        set.delete(guess_set) unless x == response
      end
    end

    def minimax(set)

    end

	end
end
