require 'color_match/color_base'

# module ColorCompare
	class XYZ < ColorBase
	  attr_accessor :x, :y, :z

		def initialize(color)
			self.color = color

			if self.color.kind_of?(Array)
				self.x, self.y, self.z = self.color
			elsif self.color.kind_of?(String)
				self.x, self.y, self.z = to_array
			end
			
			begin
				if is_xyz? 
					self.color = to_s
				else
					raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
				end 
			rescue Exception => e
				raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
			end
		end

		##
		# This method returns XYZ format regular expression
		def self.regular_expression
			/\Axyz\(\d{1,3}(\.\d{1,3})?(\,\s?\d{1,3}(\.\d{1,3})?){2}\)\z/i
		end

		##
		# This method returns color string in xyz format
		#
		# = Example
		#
		#   Example of to_s goes here ...
		def to_s
			x_s = self.x.to_f.has_decimals? ? self.x.to_i : self.x.round(3)
		  y_s = self.y.to_f.has_decimals? ? self.y.to_i : self.y.round(3)
		  z_s = self.z.to_f.has_decimals? ? self.z.to_i : self.z.round(3)

			"xyz(#{x_s}, #{y_s}, #{z_s})"
		end

		##
		# This method slices xyz color in array and return it
		# ex: xyz(1, 0, 0) => [1, 0, 0]
		def to_array
			m_color = self.color.delete(' ')
			m_color.delete!('xyz(')
			m_color.delete!(')')

			m_color = m_color.split(',')
			m_color[0] = m_color[0].to_f
			m_color[1] = m_color[1].to_f  
			m_color[2] = m_color[2].to_f
			m_color 
		end

		# This method check xyz color format
		def correct_format?
			valid = true

			if self.color.kind_of?(String)
				valid = !!XYZ.regular_expression.match(self.color)
			end

			valid
			#valid && self.x.between?(0, 1) && self.y.between?(0, 1) && self.z.between?(0, 1)
		end

		##
		# This method checks if color is in xyz format
		# ex: [0, -10, -10] => true
		def is_xyz?
			if self.code == :xyz || self.correct_format?
				self.code = :xyz
				true
			else
				false
			end
		end

		##
		# This method returns the color in rbg format
		def to_rgb
			xyz = [self.x, self.y, self.z].collect do |c| 
				c = c / 100.to_f 
			end

			rgb = []
			rgb[0] = xyz[0] * 3.2406 + xyz[1] * -1.5372 + xyz[2] * -0.4986
			rgb[1] = xyz[0] * -0.9689 + xyz[1] * 1.8758 + xyz[2] * 0.0415
			rgb[2] = xyz[0] * 0.0557 + xyz[1] * -0.2040 + xyz[2] * 1.0570

			rgb = rgb.collect do |c| 
				c = c > 0.0031308 ? 1.055 * (c ** (1 / 2.4)) - 0.055 : 12.92 * c
				c = (c * 255).round(0)
			end

			RGB.new(rgb).to_s
		end

		##
		# This method returns the color in hex format
		def to_hex
			RGB.new(to_rgb).to_hex
		end

		##
		# This method returns the color in hsl format
		def to_hsl
			RGB.new(to_rgb).to_hsl
		end

		##
		# This method returns the color in CIE Lab format
		# based: http://www.easyrgb.com/en/math.php
		def to_cielab
			xyz = [self.x, self.y, self.z]

			xyz[0] = xyz[0] / CIELab::Reference[:x]
			xyz[1] = xyz[1] / CIELab::Reference[:y]
			xyz[2] = xyz[2] / CIELab::Reference[:z]

			xyz = xyz.collect do |c| 
				c = c > 0.008856 ? c ** (1 / 3.to_f) : ( 7.787 * c ) + ( 16 / 116.to_f )
			end

			l = (116 * xyz[1] - 16) / 100
			a = 500 * (xyz[0] - xyz[1])
			b = 200 * (xyz[1] - xyz[2])

			CIELab.new([l, a, b]).to_s
		end
	end

# end