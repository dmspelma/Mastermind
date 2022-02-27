# frozen_string_literal: true
require_relative '../../lib/mastermind/mastermind_owner'

module Mastermind
  describe Owner do

    before do
      @code_maker = Mastermind::Owner.new
    end

    it 'creates a code on initialization' do
      expect(@code_maker.answer.class).to eq(Array)
      expect(@code_maker.answer.length).to eq(4)
      @code_maker.answer.each do |code|
        expect(Mastermind::Owner::OPTIONS.include?(code)).to eq(true)
      end
    end

    it 'each code on initialization is random' do
      @code_maker_dup = Mastermind::Owner.new
      # Added while loop here to prevent 1/1296 chance of failing test
      while @code_maker_dup.answer == @code_maker.answer
        @code_maker_dop = Mastermind::Owner.new
      end
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
           answer << Mastermind::Owner::OPTIONS.sample
         end
         x = @code_maker.compare_guess(answer)
      end
      expect(x.class).to eq(Array)
      expect(x.length).to eq(2)
      expect(x[0] + x[1]).to be <=4
    end

    it 'has specific color options' do
      my_options = ['R','G','B','Y','W','K']
      my_options.each do |o|
        expect(Mastermind::Owner::OPTIONS.include?(o)).to eq(true)
      end
      expect(Mastermind::Owner::OPTIONS.length).to eq(6) # verifies we have checked all color options.
    end
  end
end
