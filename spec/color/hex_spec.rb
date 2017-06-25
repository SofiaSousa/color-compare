require 'color_compare/color/hex'

RSpec.describe HEX do
	let(:white) { { :string => '#FFFFFF', :array => ['FF', 'FF', 'FF'] } }
	let(:black) { { :string => '#000',    :array => ['00', '00', '00'] } }
	let(:red)   { { :string => '#FF0000', :array => ['FF', '00', '00'] } }

	context 'when right color format' do
	  it 'initializes color given a string' do
	  	color = HEX.new(white[:string])

	  	expect(color.r).to eq 'FF'
	  	expect(color.g).to eq 'FF'
	  	expect(color.b).to eq 'FF'

	  	expect(color.color).to eq white[:string]
	  	expect(color.code).to eq :hex
	  end

	  it 'initializes color given an array' do
	  	color = HEX.new(black[:array])

	  	expect(color.r).to eq '00'
	  	expect(color.g).to eq '00'
	  	expect(color.b).to eq '00'

	  	expect(color.color).to eq '#000000'
	  	expect(color.code).to eq :hex
	  end

	  it 'converts to rgb' do
	  	color = HEX.new(white[:string])
	  	expect(color.to_rgb).to eq 'rgb(255, 255, 255)'

	  	color = HEX.new(black[:array])
	  	expect(color.to_rgb).to eq 'rgb(0, 0, 0)'

	  	color = HEX.new(red[:string])
	  	expect(color.to_rgb).to eq 'rgb(255, 0, 0)'

	  	color = HEX.new('#f44034')
	  	expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
	  end

	  it 'converts to hsl' do
	  	color = HEX.new(white[:array])
	  	expect(color.to_hsl).to eq 'hsl(0, 0%, 100%)'

	  	color = HEX.new(black[:string])
	  	expect(color.to_hsl).to eq 'hsl(0, 0%, 0%)'

	  	color = HEX.new(red[:array])
	  	expect(color.to_hsl).to eq 'hsl(0, 100%, 50%)'

	  	color = HEX.new('#f44034')
	  	expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
	  end

	  it 'converts to xyz' do
	  	color = HEX.new(white[:array])
	  	expect(color.to_xyz).to eq 'xyz(95.05, 100, 108.9)'

	  	color = HEX.new(black[:string])
	  	expect(color.to_xyz).to eq 'xyz(0, 0, 0)'

	  	color = HEX.new(red[:array])
	  	expect(color.to_xyz).to eq 'xyz(41.24, 21.26, 1.93)'

	  	color = HEX.new('#f44034')
	  	expect(color.to_xyz).to eq 'xyz(39.761, 23.148, 5.621)'
	  end

	  it 'converts to cielab' do
	  	color = HEX.new(white[:array])
	  	expect(color.to_cielab).to eq 'cielab(100%, 0.0053, -0.0104)'

	  	color = HEX.new(black[:string])
	  	expect(color.to_cielab).to eq 'cielab(0%, 0, 0)'

	  	color = HEX.new(red[:array])
	  	expect(color.to_cielab).to eq 'cielab(53.2329%, 80.1093, 67.2201)'

	  	color = HEX.new('#f44034')
	  	expect(color.to_cielab).to eq 'cielab(55.2245%, 66.9447, 48.3308)'
	  end
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