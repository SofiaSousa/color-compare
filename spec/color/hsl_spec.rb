require 'color_compare/color/hsl'

RSpec.describe HSL do
	let(:white) { { :string => 'hsl(0, 0%, 100%)',  :array => [0, 0, 1]   } }
	let(:black) { { :string => 'hsl(0, 0%, 0%)',    :array => [0, 0, 0]   } }
	let(:red)   { { :string => 'hsl(0, 100%, 50%)', :array => [0, 1, 0.5] } }

	context 'when right color format' do
	  it 'initializes color given a string' do
	  	color = HSL.new(white[:string])

	  	expect(color.h).to eq 0
	  	expect(color.s).to eq 0
	  	expect(color.l).to eq 1.0

	  	expect(color.color).to eq white[:string]
	  	expect(color.code).to eq :hsl
	  end

	  it 'initializes color given an array' do
	  	color = HSL.new(black[:array])

	  	expect(color.h).to eq 0
	  	expect(color.s).to eq 0
	  	expect(color.l).to eq 0

	  	expect(color.color).to eq black[:string]
	  	expect(color.code).to eq :hsl
	  end

	  it 'converts to rgb' do
	  	color = HSL.new(white[:array])
	  	expect(color.to_rgb).to eq 'rgb(255, 255, 255)'

	  	color = HSL.new(black[:string])
	  	expect(color.to_rgb).to eq 'rgb(0, 0, 0)'

	  	color = HSL.new(red[:array])
	  	expect(color.to_rgb).to eq 'rgb(255, 0, 0)'

	  	color = HSL.new('hsl(4, 90%, 58%)')
	  	expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
	  end

	  it 'converts to hex' do
	  	color = HSL.new(white[:array])
	  	expect(color.to_hex).to eq '#ffffff'

	  	color = HSL.new(black[:string])
	  	expect(color.to_hex).to eq '#000000'

	  	color = HSL.new(red[:array])
	  	expect(color.to_hex).to eq '#ff0000'

	  	color = HSL.new('hsl(4, 90%, 58%)')
	  	expect(color.to_hex).to eq '#f44034'
	  end

	  it 'converts to xyz' do
	  	color = HSL.new(white[:array])
	  	expect(color.to_xyz).to eq 'xyz(95.05, 100, 108.9)'

	  	color = HSL.new(black[:string])
	  	expect(color.to_xyz).to eq 'xyz(0, 0, 0)'

	  	color = HSL.new(red[:array])
	  	expect(color.to_xyz).to eq 'xyz(41.24, 21.26, 1.93)'

	  	color = HSL.new('hsl(4, 90%, 58%)')
	  	expect(color.to_xyz).to eq 'xyz(39.761, 23.148, 5.621)'
	  end

	  it 'converts to cielab' do
	  	color = HSL.new(white[:array])
	  	expect(color.to_cielab).to eq 'cielab(100%, 0.0053, -0.0104)'

	  	color = HSL.new(black[:string])
	  	expect(color.to_cielab).to eq 'cielab(0%, 0, 0)'

	  	color = HSL.new(red[:array])
	  	expect(color.to_cielab).to eq 'cielab(53.2329%, 80.1093, 67.2201)'

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