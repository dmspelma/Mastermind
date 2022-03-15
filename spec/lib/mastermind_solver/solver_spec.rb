# frozen_string_literal: true

require_relative '../../../lib/mastermind_solver/solver'

module MastermindSolver
  describe Solver do
    before do
      @my_solver = MastermindSolver::Solver.new
      $stdout.stub(:write)
    end

    it 'creates solver and initializes with default values' do
      expect(@my_solver.correct_answer).to eq(nil)
      expect(@my_solver.turns_to_solve).to eq(0)
      expect(@my_solver.owner).to_not eq(nil)
      expect(@my_solver.state).to eq(:unsolved)
    end

    it 'verifies fill_set method creates set with 1296 different entries' do
      expect(@my_solver.solutions_set.length).to eq(1296)
      expect(@my_solver.solutions_set.include?(['R','R','R','R'])).to eq(true)
      expect(@my_solver.solutions_set.include?(['R','R','G','B'])).to eq(true)
    end

    it 'restart method generates new values for initialized variables WITHOUT .solve' do
      original_correct_answer = @my_solver.correct_answer
      original_turns_to_solve = @my_solver.turns_to_solve
      original_owner          = @my_solver.owner
      original_solutions_set  = @my_solver.solutions_set
      original_state          = @my_solver.state
      @my_solver.restart

      expect(@my_solver.correct_answer).to eq(original_correct_answer)
      expect(@my_solver.turns_to_solve).to eq(original_turns_to_solve)
      expect(@my_solver.owner).to_not eq(original_owner)
      expect(@my_solver.solutions_set).to eq(original_solutions_set)
      expect(@my_solver.state).to eq(original_state)
    end

    it 'return type for restart method is `:unsolved`' do
      return_type = @my_solver.restart

      expect(return_type).to eq(:unsolved)
    end

    it 'restart method generates new values for initialized variables AFTER .solve' do
      @my_solver.solve
      original_correct_answer = @my_solver.correct_answer
      original_turns_to_solve = @my_solver.turns_to_solve
      original_owner          = @my_solver.owner
      original_solutions_set  = @my_solver.solutions_set
      original_state          = @my_solver.state
      @my_solver.restart

      expect(@my_solver.correct_answer).to_not eq(original_correct_answer)
      expect(@my_solver.turns_to_solve).to_not eq(original_turns_to_solve)
      expect(@my_solver.owner).to_not eq(original_owner)
      expect(@my_solver.solutions_set).to_not eq(original_solutions_set)
      expect(@my_solver.state).to_not eq(original_state)
    end

    it 'can solve for owner code' do
      to_solve_for = @my_solver.owner.answer
      @my_solver.solve

      expect(@my_solver.correct_answer).to eq(to_solve_for)
      expect(@my_solver.state).to eq(:solved)
    end

    it 'solve method returns pair containing: @correct_answer, @turns_to_solve' do
      my_pair = @my_solver.solve

      expect(my_pair.class).to eq(Array)
      expect(my_pair.length).to eq(2)
      expect(my_pair[0]).to eq(@my_solver.correct_answer)
      expect(my_pair[1]).to eq(@my_solver.turns_to_solve)
    end

    it 'trying to solve already solved `solver` class results in `false` return type' do
      @my_solver.solve

      return_type = @my_solver.solve
      expect(return_type).to eq(false)
    end

    it 'when solving, makes the solution_set smaller by calling prune_set' do
      original_length = @my_solver.solutions_set.length
      @my_solver.solve

      expect(original_length).to be > @my_solver.solutions_set.length
    end

    it 'can benchmark solving for the master code' do
      expect(@my_solver.benchmark(2)).to_not eq(nil)
    end

    it 'return-type for benchmark is a tuple of: total_time, average_time, average_turn_count' do
      return_type = @my_solver.benchmark(2)

      expect(return_type.class).to eq(Array)
      expect(return_type.length).to eq(3)
      expect(return_type[0]).to be > 1.0 # total_time is above 1s. Unless both tests guess on first try.
      expect(return_type[0].class).to eq(Float)
      expect(return_type[1]).to be > 0.0 # avg_time is ~0.67s
      expect(return_type[1]).to be < 1.0
      expect(return_type[1].class).to eq(Float)
      expect(return_type[2]).to be <= 5 # appears that max turns_to_solve is 5 w/ current implementation.
      expect(return_type[2].class).to eq(Float)
    end

    it 'benchmark method only accepts positive numbers' do
      try_zero     = @my_solver.benchmark(0)
      try_negative = @my_solver.benchmark(-1)
      try_letter   = @my_solver.benchmark('a')
      try_nil      = @my_solver.benchmark(nil)

      expect(try_zero).to eq(false)
      expect(try_negative).to eq(false)
      expect(try_letter).to eq(false)
      expect(try_nil).to eq(false)
    end
  end
end
