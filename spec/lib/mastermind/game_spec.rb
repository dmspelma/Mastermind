# frozen_string_literal: true

require_relative '../../../lib/mastermind/game'
require_relative '../../../helper/string_color_helper'
require_relative '../../helper/spec_helper'

module Mastermind

  # Base kit of MastermindGame Class
  RSpec.describe MastermindGame do
    before do
      $stdout.stub(:write)
      @game = Mastermind::MastermindGame.new
    end

    it 'initializes game' do
      expect(@game.turns_remaining).to eq(nil)
      expect(@game.code_maker).to eq(nil)
      expect(@game.state).to eq(nil)
    end

    it 'has a default of 10 turns' do
      expect(Mastermind::MastermindGame::TURNS).to eq(10)
    end

    it 'can read/write @turns_remaining and @state' do
      expect(@game.turns_remaining).to eq(nil)
      @game.turns_remaining = 7
      expect(@game.turns_remaining).to eq(7)

      expect(@game.state).to eq(nil)
      @game.state = :test_state
      expect(@game.state).to eq(:test_state)
    end

    it 'only read @game_counter' do
      expect(@game.game_counter).to eq(0)
      expect {@game.game_counter = 3 }.to raise_error(NoMethodError)
    end
  end

  # Tests After MastermindGame Begins
  RSpec.describe 'Start MastermindGame' do
    before do
      $stdout.stub(:write)
      @game = Mastermind::MastermindGame.new
      @game.start_game
    end

    it 'starts a game' do
      expect(@game.turns_remaining).to eq(10)
      expect(@game.state).to eq(:in_progress)
      expect(@game.code_maker.class).to eq(Mastermind::Owner)
    end

    it 'can get current number of turns' do
      a = @game.get_turns
      expect(a.class).to eq(String)
      expect(a.inspect).to include('10')
    end

    it 'can take a successful turn' do
      turn = @game.take_turn(['W','K','G','W'])
      expect(@game.turns_remaining).to eq(9)
      expect(turn[0]).to include("")
      expect(turn[1]).to include("")
    end

    it 'can take a winning turn' do
      code = @game.code_maker
      winning_turn = @game.take_turn(code.answer)
      expect(@game.turns_remaining).to eq(9)
      expect(winning_turn).to eq(:winner)
    end

    it 'can check for invalid input when taking a turn' do
      input1 = 'eeee'.upcase.chars
      input2 = 'kasdinfosbunaodimsf123r029jf!@#'.upcase.chars
      input3 = []

      expect(@game.take_turn(input1)).to eq(false)
      expect(@game.take_turn(input2)).to eq(false)
      expect(@game.take_turn(input3)).to eq(false)
    end

    it 'game won' do
      @game.won
      expect(@game.state).to eq(:winner)
    end

    it 'game lost' do
      @game.lost
      expect(@game.state).to eq(:loser)
    end

    it 'can keep count of multiple games in session' do
      @game.add_game
      expect(@game.game_counter).to eq(1)
      @game.add_game
      expect(@game.game_counter).to eq(2)
    end
  end
end

