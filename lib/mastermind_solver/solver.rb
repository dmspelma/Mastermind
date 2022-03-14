# frozen_string_literal: true

require_relative '../mastermind/mastermind_owner'
require_relative '../../helper/color_options_choice' # Includes OPTIONS hash which refers to colors
require_relative '../../helper/string_color_helper' # Adds colors to output
require 'benchmark'

module MastermindSolver
	class Solver
		attr_reader :correct_answer, :turns_to_solve, :owner

		def initialize
			@correct_answer = nil
			@turns_to_solve = 0
      @answer_set = fill_set
      @solutions_set = fill_set
      @owner = Mastermind::Owner.new
		end

    # solves for master code (Owner.answer)
		def solve
      guess = ['R','R','G','G'] # starting guess is based off of Wikipedia's Five-guess algorithm
      print "Taking guesses: ".yellow
      loop do
        print "#{guess} ".yellow
        @turns_to_solve += 1
        x = @owner.compare_guess(guess)
        break if x == true
        # remove from S any code that would not give the same response if it (the guess) were the code.
        prune_set(@solutions_set, guess, x)
        # Apply minimax theory
        guess = minimax # update the guess based on applying minimax.
                        # Minimax will call to find best guess to return.
      end
      print "\nFound answer: #{@correct_answer = guess}, and it took ".cyan
      print "#{@turns_to_solve} ".red
      puts  "turns to solve.".cyan
      return [@correct_answer, @turns_to_solve]
		end

    # For restarting solver to default status, without re-loading @answer_set
    def restart
      @solutions_set = fill_set
      @owner = Mastermind::Owner.new
      @correct_answer = nil
      @turns_to_solve = 0
    end

    def benchmark_solver(number_of_tests)
      return 'Method only accepts positive numbers' if number_of_tests.class != Integer or number_of_tests < 0
      time = Benchmark.measure do
        number_of_tests.times { self.restart ; self.solve }
      end

      puts time
    end

    private

    # Fill set with all possible code combinations. 1296 combinations.
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

    # removes guess from @solutions_set if any remaining guesses do not return exact same result.
    def prune_set(set, guess, response)
      set.delete(guess)
      set.each do |guess_set|
        x = Mastermind::Owner.compare_guess(guess, guess_set)
        set.delete(guess_set) unless x == response
      end
    end

    # Finds the Maximum number of possible correct `guesses`
    # Then, it chooses the `guess` that provies the smallest number of possible changes
    def minimax
      next_guesses = [] # This is what will be returned. An array of guesses to take.
      score = {} # This will hold a map of guesses => max_score
      map = Hash.new(0) # This will hold a map of score_sets => scores.
      min = max = 0

      @answer_set.each do |full_answer|
        @solutions_set.each do |possible_answer|
          correct_possible = Mastermind::Owner.compare_guess(full_answer, possible_answer)
          map[correct_possible] += 1
        end
        max = map.values.max
        score[full_answer] = max
        map.clear
      end
      min = score.values.min
      score.each do |key, value|
        # puts "Score |key, value| = |#{key}, #{value}|"
        next_guesses << key if value == min
      end
        # puts "score is: #{score}"
        # puts "next_guess is: #{next_guesses}"
      return get_next_guess(next_guesses) # Return best guess from list. Prioritizes lowest
    end

    # returns the first guess that exists.
    def get_next_guess(guesses)
      # first checks @solutions_set for guess.
      guesses.each do |g|
        return g if @solutions_set.include?(g)
      end

      # If not found above, then checks @answer_set.
      guesses.each do |g|
        return g if @answer_set.include?(g)
      end
    end

	end
end





