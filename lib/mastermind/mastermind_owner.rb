# frozen_string_literal: true

require_relative '../../helper/game_settings_helper' # Includes game settings variables.

module Mastermind
  # Owner class is the Code-Maker. When generated, the Code-Breaker is guessing for @answer.
  class Owner
    include GameParams

    attr_reader :answer
    attr_accessor :version

    def initialize(version = :regular)
      @answer = [] # maintains position of colors in code
      @version = VERSIONS.include?(version) ? version : :regular
      create_code
    end

    def my_set(answer)
      @answer = answer
    end

    def compare_guess(guess)
      self.class.compare_guess(answer, guess)
    end

    def self.compare_guess(answer, guess)
      return false if answer.length != guess.length
      return false if guess.class != Array

      guess.each do |g|
        return false if g.class != String
        return false if g.length != 1
        return false unless VALID_OPTIONS[LENGTH.key(guess.length)].include?(g)
      end

      return true if guess == answer

      answer_hash = Hash.new(0)
      answer.each do |c|
        answer_hash[c] =
          answer.count(c)
      end
      correct = possible = 0
      tmp = [] # holds indexes of guesses that are not exactly 'correct'

      # below checks to see if any index is exactly correct
      guess.each_with_index do |c, i|
        if c == answer[i]
          correct += 1
          answer_hash[c] -= 1
        else
          tmp << i
        end
      end

      # below checks to see if the indexs have a possible match
      tmp.each do |t|
        if answer_hash[guess[t]].positive?
          possible += 1
          answer_hash[guess[t]] -= 1
        end
      end

      [correct, possible]
    end

    private

    def create_code
      LENGTH[version].times do
        @answer << VALID_OPTIONS[version].sample
      end
    end
  end
end
