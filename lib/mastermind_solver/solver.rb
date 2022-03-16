# frozen_string_literal: true

require_relative '../mastermind/mastermind_owner'
require_relative '../../helper/color_options_choice' # Includes OPTIONS hash which refers to colors
require_relative '../../helper/string_color_helper' # Adds colors to output
require_relative '../../helper/game_settings_helper'
require 'benchmark'

module MastermindSolver
  # Class that solves (and benchmarks) for Mastermind::Owner.answer
  class Solver
    attr_reader :correct_answer,
                :turns_to_solve,
                :owner,
                :solutions_set,
                :state

    def initialize
      @correct_answer = nil
      @turns_to_solve = 0
      @state = :unsolved
      @owner = Mastermind::Owner.new
      @answer_set = fill_set
      @solutions_set = fill_set
    end

    # solves for master code (Owner.answer)
    def solve
      if @state == :solved
        puts 'You have already solved. You need to perfor `.restart` before you can try again'
        return false
      end
      guess = %w[R R G G] # starting guess is based off of Wikipedia's Five-guess algorithm
      loop do
        @turns_to_solve += 1
        x = @owner.compare_guess(guess)
        break if x == true

        # remove from S any code that would not give the same response if it were the code.
        prune_set(
          @solutions_set, guess, x
        )
        # Apply minimax theory
        guess = minimax # update the guess based on applying minimax.
        # Minimax will call to find best guess to return.
      end
      @state = :solved
      print "Found answer: #{@correct_answer = guess}, and it took ".cyan
      print "#{@turns_to_solve} ".red
      puts  'turns to solve.'.cyan
      [@correct_answer, @turns_to_solve]
    end

    # For restarting solver to default status, without re-loading @answer_set
    def restart
      @solutions_set = fill_set
      @owner = Mastermind::Owner.new
      @correct_answer = nil
      @turns_to_solve = 0
      @state = :unsolved
    end

    def benchmark(number_of_tests)
      if number_of_tests.class != Integer || number_of_tests <= 0
        puts 'Method only accepts positive numbers'
        return false
      end
      time = []
      number_of_tests.times do
        time << [Benchmark.realtime do
                   restart
                   solve
                 end, turns_to_solve]
      end
      restart
      calculate_and_return(time, number_of_tests)
    end

    private

    def calculate_and_return(my_info, number_of_tests)
      answer = [0, 0, 0] # [total_time, turns, max_turn]
      my_info.each do |x|
        answer[0] += x[0]
        answer[1] += x[1]
        answer[2] = [answer[2], x[1]].max
      end
      benchmark_print(
        [answer[0], answer[0].to_f / my_info.length, answer[1].to_f / my_info.length,
         answer[2]], number_of_tests
      )
      [answer[0], answer[0].to_f / my_info.length,
       answer[1].to_f / my_info.length, answer[2]]
    end

    def benchmark_print(answer, number_of_tests)
      print 'Entered # ofAttempts: '.yellow
      print number_of_tests.to_s.red
      print ' | Total Realtime: '.yellow
      print answer[0].to_s.blue
      print ' | Avg Time: '.yellow
      print (answer[1]).to_s.green
      print ' | Avg Number of Turns Taken: '.yellow
      print (answer[2]).to_s.green
      print ' | Max Turns Taken: '.yellow
      puts  answer[3].to_s.blue
    end

    # Fill set with all possible code combinations. 1296 combinations.
    def fill_set
      s = Set.new
      if owner.version == :regular
        OPTIONS[owner.version].each do |i|
          OPTIONS[owner.version].each do |j|
            OPTIONS[owner.version].each do |k|
              OPTIONS[owner.version].each do |l|
                s.add([i, j, k, l])
              end
            end
          end
        end
      else
        OPTIONS[owner.version].each do |a|
          OPTIONS[owner.version].each do |b|
            OPTIONS[owner.version].each do |c|
              OPTIONS[owner.version].each do |d|
                OPTIONS[owner.version].each do |e|
                  s.add([a, b, c, d, e])
                end
              end
            end
          end
        end
      end
      s
    end

    # removes guess from @solutions_set if any remaining guesses do not return exact same result.
    def prune_set(set, guess, response)
      set.delete(guess)
      set.each do |guess_set|
        x = Mastermind::Owner.compare_guess(
          guess, guess_set
        )
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
          correct_possible = Mastermind::Owner.compare_guess(
            full_answer, possible_answer
          )
          map[correct_possible] += 1
        end
        max = map.values.max
        score[full_answer] =
          max
        map.clear
      end
      min = score.values.min
      score.each do |key, value|
        # puts "Score |key, value| = |#{key}, #{value}|"
        next_guesses << key if value == min
      end
      # puts "score is: #{score}"
      # puts "next_guess is: #{next_guesses}"
      get_next_guess(next_guesses) # Return best guess from list. Prioritizes lowest
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
