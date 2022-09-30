# frozen_string_literal: true

require_relative 'string_color_helper'

# A module to include that will print arrays in color
module ColorHelper
  def color_print(code_array)
    return_array = code_array.map { |x| decide_color(x) }

    case code_array.length
    when 4
      "#{'['.white} #{return_array[0]}#{','.white} #{return_array[1]}#{','.white} " \
      "#{return_array[2]}#{','.white} #{return_array[3]} #{']'.white}"
    when 5
      "#{'['.white} #{return_array[0]}#{','.white} #{return_array[1]}#{','.white} " \
      "#{return_array[2]}#{','.white} #{return_array[3]}#{','.white} #{return_array[4]}#{']'.white}"
    else
      raise 'Length of parameter is not 4 or 5!'
    end
  end

  def decide_color(letter)
    case letter
    when 'R'
      letter.red
    when 'G'
      letter.green
    when 'B'
      letter.blue
    when 'Y'
      letter.yellow
    when 'C'
      letter.cyan
    when 'P'
      letter.purple
    when 'W'
      letter.white
    when 'K'
      letter.black
    else
      raise 'Invalid color option detected!'
    end
  end
end
