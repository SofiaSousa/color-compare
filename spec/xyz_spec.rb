require 'color_compare/color/xyz'

RSpec.describe XYZ do
	let(:white) { { :string => 'xyz(95.05, 100, 108.9)', :array => [95.05, 100, 108.9] } }
	let(:black) { { :string => 'xyz(0, 0, 0)', :array => [0, 0, 0] } }
	let(:red)   { { :string => 'xyz(41.24, 21.26, 1.93)', :array => [41.24, 21.26, 1.93] } }

	context 'when right color format' do
	  it 'initializes color given a string' do
	  	color = XYZ.new(white[:string])

	  	expect(color.x).to eq 95.05
	  	expect(color.y).to eq 100
	  	expect(color.z).to eq 108.9

	  	expect(color.color).to eq white[:string]
	  	expect(color.code).to eq :xyz
	  end

	  it 'initializes color given an array' do
	  	color = XYZ.new(black[:array])

	  	expect(color.x).to eq 0
	  	expect(color.y).to eq 0
	  	expect(color.z).to eq 0

	  	expect(color.color).to eq black[:string]
	  	expect(color.code).to eq :xyz
	  end

	  it 'converts to rgb' do
	  	color = XYZ.new(white[:string])
	  	expect(color.to_rgb).to eq 'rgb(255, 255, 255)'

	  	color = XYZ.new(black[:array])
	  	expect(color.to_rgb).to eq 'rgb(0, 0, 0)'

	  	color = XYZ.new(red[:string])
	  	expect(color.to_rgb).to eq 'rgb(255, 0, 0)'

	  	color = XYZ.new('xyz(39.76, 23.15, 5.62)')
	  	expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
	  end

	  it 'converts to hex' do
	  	color = XYZ.new(white[:string])
	  	expect(color.to_hex).to eq '#ffffff'

	  	color = XYZ.new(black[:array])
	  	expect(color.to_hex).to eq '#000000'

	  	color = XYZ.new(red[:string])
	  	expect(color.to_hex).to eq '#ff0000'

	  	color = XYZ.new('xyz(39.76, 23.15, 5.62)')
	  	expect(color.to_hex).to eq '#f44034'
	  end

	  it 'converts to hsl' do
	  	color = XYZ.new(white[:array])
	  	expect(color.to_hsl).to eq 'hsl(0, 0%, 100%)'

	  	color = XYZ.new(black[:string])
	  	expect(color.to_hsl).to eq 'hsl(0, 0%, 0%)'

	  	color = XYZ.new(red[:array])
	  	expect(color.to_hsl).to eq 'hsl(0, 100%, 50%)'

	  	color = XYZ.new('xyz(39.76, 23.15, 5.62)')
	  	expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
	  end

	  it 'converts to cielab' do
	  	color = XYZ.new(white[:array])
	  	expect(color.to_cielab).to eq 'cielab(100%, 0.0053, -0.0104)'

	  	color = XYZ.new(black[:string])
	  	expect(color.to_cielab).to eq 'cielab(0%, 0, 0)'

	  	color = XYZ.new(red[:array])
	  	expect(color.to_cielab).to eq 'cielab(53%, 80.1093, 67.2201)'

	  	color = XYZ.new('xyz(39.76, 23.15, 5.62)')
	  	expect(color.to_cielab).to eq 'cielab(55%, 66.9327, 48.3388)'
	  end
	end

  context 'when wrong color format' do 
	  it 'raises a ColorFormatError' do
	  	expect { XYZ.new('xyz(255, 255)') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

	  	expect { XYZ.new('xyz(0, -2, 255)') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

	  	expect { XYZ.new('xyz(0, 255, 300.123)') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
	  end
	end
end