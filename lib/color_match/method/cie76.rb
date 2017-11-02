# module ColorCompare
	class CIE76
		##
		# Source: http://colormine.org/delta-e-calculator
		# The most popular method is known as CIE 1976, or more commonly just CIE76.
		# This method uses the aforementioned euclidean distance, however the trick is to first convert to the CIE*Lab color space.
		def self.calculate(first_color, second_color)
			# check if colors are in rgb format
			begin
				if !first_color.is_lab? || !second_color.is_lab?
					raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
				end 
			rescue Exception => e
				raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
			end

			l1, a1, b1 = first_color.to_array
			l2, a2, b2 = second_color.to_array

			l = (l1 - l2) ** 2
			a = (a1 - a2) ** 2
			b = (b1 - b2) ** 2

			distance = Math.sqrt(l + a + b)
		  
		  if params[:percent]
				distance = distance / Math.sqrt(1 ** 2 +  256 ** 2 + 256 ** 2)
			end 

			distance.round(2)
		end
	end