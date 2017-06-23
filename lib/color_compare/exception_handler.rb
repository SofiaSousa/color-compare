module ExceptionHandler
  # Define custom error subclasses - rescue catches `StandardErrors`
  class ColorFormatError < StandardError; end
  class ColorCodeError < StandardError; end
end