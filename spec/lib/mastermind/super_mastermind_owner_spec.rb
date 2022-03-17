# frozen_string_literal:true

require_relative '../../../lib/mastermind/mastermind_owner'

module Mastermind
  RSpec.describe 'Owner class using :super version' do
    before do
      @code_maker = Mastermind::Owner.new(:super)
    end

    it 'creates a code on initialization' do
      expect(@code_maker.answer.class).to eq(Array)
      expect(@code_maker.answer.length).to eq(LENGTH[@code_maker.version])
      @code_maker.answer.each do |code|
        expect(OPTIONS[@code_maker.version]).to include(code)
      end
    end

    it 'version param matches :super' do
      expect(@code_maker.version).to eq(:super)
    end

    it 'each code on initialization is random' do
      @code_maker_dup = Mastermind::Owner.new(:super)
      # Added while loop here to prevent 1/32768 chance of failing test
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
      # 1/32768 chance of this occurring.
      while x == true
        answer = []
        LENGTH[@code_maker.version].times do
          answer << OPTIONS[@code_maker.version].sample
        end
        x = @code_maker.compare_guess(answer)
      end
      expect(x.class).to eq(Array)
      expect(x.length).to eq(2)
      expect(x[0] + x[1]).to be <= 5
    end

    it 'can compare guesses without an instance of the class' do
      a = %w[R G B P C]
      b = %w[R G B K C]
      expect(Mastermind::Owner.compare_guess(a, b)).to eq([4, 0])
      expect(Mastermind::Owner.compare_guess(a, a.dup)).to eq(true)
    end

    it 'compare_guess checks for input length' do
      a = %w[R G B W K]
      b = %w[R G B W]
      expect(Mastermind::Owner.compare_guess(a, b)).to eq(false)
      expect(@code_maker.compare_guess(b)).to eq(false)
    end

    it 'has specific color options for regular version' do
      my_options = %w[R G B Y C P W K]
      my_options.each do |o|
        expect(OPTIONS[@code_maker.version].include?(o)).to eq(true)
      end
      expect(OPTIONS[@code_maker.version].length).to eq(8)
    end
  end
end
