require_relative 'exception_handler'
require_relative 'error_message'
require_relative 'float' # '../lib/ss_generator/helpers'

# module ColorCompare
	class ColorBase
		METHODS = [:euclidean]
		CODES   = [:rgb, :hex, :hsl, :cielab]

		attr_accessor :color, :code

		def initialize(color, code = nil)
		end

		def to_s 
		end
		
		def to_array 
		end

		# Compares self Color with a given one
		def compare_with(o_color, params = {})
			@method = params[:method] if params[:method] && METHODS.include?(params[:method])
	    Euclidean.calculate(self, o_color) if @method == :euclidean
		end
	end
# end