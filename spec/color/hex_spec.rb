require 'color_match/color/hex'

RSpec.describe HEX do
	context 'when right color format' do
	  it 'initializes color given a string' do
	  	color = HEX.new(white_hex_string)

	  	expect(color.r).to eq 'FF'
	  	expect(color.g).to eq 'FF'
	  	expect(color.b).to eq 'FF'

	  	expect(color.color).to eq white_hex_string
	  	expect(color.code).to eq :hex
	  end

	  it 'initializes color given an array' do
	  	color = HEX.new(black_hex_array)

	  	expect(color.r).to eq '00'
	  	expect(color.g).to eq '00'
	  	expect(color.b).to eq '00'

	  	expect(color.color).to eq black_hex_string
	  	expect(color.code).to eq :hex
	  end

	  it 'converts to rgb' do
	  	expect_convert_hex_to_rgb

	  	color = HEX.new('#f44034')
	  	expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
	  end

	  # it 'converts to hsl' do
	  # 	expect_convert_hex_to_hsl

	  # 	color = HEX.new('#f44034')
	  # 	expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
	  # end

	  # it 'converts to xyz' do
	  # 	expect_convert_hex_to_xyz

	  # 	color = HEX.new('#f44034')
	  # 	expect(color.to_xyz).to eq 'xyz(39.761, 23.148, 5.621)'
	  # end

	  # it 'converts to cielab' do
	  # 	expect_convert_hex_to_cielab

	  # 	color = HEX.new('#f44034')
	  # 	expect(color.to_cielab).to eq 'cielab(55.2245%, 66.9447, 48.3308)'
	  # end
	end

  context 'when wrong color format' do 
	  it 'raises a ColorFormatError' do
	  	expect { HEX.new('#FF') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

	  	expect { HEX.new('#XDDDDD') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

	  	expect { HEX.new('#XX') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
	  end
	end
end