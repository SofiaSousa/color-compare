require_relative 'float' # '../lib/ss_generator/helpers'

# module ColorDifference
class Color
	codeS = [:rgb, :hex, :hsl]

	attr_accessor :code
	attr_reader :color

	def initialize(color, code = nil)
		@color = color
		@code  = code

		@code = :rgb if is_rgb?
		@code = :hex if is_hex? 
		@code = :hsl if is_hsl? 

		# unless @code
		# 	raise "Wrong format"
		# end
	end

	def to_s
		@color
	end

	# Returns color in rgb code
	# ex: rgb(0,255,255) => rgb(0,255,255)
	# ex: #00FFFF => rgb(0,255,255)
	# ex: hsl(0, 0, 0.4) => rgb(102, 102, 102)
	def to_rgb
		m_color = @color

		unless @code == :rgb
			m_color.delete!(' ')

			case @code  
			when :hex
				m_color = hex_to_rgb(m_color)
			when :hsl 
				m_color = hsl_to_rgb(m_color)
			end
		end

		return m_color
	end

	# Returns color in hex code
	# ex: #00FFFF => #00FFFF
	# ex: rgb(0,255,255) => #00ffff
	# ex: hsl(120, 1, 0.5) => #00ff00
	def to_hex
		m_color = @color

		unless @code == :hex
			m_color.delete!(' ')

			case @code  
			when :rgb
				m_color = rgb_to_hex(m_color)
			when :hsl 
			  m_color = hsl_to_hex(m_color)
			end
		end

		return m_color
	end

	# Returns color in hsl code
	# ex: rgb(23, 98, 119) => hsl(193, 0.67, 0.28)
	# ex: hsl(120, 1, 0.5)=> hsl(120, 1, 0.5)
	# ex: #00ff00 = hsl(120, 1, 0.5)
	def to_hsl
		m_color = @color

		unless @code == :hsl
			m_color.delete!(' ')

			case @code  
			when :rgb
				m_color = rgb_to_hsl(m_color)
			when :hex
				m_color = hex_to_hsl(m_color)
			end
		end

		return m_color
	end

	# Checks is color code id rgb
	# ex: rgb(0,255,255) => true
	def is_rgb?
		return true if @code == :rgb

		m_color = @color.delete(' ')
		
		if m_color[0,3].downcase == 'rgb'
			m_color = rgb_to_array(m_color)

			if m_color[0].to_i.between?(0, 255) && m_color[1].to_i.between?(0, 255) && m_color[2].to_i.between?(0, 255)
				return true
			end
		end

		return false
	end

	# Checks is color code id hex
	# ex: #FF00FF => true
	def is_hex?
		return true if @code == :hex

		m_color = @color.delete(' ')

		if m_color[0] == '#'
			m_color = hex_to_array(m_color)

			if m_color.size == 3 && m_color[0].hex.between?(0, 255) && m_color[1].hex.between?(0, 255) && m_color[2].hex.between?(0, 255)
				return true
			end
		end

		return false
	end

	# Checks is color code id hex
	# ex: hsl(0, 100%, 50%) => true
	def is_hsl?
		return true if @code == :hsl

		m_color = @color.delete(' ')

		if m_color && m_color[0,3].downcase == 'hsl'
			m_color = hsl_to_array(m_color)

			if m_color[0].to_i.between?(0, 360) && m_color[1].to_i.between?(0, 100) && m_color[2].to_i.between?(0, 100)
				return true
			end
		end

		return false
	end

	private

	# Slice hex color in array
	# ex: #FF00FF => [FF, 00, FF]
	def hex_to_array(m_color)
		m_color.delete!('#')

		# #FFF => #FFFFFF
		if m_color.size == 3 && m_color == m_color[0] * 3
			m_color = m_color[0] * 6
		end

		m_color = m_color.scan(/[0-9A-Fa-f]{2}/)
	end

	# Slice rgb color in array
	# ex: rgb(0,255,255) => [0, 255, 255]
	def rgb_to_array(m_color)
		m_color.delete!('rgb(')
		m_color.delete!(')')

		m_color = m_color.split(',')
	end

	# Slice hsl color in array
	# ex: hsl(0, 100%, 50%) => [0, 100%, 50%]
	def hsl_to_array(m_color)
		m_color.delete!('hsl(')
		m_color.delete!(')')

		m_color = m_color.split(',')
		m_color[1] = m_color[1].to_f
		m_color[2] = m_color[2].to_f
		m_color
	end

	# Return rgb color string
	def rgb_s(r, g, b)
		"rgb(#{r}, #{g}, #{b})"
	end

	# Convert hex color to rgb color
	def hex_to_rgb(m_color)
		m_color = hex_to_array(m_color)

		# red, green, blue
		r, g, b = m_color.collect { |c| c.hex }

		rgb_s(r, g, b)
	end

	# Convert hsl color to rgb color
	# based on: http://axonflux.com/handy-rgb-to-hsl-and-rgb-to-hsv-color-model-c
	def hsl_to_rgb(m_color)
		m_color = hsl_to_array(m_color)

		# hue, saturation, lightness
		h, s, l = m_color.collect { |c| c.to_f }

		h = h / 360

		if s == 0
			r = g = b = l;  # achromatic
		else
			q = l < 0.5 ? l * (s + 1) : l + s - l * s
      p = 2 * l - q

      r = hue_to_rgb(p, q, h + 1 / 3.to_f)
      g = hue_to_rgb(p, q, h)
      b = hue_to_rgb(p, q, h - 1 / 3.to_f)
    end

    r = (r * 255).round(0)
    g = (g * 255).round(0)
    b = (b * 255).round(0)
		
		rgb_s(r, g, b)
	end

	def hue_to_rgb(p, q, t)
    t = t + 1.to_f if t < 0
    t = t - 1.to_f if t > 1
    
    return p + (q - p) * 6.to_f * t if t < 1/6.to_f
    return q if t < 1/2.to_f
    return p + (q - p) * (2/3.to_f - t) * 6.to_f if t < 2/3.to_f
    return p
	end  

	# Return hex color string
	def hex_s(r, g, b)
		"##{r}#{g}#{b}"
	end

	# Convert rgb color to hex color
	def rgb_to_hex(m_color)
		m_color = rgb_to_array(m_color)

		# red, green, blue
		r, g, b = m_color.collect do |c| 
			c = c.to_i

			hex = c.to_s(16)
			hex = "0#{hex}" if c < 16

			hex.downcase
		end

		hex_s(r, g, b)
	end

	# Convert hsl color to hex color
	def hsl_to_hex(m_color)
		m_color = hsl_to_rgb(m_color)
		rgb_to_hex(m_color)
	end

	# Return hsl color string
	def hsl_s(h, s, l)
		"hsl(#{h}, #{s}, #{l})"
	end

	# Convert rgb color to hsl color
	def rgb_to_hsl(m_color)
		m_color = rgb_to_array(m_color)

    # red, green, blue
		r, g, b = m_color.collect { |c| c.to_i / 255.to_f }

	  max = [r, g, b].max
	  min = [r, g, b].min

	  h = s = l = (max + min) / 2.to_f

	  if (max == min) 
	    h = s = 0; # achromatic
	  else
	    d = max - min
	    s = l > 0.5 ? d / (2 - max - min) : d / (max + min)

	    case max 
      when r 
      	h = (g - b) / d + (g < b ? 6 : 0)
      when g
        h = (b - r) / d + 2
      when b
        h = (r - g) / d + 4
	    end

	    h = (h * 60.to_f).round(0)
	  end

	  s = s == 0 || s == 1 ? s.to_i : s.round(2)
	  l = l == 0 || l == 1 ? l.to_i : l.round(2)

		hsl_s(h, s, l)
	end

	# Convert hex color to hsl color
	def hex_to_hsl(m_color)
		m_color = hex_to_rgb(m_color)
		rgb_to_hsl(m_color)
	end
end