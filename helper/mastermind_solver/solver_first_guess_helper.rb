# frozen_string_literal:true

# This only works while default guess is ['R', 'R', 'G', 'G']
FIRST_GUESS_REGULAR = { [0, 0] => %w[Y Y Y Y],
                        [0, 1] => %w[G G Y G],
                        [0, 2] => %w[G G R G],
                        [0, 3] => %w[G G R R],
                        [0, 4] => %w[G B R R],
                        [1, 0] => %w[G G G G],
                        [1, 1] => %w[G G G R],
                        [1, 2] => %w[R G R R],
                        [1, 3] => %w[R G B R],
                        [2, 0] => %w[R R R R],
                        [2, 1] => %w[R R B Y],
                        [2, 2] => %w[R R B G],
                        [3, 0] => %w[R R R B] }.freeze

# This only works while default guess is ['R', 'R', 'G', 'G', 'B']
FIRST_GUESS_SUPER = { [0, 0] => %w[Y Y Y Y Y],
                      [0, 1] => %w[G Y Y Y Y],
                      [0, 2] => %w[B B B B R],
                      [0, 3] => %w[G G R Y Y],
                      [0, 4] => %w[G G R R Y],
                      [0, 5] => %w[G G R B R],
                      [1, 0] => %w[B B B B B],
                      [1, 1] => %w[R Y Y Y G],
                      [1, 2] => %w[R G R R R],
                      [1, 3] => %w[R G R R G],
                      [1, 4] => %w[G G R R B],
                      [2, 0] => %w[R R R R R],
                      [2, 1] => %w[R R R R G],
                      [2, 2] => %w[R G R G Y],
                      [2, 3] => %w[R G G B R],
                      [3, 0] => %w[R R R R B],
                      [3, 1] => %w[R R G B Y],
                      [3, 2] => %w[R R G B G],
                      [4, 0] => %w[R R G G R] }.freeze # wrong
