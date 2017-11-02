require 'color_match/color_base'
require 'color_match/color/cie_lab'
# require 'color_match/color/xyz'

# module ColorCompare
	class RGB < ColorBase
	  attr_accessor :r, :g, :b

	  ##
	  # Source: https://www.w3schools.com/colors/colors_rgb.asp
	  # An RGB color value is specified with: rgb(red, green, blue).
    # 
    # Each parameter (red, green, and blue) defines the intensity of the color as an integer between 0 and 255.
    # 
    # For example, rgb(0, 0, 255) is rendered as blue, because the blue parameter is set to its highest value (255) and the others are set to 0.
    #
		# = Example
		#
		#   RGB.new('rgb(0, 0, 0)')
		def initialize(color)
			self.color = color

			if self.color.kind_of?(Array)
				self.r, self.g, self.b = self.color
			elsif self.color.kind_of?(String)
				self.r, self.g, self.b = to_array
			end
			
			begin
				if is_rgb? 
					self.color = to_s
				else
					raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
				end 
			rescue Exception => e
				raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
			end
		end

		##
		# This method returns RGB format regular expression
		def self.regular_expression
			/\Argb\(\d{1,3}(\,\s?\d{1,3}){2}\)\z/i
		end

		##
		# This method returns color string in rgb format
		#
		# = Example
		#
		#   Example of to_s goes here ...
		def to_s
			r_s = self.r.round(0)
	    g_s = self.g.round(0)
	    b_s = self.b.round(0)

			"rgb(#{r_s}, #{g_s}, #{b_s})"
		end

		##
		# This method slices rgb color in array and return it
		# ex: rgb(0, 255, 255) => [0, 255, 255]
		def to_array
			m_color = self.color.delete(' ')
			m_color.delete!('rgb(')
			m_color.delete!(')')

			m_color = m_color.split(',')
			m_color.collect { |c| c.to_i }
		end

		##
		# This method check rgb color format
		def correct_format?
			valid = true

			if self.color.kind_of?(String)
				valid = !!RGB.regular_expression.match(self.color)
			end

			valid && self.r.between?(0, 255) && self.g.between?(0, 255) && self.b.between?(0, 255)
		end

		##
		# This method checks if color is in rgb format
		# ex: rgb(0, 255, 255) => true
		def is_rgb?
			if self.code == :rgb || self.correct_format?
				self.code = :rgb
				true
			else
				false
			end
		end

		##
		# This method returns the color in rgb format
		def to_rgb
			self.to_s
		end

		##
		# This method returns the color in hex format
		def to_hex
			color_hex = [self.r, self.g, self.b].collect do |c| 
				hex = c.to_s(16)
				hex = "0#{hex}" if c < 16

				hex.downcase
			end

			HEX.new(color_hex).to_s
		end

		##
		# This method returns the color in hsl format
		def to_hsl
			hsl = [self.r, self.g, self.b].collect { |c| c / 255.to_f }

		  max = hsl.max
		  min = hsl.min

		  h = s = l = (max + min) / 2.to_f

		  if (max == min) 
		    h = s = 0.to_f; # achromatic
		  else
		    d = max - min
		    s = l > 0.5 ? d / (2 - max - min) : d / (max + min)

		    case max 
	      when hsl[0]
	      	h = (hsl[1] - hsl[2]) / d + (hsl[1] < hsl[2] ? 6 : 0)
	      when hsl[1]
	        h = (hsl[2] - hsl[0]) / d + 2
	      when hsl[2]
	        h = (hsl[0] - hsl[1]) / d + 4
		    end

		    h = h * 60.to_f
		  end

			HSL.new([h, s, l]).to_s
		end

		##
		# This method returns the color in XYZ format
		# based: http://www.easyrgb.com/en/math.php
		def to_xyz
			# sR, sG and sB (Standard RGB) input range = 0 ÷ 255
			# X, Y and Z output refer to a D65/2° standard illuminant.
			rgb = [self.r, self.g, self.b].collect do |c| 
				c = c / 255.to_f 
				c = c > 0.04045 ? ((c + 0.055) / 1.055) ** 2.4 : c / 12.92
				c = c * 100
			end

			x = rgb[0] * 0.4124 + rgb[1] * 0.3576 + rgb[2] * 0.1805
			y = rgb[0] * 0.2126 + rgb[1] * 0.7152 + rgb[2] * 0.0722
			z = rgb[0] * 0.0193 + rgb[1] * 0.1192 + rgb[2] * 0.9505

      XYZ.new([x, y, z]).to_s
		end

		##
		# This method returns the color in CIE Lab format
		# based: http://www.easyrgb.com/en/math.php
		def to_cielab
			XYZ.new(to_xyz).to_cielab
		end
	end

# end