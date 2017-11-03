require 'color_match/color/rgb'

RSpec.describe RGB do
  context 'when right color format' do
    it 'initializes color given a string' do
      color = RGB.new(white_rgb_string)

      expect(color.r).to eq 255
      expect(color.g).to eq 255
      expect(color.b).to eq 255

      expect(color.color).to eq white_rgb_string
      expect(color.code).to eq :rgb
    end

    it 'initializes color given an array' do
      color = RGB.new(black_rgb_array)

      expect(color.r).to eq 0
      expect(color.g).to eq 0
      expect(color.b).to eq 0

      expect(color.color).to eq black_rgb_string
      expect(color.code).to eq :rgb
    end

    it 'converts to hex' do
      expect_convert_rgb_to_hex

      color = RGB.new('rgb(244, 64, 52)')
      expect(color.to_hex).to eq '#F44034'
    end

    it 'converts to hsl' do
      expect_convert_rgb_to_hsl

      color = RGB.new('rgb(244, 64, 52)')
      expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
    end

    it 'converts to xyz' do
      expect_convert_rgb_to_xyz

      color = RGB.new('rgb(244, 64, 52)')
      expect(color.to_xyz).to eq 'xyz(39.761, 23.148, 5.621)'
    end

    it 'converts to cie_lab' do
      expect_convert_rgb_to_cielab

      color = RGB.new('rgb(244, 64, 52)')
      expect(color.to_cielab).to eq 'cielab(55.2245%, 66.9447, 48.3308)'
    end
  end

  context 'when wrong color format' do 
    it 'raises a ColorFormatError' do
      expect { RGB.new('rgb(255, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { RGB.new('rgb(0, -2, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { RGB.new('rgb(0, 255, 300)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
    end
  end
end