require 'color_match/color/xyz'

RSpec.describe XYZ do
  context 'when right color format' do
    it 'initializes color given a string' do
      color = XYZ.new(white_xyz_string)

      expect(color.x).to eq 95.05
      expect(color.y).to eq 100
      expect(color.z).to eq 108.9

      expect(color.color).to eq white_xyz_string
      expect(color.code).to eq :xyz
    end

    it 'initializes color given an array' do
      color = XYZ.new(black_xyz_array)

      expect(color.x).to eq 0
      expect(color.y).to eq 0
      expect(color.z).to eq 0

      expect(color.color).to eq black_xyz_string
      expect(color.code).to eq :xyz
    end

    it 'converts to rgb' do
      expect_convert_xyz_to_rgb

      color = XYZ.new('xyz(39.761, 23.148, 5.621)')
      expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
    end

    it 'converts to hex' do
      expect_convert_xyz_to_hex

      color = XYZ.new('xyz(39.761, 23.148, 5.621)')
      expect(color.to_hex).to eq '#F44034'
    end

    it 'converts to hsl' do
      expect_convert_xyz_to_hsl

      color = XYZ.new('xyz(39.761, 23.148, 5.621)')
      expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
    end

    it 'converts to cielab' do
      expect_convert_xyz_to_cielab

      color = XYZ.new('xyz(39.761, 23.148, 5.621)')
      expect(color.to_cielab).to eq 'cielab(55.2245%, 66.9447, 48.3308)'
    end
  end

  context 'when wrong color format' do 
    it 'raises a ColorFormatError' do
      expect { XYZ.new('xyz(255, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { XYZ.new('xyz(0, -2, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { XYZ.new('xyz(0, 255, 300.1234)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
    end
  end
end