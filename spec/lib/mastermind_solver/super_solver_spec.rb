# frozen_string_literal: true

require_relative '../../../lib/mastermind_solver/solver'

module MastermindSolver
  describe Solver do
    before do
      @my_solver = MastermindSolver::Solver.new(:super)
      $stdout.stub(:write)
    end

    it 'creates solver and initializes with default values' do
      expect(@my_solver.correct_answer).to eq(nil)
      expect(@my_solver.turns_to_solve).to eq(0)
      expect(@my_solver.owner).to_not eq(nil)
      expect(@my_solver.state).to eq(:unsolved)
      expect(@answer_set.inspect).to eq(@solutions_set.inspect)
    end

    it 'verifies fill_set method creates set with 32768 different entries' do
      expect(@my_solver.solutions_set.length).to eq(32_768)
      expect(@my_solver.solutions_set.include?(%w[R R R R R])).to eq(true)
      expect(@my_solver.solutions_set.include?(%w[R R G B P])).to eq(true)
      expect(@my_solver.solutions_set.include?(%w[K K K K P])).to eq(true)
    end

    it 'can solve for super-version owner code' do
      to_solve_for = @my_solver.owner.answer
      @my_solver.solve

      expect(@my_solver.correct_answer).to eq(to_solve_for)
      expect(@my_solver.state).to eq(:solved)
    end

    it 'can benchmark solving for super-version of master code' do
      expect(@my_solver.benchmark(2)).to_not eq(nil)
    end
  end
end
