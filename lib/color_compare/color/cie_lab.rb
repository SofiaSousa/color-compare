require 'color_compare/color_base'

# module ColorCompare
	class CIELab < ColorBase
	  attr_accessor :l, :a, :b

	  # Reference-X, Y and Z refer to specific illuminants and observers.
	  # Illuminant: D65
		# Observer: 2° (CIE 1931)
		# Daylight, sRGB, Adobe-RGB
	  Reference = {
	  	x: 95.047,
			y: 100.000,
			z: 108.883
		}

	  ##
	  # Lab
	  # Source: http://colormine.org/convert/rgb-to-lab
		# Cie-L*ab is defined by lightness and the color-opponent dimensions a and b, which are based on the compressed Xyz color space coordinates. 
		# Lab is particularly notable for it's use in delta-e calculations
		def initialize(color)
			self.color = color

			if self.color.kind_of?(Array)
				self.l, self.a, self.b = self.color
			elsif self.color.kind_of?(String)
				self.l, self.a, self.b = to_array
			end
			
			begin
				if is_cielab? 
					self.color = to_s
				else
					raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
				end 
			rescue Exception => e
				raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
			end
		end

		##
		# This method returns CIELab format regular expression
		def self.regular_expression
			/\Acielab\(\d{1,3}%(\,\s?\-?\d{1,3}(\.\d{1,4})?){2}\)\z/i
		end

		##
		# This method returns color string in lab format
		#
		# = Example
		#
		#   Example of to_s goes here ...
		def to_s
			"cielab(#{(self.l * 100).round(0)}%, #{self.a}, #{self.b})"
		end

		##
		# This method slices hsl color in array and return it
		# ex: cielab(100%, 0, 0) => [1, 0, 0]
		def to_array
			m_color = self.color.delete(' ')
			m_color.delete!('cielab(')
			m_color.delete!(')')

			m_color = m_color.split(',')
			m_color[0] = m_color[0].to_f / 100
			m_color[1] = m_color[1].to_f.round(4)  
			m_color[2] = m_color[2].to_f.round(4)
			m_color 
		end

		# This method check lab color format
		def correct_format?
			valid = true

			if self.color.kind_of?(String)
				valid = !!CIELab.regular_expression.match(self.color)
			end

			valid && self.l.between?(0, 100) && self.a.between?(-128, 128) && self.b.between?(-128, 128)
		end

		##
		# This method checks if color is in cielab format
		# ex: [0, -10, -10] => true
		def is_cielab?
			if self.code == :cielab || self.correct_format?
				self.code = :cielab
				true
			else
				false
			end
		end

		##
		# This method returns the color in xyz format
		def to_xyz
			lab = []

			lab[1] = (self.l * 100 + 16) / 116
			lab[0] = self.a / 500 + lab[1]
			lab[2] = lab[1] - self.b / 200

			puts "lab"
			puts lab

			lab = lab.collect do |c| 
				c = c ** 3 > 0.008856 ? c ** 3 : ( c - 16 / 116 ) / 7.787
			end

			x = lab[0] * CIELab::Reference[:x]
			y = lab[1] * CIELab::Reference[:y]
			z = lab[2] * CIELab::Reference[:z]

			x = x.has_decimals? ? x.to_i : x.round(2)
		  y = y.has_decimals? ? y.to_i : y.round(2)
		  z = z.has_decimals? ? z.to_i : z.round(2)
			
			XYZ.new([x, y, z]).to_s
		end

		##
		# This method returns the color in rbg format
		def to_rgb
			XYZ.new(to_xyz).to_rgb
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
	end

# end