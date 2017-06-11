class ColorDifference
	attr_accessor :first_color, :second_color, :color_code, :method


	METHODS = [:euclidean, :deltae]

	# default values
	@color_code = COLOR_CODES[0]
	@method = METHODS[0]

	def self.difference(first_color, second_color, params)
		# init var
		@first_color = first_color
		@second_color = second_color
		@color_code = params[:color_code] if params[:color_code].present?
		@method = params[:method] if params[:method].present?

		if @method == :euclidean
			
		end
	end

	private

	def euclidean_distante(first_color, second_color)
		to_rgb(first_color)
		to_rgb(second_color)

		r = (r2 - r1)**2
		g = (g2 - g1)**2
		b = (b2 - b1)**2

		sqrt(r + g + b)
	end
end