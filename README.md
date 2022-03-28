# Mastermind

## A Terminal-Based version of the game `Masterminds`. This Application also includes a solver, which when ran will automatically solve for the master_code in the most efficient way possible.

### To Package Gem and Run Executable:
1. Navigate to warrantyApp main folder in terminal. If you type ls command in terminal, you should see .gemspec file
2. Type: 'gem build mastermind.gemspec'
3. Type: 'gem install Mastermind-1.0.0.gem' (NOTE: version may be different)
4. Type: 'Mastermind' to run program from anywhere

### To Only Run Program:
1. Navigate to `mastermind` main folder in terminal. Once in the folder, if you type ls command in terminal, you should see .gemspec file
2. Type: `cd /bin/` to navigate to the bin
3. Type: `ruby Mastermind` (Alternatively, if you don't type command above, use: `ruby /bin/Zephyr`)

### To Run Mastermind Solver:
1. The Mastermind Solver is a class that can be ran in a irb session
	- While in main application folder, type `irb -r ./lib/mastermind_solver/solver.rb` to load the file into an irb session
2. `MastermindSolver::Solver.new` creates a new instance of the solver class.
	- The `.solve` method will solve for the solution. It will return an array containing [`master_code`, `turns_to_solve_for_code`]
	NOTE: This puts the Solver class in state `:solved`. In order to solve again, first run `.restart`
	- The `.benchmark(num)` method will perform the above 2 methods `num` of times. It will return an array containing [`total_time`, `avg_time_to_solve`, `avg_turns_to_solve`, `max_turns_to_solve`]
3. If you want to run the Super Mastermind Solver, simple include the parameter `:super` to the `.new` method, such as: `MastermindSolver::Solver(:super)`.



### Special Notes:
- Rspec is used to run tests.
  To run all tests:
  1. Navigate to folder containing application files and type `rspec`.
  2. 2. Navigate to the `spec` folder and run `rspec .`
<br>
<br>
# How to Play Mastermind

## Rules:
	The Code-Maker has generated a 4 - Letter code. Each letter corresponds to a color:
		-> `R` = Red
		-> `G` = Green
		-> `B` = Blue
		-> `Y` = Yellow
		-> `W` = White
		-> `K` = Black
	
	Your goal is to crack the code! Example: 'BGYY'

	You will receive a response consisting of:
		1. The number of exactly correct colors in the code.
		2. The number of correct colors in the code, but in the wrong position.

	You only have 10 guesses to correctly guess the code, otherwise you lose!

	There is an in-game `help` option designed to review these rules.

	You can press `q`, `exit`, or `quit` during any input to quit and close the game.

# Differences between Mastermind and Super Mastermind Game Versions
1. Super Mastermind requires a 5-letter code.
2. Super Mastermind has 8 color options:
	-> `R` = Red
	-> `G` = Green
	-> `B` = Blue
	-> `Y` = Yellow
	-> `W` = White
	-> `C` = Cyan
	-> `P` = Purple
	-> `K` = Black
3. You only have 12 turns to solve for the code!

## Benchmarks

I started with version 1.0.0. Since adding the benchmark method to the Solver class, I tried to benchmark the program's performance. I ran 1296 tests per attempt, and ran 11 attempts. 

Each attempt always started with the same initial guess: R R G G.

I aggregated the data into a spreadsheet to find the average total values returned from the benchmark method. 

At the end I have included my machine's specs, because if you were to repeat the tests you may expeience differences due to machine performance.

<div style="width: 400px; height: 300px">
	<img src="/assets/images/mastermind_solver/benchmark_solver_data_1.png" alt="Benchmark results for solve method" title="Benchmark Results Version 1.0.0">
</div>

Version 1.1.0 introduced a single change to the solver. Originally, I was comparing the entire `answer_set` with the remaining `solutions_set`. This is because it is possible that the best guess to take may be a guess that doesn't exist in the remaining `solutions_set`. By changing this to only compare the entire `solutions_set` with itself, this sped up calculations by approximately 6 times, while increasing the number of turns to solve by +1.

This also made it possible to solve for the Super Mastermind. However, it was still quite inefficient for this version due to the sheer number of calculations needed when attempting to calculate the best second guess.

<div style="width: 400px; height: 300px;">
	<img src="/assets/images/mastermind_solver/benchmark_solver_data_2.png" alt="Benchmark results for solve method" title="Benchmark Results Version 1.1.0">
</div>

Version 1.2.0 introduced the idea of storing a pre-calculated guess to take based on the response of the first guess. Essentially, the longest amount of time when attempting to solve is because of the number of calculations needed to determind the best second guess. Since the guess is chosen with the lowest priority first, it is possible to `pre-guess` the second guess. After the first turn, I reference a saved map of guesses. For example, if I receive the response `[0,2]` when I take the first guess, I know its HIGHLY LIKELY the second guess will be `G G R G`.

After, the remaining `solutions_set` is even smaller, so it can even more quickly determine the next guesses. The this turns out to be more than 43x faster than the original implementation. However, this does increase the amount of guesses by up to +3 for a total max turns to solve of 8.

<div style="width: 400px; height: 300px;">
	<img src="/assets/images/mastermind_solver/benchmark_solver_data_3.png" alt="Benchmark results for solve method" title="Benchmark Results Version 1.2.0">
</div>
