require_relative 'exception_handler'
require_relative 'error_message'
require_relative 'float'

# module ColorCompare
	class ColorBase
		METHODS = [:euclidean, :deltaecie]
		CODES   = [:rgb, :hex, :hsl, :xyz, :cielab]

		attr_accessor :color, :code, :method

 		def initialize(color, code = nil)
			self.method = METHODS[0]
		end
		
		# Compares self Color with a given one
		def compare_with(o_color, params = {})
			self.method = params[:method] if params[:method] && METHODS.include?(params[:method])

			puts "method"
			puts self.method

	    Euclidean.calculate(self, o_color) if self.method == :euclidean
	    DeltaECIE.calculate(self, o_color) if self.method == :deltaecie
		end
	end
# end