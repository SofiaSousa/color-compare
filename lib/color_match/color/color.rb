class Color
	def self.new(color, code = nil)
		if color.kind_of?(Array) && !code
			raise ExceptionHandler::ColorCodeError, ErrorMessage.missing_color_code
		end
		
		if code 
			case code
			when :rgb
				RGB.new(color)
			when :hex
				HEX.new(color)
			when :hsl
				HSL.new(color)
			when :xyz
				XYZ.new(color)
			when :cielab
				CIELAB.new(color)
			else
				raise ExceptionHandler::ColorCodeError, ErrorMessage.wrong_color_code
			end
		else
			# try discover which format color has
			begin
				RGB.new(color)
			rescue
				begin
					HEX.new(color)
				rescue
					begin
						HSL.new(color)
					rescue
						begin
							XYZ.new(color)
						rescue
							CIELAB.new(color)
						end
					end
				end
			end
		end
	end
end