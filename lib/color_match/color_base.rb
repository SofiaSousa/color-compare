require_relative 'exception_handler'
require_relative 'error_message'
require_relative 'float'

# module ColorCompare
	class ColorBase
		METHODS = [:euclidean, :cie76]
		CODES   = [:rgb, :hex, :hsl, :xyz, :cielab]

		attr_accessor :color, :code, :method

 		def initialize(color, code = nil)
			self.method = METHODS[0]
		end
		
		# Compares self Color with a given one
		def compare_with(o_color, params = {})
			self.method = params[:method] if params[:method] && METHODS.include?(params[:method])

			first_color  = self
			second_color = o_color

			if self.method == :euclidean
				first_color  = RGB.new(first_color.to_rgb)
			  second_color = RGB.new(second_color.to_rgb)
	    	
	    	Euclidean.calculate(first_color, second_color)
	    end   
	    # DeltaECIE.calculate(self, o_color) if self.method == :cie76
		end
	end
# end