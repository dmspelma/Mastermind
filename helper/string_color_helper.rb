# frozen_string_literal: true

# monkey-patching string class to add colors.
class String
  def negative
    "\033[7m#{self}\033[0m"
  end

  # 1 is bold, 30 is black, 47 is white bg
  def black
    "\033[1;30;47m#{self}\033[0m"
  end

  def red
    "\033[31m#{self}\033[0m"
  end

  def green
    "\033[32m#{self}\033[0m"
  end

  def yellow
    "\033[33m#{self}\033[0m"
  end

  def blue
    "\033[34m#{self}\033[0m"
  end

  def purple
    "\033[35m#{self}\033[0m"
  end

  def cyan
    "\033[36m#{self}\033[0m"
  end

  def white
    "\033[37m#{self}\033[0m"
  end
end
