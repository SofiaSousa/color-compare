require 'color_match/color_base'
require 'color_match/color/rgb'

class HEX < ColorBase
  attr_accessor :r, :g, :b

  ##
  # Source: https://www.w3schools.com/colors/colors_hex.asp
  # A hexadecimal color is specified with: #RRGGBB.
  #
  # RR (red), GG (green) and BB (blue) are hexadecimal integers between 00 and FF specifying the intensity of the color.
  #
  # For example, #0000FF is displayed as blue, because the blue component is set to its highest value (FF) and the others are set to 00.
  # 
  # = Example
  #
  #   HEX.new('#000000')
  def initialize(color)
    self.color = color

    if self.color.kind_of?(Array)
      self.r, self.g, self.b = self.color
    elsif self.color.kind_of?(String)
      self.r, self.g, self.b = to_array
    end
    
    begin
      if is_hex? 
        self.color = to_s
      else
        raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
      end 
    rescue Exception => e
      raise ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format
    end
  end

  ##
  # This method returns HEX format regular expression
  def self.regular_expression
    /\A#([a-fA-Z0-9]{3}|[a-fA-Z0-9]{6})\z/i
  end

  ##
  # This method returns color string in hex format
  #
  # = Example
  #
  #   Example of to_s goes here ...
  def to_s
    "##{self.r.upcase}#{self.g.upcase}#{self.b.upcase}"
  end

  ##
  # This method slices hex color in array and return it
  # ex: #FF00FF => [FF, 00, FF]
  def to_array
    m_color = self.color.delete('#')

    # #FFF => #FFFFFF
    if m_color.size == 3 && m_color == m_color[0] * 3
      m_color = m_color[0] * 6
    end

    m_color.scan(/[0-9A-Fa-f]{2}/)
  end

  ##
  # This method check hex color format
  def correct_format?
    valid = true
    
    if self.color.kind_of?(String)
      valid = !!HEX.regular_expression.match(self.color)
    end

    # puts "r #{self.r} #{self.r.hex}"
    # puts "g #{self.g} #{self.g.hex}"
    # puts "b #{self.b} #{self.b.hex}"

    valid && self.r.hex.between?(0, 255) && self.g.hex.between?(0, 255) && self.b.hex.between?(0, 255)
  end

  ##
  # This method checks if color is in hex format
  # ex: #FF00FF => true
  def is_hex?
    if self.code == :hex || self.correct_format?
      self.code = :hex
      return true
    else
      return false
    end
  end

  ##
  # This method returns the color in rbg format
  def to_rgb
    rgb = [self.r, self.g, self.b].collect { |c| c.hex }

    RGB.new(rgb).to_s
  end

  ##
  # This method returns the color in hsl format
  def to_hsl
    RGB.new(to_rgb).to_hsl
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
end
