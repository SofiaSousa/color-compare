require 'color_compare/color_base'

# module ColorCompare
	class HSL < ColorBase
	  attr_accessor :h, :s, :l

	  ##
	  # Source: https://www.w3schools.com/colors/colors_hsl.asp
	  # HSL stands for hue, saturation, and lightness.
    # HSL color values are specified with: hsl(hue, saturation, lightness).
    # 
    # Hue h
    # Hue is a degree on the color wheel from 0 to 360. 0 is red, 120 is green, 240 is blue.
    #
    #	Saturation s
		#	Saturation is a percentage value; 0% means a shade of gray and 100% is the full color.
    #
		#	Lightness l
		#	Lightness is also a percentage; 0% is black, 100% is white.
		# 
		# = Example
		#
		#   HSL.new('hsl(180, 50%, 50%)')
		def initialize(color)
			self.color = color

			if self.color.kind_of?(Array)
				self.h, self.s, self.l = self.color
			elsif self.color.kind_of?(String)
				self.h, self.s, self.l = to_array
			end
			
			begin
				if is_hsl? 
					self.color = to_s
				else
					raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
				end 
			rescue Exception => e
				raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
			end
		end

		##
		# This method returns HSL format regular expression
		def self.regular_expression
			/\Ahsl\(\d{1,3}(\,\s?\d{1,3}%){2}\)\z/i
		end

		##
		# This method returns color string in hsl format
		#
		# = Example
		#
		#   Example of to_s goes here ...
		def to_s
			"hsl(#{self.h}, #{(self.s * 100).round(0)}%, #{(self.l * 100).round(0)}%)"
		end

		##
		# This method slices hsl color in array and return it
		# ex: hsl(0, 100%, 50%) => [0, 100%, 50%]
		def to_array
			m_color = self.color.delete(' ')
			m_color.delete!('hsl(')
			m_color.delete!(')')

			m_color = m_color.split(',')
			m_color[0] = m_color[0].to_i 
			m_color[1] = m_color[1].to_f / 100 
			m_color[2] = m_color[2].to_f / 100
			m_color 
		end

		##
		# This method check hex color format
		def correct_format?
			valid = true

		  if self.color.kind_of?(String)
				valid = !!HSL.regular_expression.match(self.color)
			end

			valid && self.h.between?(0, 360) && self.s.between?(0, 1) && self.l.between?(0, 1)
		end

		##
		# This method checks if color is in hex format
		# ex: hsl(0, 100%, 50%) => true
		def is_hsl?
			if self.code == :hsl || self.correct_format?
				self.code = :hsl
				return true
			else
				return false
			end
		end

		##
		# This method returns the color in rbg format
		# based on: http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
		def to_rgb
			m_h = self.h / 360.to_f

			if self.s == 0
				r = g = b = self.l; # achromatic
			else
				q = self.l < 0.5 ? self.l * (self.s + 1) : self.l + self.s - self.l * self.s
	      p = 2 * self.l - q

	      r = hue_to_rgb(p, q, m_h + 1 / 3.to_f)
	      g = hue_to_rgb(p, q, m_h)
	      b = hue_to_rgb(p, q, m_h - 1 / 3.to_f)
	    end

	    r = (r * 255).round(0)
	    g = (g * 255).round(0)
	    b = (b * 255).round(0)

			RGB.new([r, g, b]).to_s
		end

		##
		# This method returns the color in hex format
		def to_hex
			RGB.new(self.to_rgb).to_hex
		end

		##
		# This method returns the color in xyz format
		def to_xyz
			RGB.new(self.to_rgb).to_xyz
		end

		##
		# This method returns the color in lab format
		def to_cielab
			RGB.new(to_rgb).to_cielab
		end

		private 
		def hue_to_rgb(p, q, t)
	    t = t + 1.to_f if t < 0
	    t = t - 1.to_f if t > 1
	    
	    return p + (q - p) * 6.to_f * t if t < 1/6.to_f
	    return q if t < 1/2.to_f
	    return p + (q - p) * (2/3.to_f - t) * 6.to_f if t < 2/3.to_f
	    return p
		end  
	end

# end