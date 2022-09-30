# frozen_string_literal: true

# Basic game parameters
module GameParams
  LENGTH = { regular: 4, super: 5 }.freeze
  TURNS = { regular: 10, super: 12 }.freeze
  VERSIONS = %i[regular super].freeze
  QUIT_CONTENTS = %w[quit q n no exit].freeze

  # Color Options to choose from for Master Code:
  VALID_OPTIONS = {
    super: ['R',   # red
            'G',   # green
            'B',   # blue
            'Y',   # yellow
            'C',   # cyan
            'P',   # purple
            'W',   # white
            'K'],  # black
    regular: ['R', # red
              'G', # green
              'B', # blue
              'Y', # yellow
              'W', # white
              'K'] # black
  }.freeze
end
