# frozen_string_literal: true

require_relative '../../../lib/mastermind/mastermind_owner'

module Mastermind
  # Base kit for Owner Class.
  # Regular Mastermind
  RSpec.describe Owner do
    before do
      @code_maker = Mastermind::Owner.new
    end

    it 'creates a code on initialization' do
      expect(@code_maker.answer.class).to eq(Array)
      expect(@code_maker.answer.length).to eq(LENGTH[@code_maker.version])
      @code_maker.answer.each do |code|
        expect(OPTIONS[@code_maker.version].include?(code)).to eq(true)
      end
    end

    it 'version parameter is optional and defaults to :regular' do
      my_set = Mastermind::Owner.new(:regular)

      expect(my_set.answer.length).to eq(4)
      expect(my_set.version).to eq(@code_maker.version)
      expect(@code_maker.answer.length).to eq(4)
      expect(@code_maker.version).to eq(:regular)
    end

    it 'defaults invalid version option to :regular' do
      my_set_wrong = Mastermind::Owner.new(:test)
      expect(my_set_wrong.version).to eq(:regular)
    end

    it 'each code on initialization is random' do
      @code_maker_dup = Mastermind::Owner.new
      # Added while loop here to prevent 1/1296 chance of failing test
      @code_maker_dup = Mastermind::Owner.new while @code_maker_dup.answer == @code_maker.answer
      expect(@code_maker.answer).to_not eq(@code_maker_dup.answer)
    end

    it 'can compare guesses, returning true if the guess matches' do
      answer = @code_maker.answer
      expect(@code_maker.compare_guess(answer)).to eq(true)
    end

    it 'can compare guesses, returning array of length 2 if guess doesn\'t match' do
      answer = @code_maker.answer
      x = true
      # I force use of this loop at least once to ensure we get an `answer`
      # That doesn't match the @code_maker.answer
      # 1/1296 chance of this occurring.
      while x == true
        answer = []
        4.times do
          answer << OPTIONS[@code_maker.version].sample
        end
        x = @code_maker.compare_guess(answer)
      end
      expect(x.class).to eq(Array)
      expect(x.length).to eq(2)
      expect(x[0] + x[1]).to be <= 4
    end

    it 'checks validity for input when taking a guess' do

      expect(@code_maker.compare_guess('test')).to eq(false)
      expect(@code_maker.compare_guess(%w[G G G G G G])).to eq(false)
      expect(@code_maker.compare_guess(%w[GG GG GG GG])).to eq(false)
      expect(@code_maker.compare_guess(%w[1 1 1 1])).to eq(false)
      expect(@code_maker.compare_guess(%w[R P C C])).to eq(false)
    end

    it 'can compare guesses without an instance of the class' do
      a = %w[R G B W]
      b = %w[R G B K]
      expect(Mastermind::Owner.compare_guess(a, b)).to eq([3, 0])
      expect(Mastermind::Owner.compare_guess(a, a.dup)).to eq(true)
    end

    it 'compare_guess checks for input length' do
      a = %w[R G B W K]
      b = %w[R G B W]
      expect(Mastermind::Owner.compare_guess(a, b)).to eq(false)
      expect(@code_maker.compare_guess(a)).to eq(false)
    end

    it 'has specific color options for regular version' do
      my_options = %w[R G B Y W K]
      my_options.each do |o|
        expect(OPTIONS[@code_maker.version].include?(o)).to eq(true)
      end
      expect(OPTIONS[@code_maker.version].length).to eq(6)
    end
  end
end
