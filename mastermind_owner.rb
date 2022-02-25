# frozen_string_literal: true

# This class is the Code Creator.
# It can compare a received input to check validity
class Owner
  attr_reader :answer

  OPTIONS = ['R', # red
             'G', # green
             'B', # blue
             'Y', # yellow
             'W', # white
             'K'].freeze # black

  def initialize
    @answer = [] # maintains position of colors in code
    @answer_hash = Hash.new(0)
    create_code
  end

  def compare_guess(guess)
    return true if guess == @answer

    answer_hash = @answer_hash
    correct = 0
    possible = 0
    tmp = [] # holds indexes of guesses that are not exactly 'correct'
    # check to see if any index is exactly correct
    guess.each_with_index do |c, i|
      if c == @answer[i]
        correct += 1
        answer_hash[c] -= 1
      else
        tmp << i
      end
    end
    # check to see if the indexs have a possible match
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
    4.times do
      @answer << OPTIONS.sample
    end

    @answer.each do |c|
      @answer_hash[c] = @answer.count(c)
    end
  end
end


