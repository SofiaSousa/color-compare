# module ColorCompare
	class Euclidean
		attr_accessor :distance
		##
		# Source: https://en.wikipedia.org/wiki/Color_difference#cite_note-1
		# As most definitions of color distance are distances within a color space, the standard means of determining distances is the Euclidean distance. 
		# If one presently has an RGB (Red, Green, Blue) tuple and wishes to find the color difference, computationally one of the easiest is to call R, G, B linear dimensions defining the color space.
		# This will work in cases when a single color is to be compared to a single color and the need is to simply know whether a distance is greater. 
		# If these squared color distances are summed, such a metric effectively becomes the variance of the color distances.		
		def self.calculate(first_color, second_color, params = {})
			# check if colors are in rgb format
			begin
				if !first_color.is_rgb? || !second_color.is_rgb?
					raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
				end 
			rescue Exception => e
				raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
			end

			r1, g1, b1 = first_color.to_array
			r2, g2, b2 = second_color.to_array

			r = (r1 - r2) ** 2
			g = (g1 - g2) ** 2
			b = (b1 - b2) ** 2

			distance = Math.sqrt(r + g + b)

			if params[:percent]
				distance = distance / Math.sqrt(255 ** 2 +  255 ** 2 + 255 ** 2)
			end 

			distance.round(2)
		end
	end
# end