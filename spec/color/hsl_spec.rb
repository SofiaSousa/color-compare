require 'color_match/color/hsl'

RSpec.describe HSL do
  context 'when right color format' do
    it 'initializes color given a string' do
      color = HSL.new(white_hsl_string)

      expect(color.h).to eq 0
      expect(color.s).to eq 0
      expect(color.l).to eq 1.0

      expect(color.color).to eq white_hsl_string
      expect(color.code).to eq :hsl
    end

    it 'initializes color given an array' do
      color = HSL.new(black_hsl_array)

      expect(color.h).to eq 0
      expect(color.s).to eq 0
      expect(color.l).to eq 0

      expect(color.color).to eq black_hsl_string
      expect(color.code).to eq :hsl
    end

    it 'converts to rgb' do
      expect_convert_hsl_to_rgb

      color = HSL.new('hsl(4, 90%, 58%)')
      expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
    end

    it 'converts to hex' do
      expect_convert_hsl_to_hex

      color = HSL.new('hsl(4, 90%, 58%)')
      expect(color.to_hex).to eq '#F44034'
    end

    it 'converts to xyz' do
      expect_convert_hsl_to_xyz

      color = HSL.new('hsl(4, 90%, 58%)')
      expect(color.to_xyz).to eq 'xyz(39.761, 23.148, 5.621)'
    end

    it 'converts to cielab' do
      expect_convert_hsl_to_cielab

      color = HSL.new('hsl(4, 90%, 58%)')
      expect(color.to_cielab).to eq 'cielab(55.2245%, 66.9447, 48.3308)'
    end
  end

  context 'when wrong color format' do 
    it 'raises a ColorFormatError' do
      expect { HSL.new('hsl(255, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { HSL.new('hsl(0, -2, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { HSL.new('hsl(0, 255, 300)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
    end
  end
end