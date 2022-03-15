# Mastermind

### A Terminal-Based version of the game `Masterminds`. This Application also includes a solver, which when ran will automatically solve for the `master_code` in the most efficient way possible.

###### To Package Gem and Run Executable:
	1. Navigate to warrantyApp main folder in terminal. If you type ls command in terminal, you should see .gemspec file
	2. Type: 'gem build mastermind.gemspec'
	3. Type: 'gem install Mastermind-1.0.0.gem' (NOTE: version may be different)
	4. Type: 'Mastermind' to run program from anywhere

###### To Only Run Program:
	1. Navigate to `mastermind` main folder in terminal. Once in the folder, if you type ls command in terminal, you should see .gemspec file
	2. Type: `cd /bin/` to navigate to the bin
	3. Type: `ruby Mastermind` (Alternatively, if you don't type command above, use: `ruby /bin/Zephyr`)

###### To Run Mastermind Solver:
	1. The Mastermind Solver is a class that can be ran in a irb session
		-> While in main application folder, type 'irb -r ./lib/mastermind_solver/solver.rb' to load the file into an irb session
		a. `MastermindSolver::Solver.new` creates a new instance of the solver class.
		b. The `.solve` method will solve for the solution. It will return an array containing [`master_code`, `turns_to_solve_for_code`]
			- NOTE: This puts the Solver class in state `:solved`. To perform again, run `.restart`
		c. The `.benchmark(num)` method will perform the above 2 methods `num` of times. It will return an array containing [`total_time`, `avg_time_to_solve`, `avg_turns_to_solve`, `max_turns_to_solve`]


###### Special Notes:
	- Rspec is used to run tests.
		-> To run all tests:
			1. Navigate to folder containing application files and type `rspec`
			2. Navigate to the `spec` folder and run `rspec .`


### How to Play Mastermind

#### Rules:
	The Code-Maker has generated a 4 - Letter code. Each letter corresponds to a color:
		-> `R` = Red
		-> `G` = Green
		-> `B` = Blue
		-> `Y` = yellow
		-> `W` = Yellow
		-> `K` = Black
	
	Your goal is to crack the code! Example: 'BGYY'

	You only have 10 guesses to correctly guess the code, otherwise you lose!

	There is an in-game `help` option designed to review these rules.

	You can press `q`, `exit`, or `quit` during any input to quit and close the game.

### Benchmarks

Since adding the benchmark method to the Solver class, I tried to benchmark the program's performance. I ran 1296 tests per attempt, and ran 11 attempts. I aggregated the data into a spreadsheet to find the average total values returned from the benchmark method. At the end I have included my machine's specs, because if you were to repeat the tests you may expeience differences due to machine performance.

<div style="width:400px ; height:300px">
	<img src="/assets/images/mastermind_solver/benchmark_solver_data.png" alt="Benchmark results for solve method" title="Benchmark Results">
</div>
