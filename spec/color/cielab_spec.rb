require 'color_match/color/cielab'

RSpec.describe CIELAB do  
  context 'when right color format' do
    it 'initializes color given a string' do
      color = CIELAB.new(white_cielab_string)

      expect(color.l).to eq 1
      expect(color.a).to eq 0.0053
      expect(color.b).to eq -0.0104

      expect(color.color).to eq white_cielab_string
      expect(color.code).to eq :cielab
    end

    it 'initializes color given an array' do
      color = CIELAB.new(black_cielab_array)

      expect(color.l).to eq 0
      expect(color.a).to eq 0
      expect(color.b).to eq 0

      expect(color.color).to eq black_cielab_string
      expect(color.code).to eq :cielab
    end

    it 'converts to rgb' do
      expect_convert_cielab_to_rgb

      color = CIELAB.new('cielab(55.2245%, 66.9447, 48.3308)')
      expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
    end

    it 'converts to hex' do
      expect_convert_cielab_to_hex

      color = CIELAB.new('cielab(55.2245%, 66.9447, 48.3308)')
      expect(color.to_hex).to eq '#F44034'
    end

    it 'converts to hsl' do
      expect_convert_cielab_to_hsl

      color = CIELAB.new('cielab(55.2245%, 66.9447, 48.3308)')
      expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
    end

    it 'converts to xyz' do
      expect_convert_cielab_to_xyz

      color = CIELAB.new('cielab(55.2245%, 66.9447, 48.3308)')
      expect(color.to_xyz).to eq 'xyz(39.761, 23.148, 5.621)'
    end
  end

  context 'when wrong color format' do 
    it 'raises a ColorFormatError' do
      expect { CIELAB.new('cielab(10%, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { CIELAB.new('cielab(10%, -2, 255)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

      expect { CIELAB.new('cielab(0, 255, 300)') }
        .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
    end
  end
end