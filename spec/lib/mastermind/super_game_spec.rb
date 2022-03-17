# frozen_string_literal:true

require_relative '../../../lib/mastermind/game'
require_relative '../../../helper/string_color_helper'
require_relative '../../helper/spec_helper'

module Mastermind
  RSpec.describe 'MastermindGame class using version :super' do
    before do
      @game = Mastermind::MastermindGame.new(:super)
    end

    it 'initializes game' do
      expect(@game.turns_remaining).to eq(nil)
      expect(@game.code_maker).to eq(nil)
      expect(@game.state).to eq(nil)
      expect(@game.version).to eq(:super)
    end

    it 'has a default of 12 turns' do
      expect(TURNS[@game.version]).to eq(12)
    end
  end

  RSpec.describe 'Start Super MastermindGame' do
    before do
      @game = Mastermind::MastermindGame.new(:super)
      @game.start_game
    end

    it 'when starting game, generates @code_maker with matching version' do
      expect(@game.code_maker.version).to eq(@game.version)
    end

    it 'can get current number of turns' do
      a = @game.g_turns

      expect(a.class).to eq(String)
      expect(a.inspect).to include('12')
    end

    it 'can take a successful turn' do
      turn = @game.take_turn(%w[W K G P C])

      expect(@game.turns_remaining).to eq(11)
      expect(turn[0]).to include('')
      expect(turn[1]).to include('')
    end

    it 'can check for invalid input when taking a turn' do
      input1 = %w[P P P P P P]
      input2 = %w[W C G W]

      expect(@game.take_turn(input1)).to eq(false)
      expect(@game.take_turn(input2)).to eq(false)
    end
  end
end
