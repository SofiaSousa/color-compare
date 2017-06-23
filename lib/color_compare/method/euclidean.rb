require "../color"

module ColorConmpare
	module Euclidean
		def calculate(first_color, second_color)
			first_color  = @first_color.to_rgb
			second_color = @second_color.to_rgb

			r1, g1, b1 = Color.rgb_to_array(first_color)
			r2, g2, b2 = Color.rgb_to_array(second_color)

			r = (r2 - r1)**2
			g = (g2 - g1)**2
			b = (b2 - b1)**2

			distance = Math.sqrt(r + g + b) / Math.sqrt( 255 ** 2 +  255 ** 2 + 255 ** 2)
			percent = ((1 - distance) * 100).round
	end
end