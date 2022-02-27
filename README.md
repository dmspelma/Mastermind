# Mastermind

### A Terminal-Based version of the game `Masterminds`.

###### To package gem and run executable:
	1. Navigate to warrantyApp main folder in terminal. If you type ls command in terminal, you should see .gemspec file
	2. Type: 'gem build mastermind.gemspec'
	3. Type: 'gem install Mastermind-1.0.0.gem' (NOTE: version may be different)
	4. Type: 'Mastermind' to run program from anywhere

###### To only run program:
	1. Navigate to `mastermind` main folder in terminal. Once in the folder, if you type ls command in terminal, you should see .gemspec file
	2. Type: `cd /bin/` to navigate to the bin
	3. Type: `ruby Mastermind` (Alternatively, if you don't type command above, use: `ruby /bin/Zephyr`)

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

	You can press `q` during any input to quit and close the game.

