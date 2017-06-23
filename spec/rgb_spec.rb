require 'color_compare/color/rgb'

RSpec.describe RGB do
	let(:white) { { :string => 'rgb(255, 255, 255)', :array => [255, 255, 255] } }
	let(:black) { { :string => 'rgb(0, 0, 0)',       :array => [0, 0, 0]       } }
	let(:red)   { { :string => 'rgb(255, 0, 0)',     :array => [255, 0, 0]     } }

	context 'when right color format' do
	  it 'initializes color given a string' do
	  	color = RGB.new(white[:string])

	  	expect(color.r).to eq 255
	  	expect(color.g).to eq 255
	  	expect(color.b).to eq 255

	  	expect(color.color).to eq white[:string]
	  	expect(color.code).to eq :rgb
	  end

	  it 'initializes color given an array' do
	  	color = RGB.new(black[:array])

	  	expect(color.r).to eq 0
	  	expect(color.g).to eq 0
	  	expect(color.b).to eq 0

	  	expect(color.color).to eq black[:string]
	  	expect(color.code).to eq :rgb
	  end

	  it 'converts to hex' do
	  	color = RGB.new(white[:string])
	  	expect(color.to_hex).to eq '#ffffff'

	  	color = RGB.new(black[:array])
	  	expect(color.to_hex).to eq '#000000'

	  	color = RGB.new(red[:string])
	  	expect(color.to_hex).to eq '#ff0000'

	  	color = RGB.new('rgb(244, 64, 52)')
	  	expect(color.to_hex).to eq '#f44034'
	  end

	  it 'converts to hsl' do
	  	color = RGB.new(white[:array])
	  	expect(color.to_hsl).to eq 'hsl(0, 0%, 100%)'

	  	color = RGB.new(black[:string])
	  	expect(color.to_hsl).to eq 'hsl(0, 0%, 0%)'

	  	color = RGB.new(red[:array])
	  	expect(color.to_hsl).to eq 'hsl(0, 100%, 50%)'

	  	color = RGB.new('rgb(244, 64, 52)')
	  	expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
	  end

	  it 'converts to xyz' do
	  	color = RGB.new(white[:array])
	  	expect(color.to_xyz).to eq 'xyz(95.05, 100, 108.9)'

	  	color = RGB.new(black[:string])
	  	expect(color.to_xyz).to eq 'xyz(0, 0, 0)'

	  	color = RGB.new(red[:array])
	  	expect(color.to_xyz).to eq 'xyz(41.24, 21.26, 1.93)'

	  	color = RGB.new('rgb(244, 64, 52)')
	  	expect(color.to_xyz).to eq 'xyz(39.76, 23.15, 5.62)'
	  end

	  it 'converts to cielab' do
	  	color = RGB.new(white[:array])
	  	expect(color.to_cielab).to eq 'cielab(100%, 0.0053, -0.0104)'

	  	color = RGB.new(black[:string])
	  	expect(color.to_cielab).to eq 'cielab(0%, 0, 0)'

	  	color = RGB.new(red[:array])
	  	expect(color.to_cielab).to eq 'cielab(53%, 80.1093, 67.2201)'

	  	color = RGB.new('rgb(244, 64, 52)')
	  	expect(color.to_cielab).to eq 'cielab(55%, 66.9327, 48.3388)'
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