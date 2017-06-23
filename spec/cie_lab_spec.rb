require 'color_compare/color/rgb'

RSpec.describe CIELab do	
	let(:white) { { :string => 'cielab(100%, 0.0053, -0.0104)', :array => [1, 0.0053, -0.0104]} }
	let(:black) { { :string => 'cielab(0%, 0, 0)', :array => [0, 0, 0] } }
	let(:red)   { { :string => 'cielab(53%, 80.1093, 67.2201)', :array => [0.53, 80.1093, 67.2201] } }

	context 'when right color format' do
	  it 'initializes color given a string' do
	  	color = CIELab.new(white[:string])

	  	expect(color.l).to eq 1
	  	expect(color.a).to eq 0.0053
	  	expect(color.b).to eq -0.0104

	  	expect(color.color).to eq white[:string]
	  	expect(color.code).to eq :cielab
	  end

	  it 'initializes color given an array' do
	  	color = CIELab.new(black[:array])

	  	expect(color.l).to eq 0
	  	expect(color.a).to eq 0
	  	expect(color.b).to eq 0

	  	expect(color.color).to eq black[:string]
	  	expect(color.code).to eq :cielab
	  end

	  # it 'converts to rgb' do
	  # 	color = CIELab.new(white[:string])
	  # 	expect(color.to_rgb).to eq 'rgb(255, 255, 255)'

	  # 	color = CIELab.new(black[:array])
	  # 	expect(color.to_rgb).to eq 'rgb(0, 0, 0)'

	  # 	color = CIELab.new(red[:string])
	  # 	expect(color.to_rgb).to eq 'rgb(255, 0, 0)'

	  # 	color = CIELab.new('cielab(55%, 66.9469, 48.3299)')
	  # 	expect(color.to_rgb).to eq 'rgb(244, 64, 52)'
	  # end

	  # it 'converts to hex' do
	  # 	color = CIELab.new(white[:string])
	  # 	expect(color.to_hex).to eq '#ffffff'

	  # 	color = CIELab.new(black[:array])
	  # 	expect(color.to_hex).to eq '#000000'

	  # 	color = CIELab.new(red[:string])
	  # 	expect(color.to_hex).to eq '#ff0000'

	  # 	color = CIELab.new('cielab(55%, 66.9469, 48.3299)')
	  # 	expect(color.to_hex).to eq '#f44034'
	  # end

	  # it 'converts to hsl' do
	  # 	color = CIELab.new(white[:array])
	  # 	expect(color.to_hsl).to eq 'hsl(0, 0%, 100%)'

	  # 	color = CIELab.new(black[:string])
	  # 	expect(color.to_hsl).to eq 'hsl(0, 0%, 0%)'

	  # 	color = CIELab.new(red[:array])
	  # 	expect(color.to_hsl).to eq 'hsl(0, 100%, 50%)'

	  # 	color = CIELab.new('cielab(55%, 66.9469, 48.3299)')
	  # 	expect(color.to_hsl).to eq 'hsl(4, 90%, 58%)'
	  # end

	  it 'converts to xyz' do
	  	color = CIELab.new(white[:array])
	  	expect(color.to_xyz).to eq 'xyz(95.05, 100, 108.9)'

	  	color = CIELab.new(black[:string])
	  	expect(color.to_xyz).to eq 'xyz(0, 0, 0)'

	  	color = CIELab.new(red[:array])
	  	expect(color.to_xyz).to eq 'xyz(41.24, 21.26, 1.93)'

	  	color = CIELab.new('cielab(55%, 66.9327, 48.3388)')
	  	expect(color.to_xyz).to eq 'xyz(39.76, 23.15, 5.62)'
	  end
	end

  context 'when wrong color format' do 
	  it 'raises a ColorFormatError' do
	  	expect { CIELab.new('cielab(10%, 255)') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

	  	expect { CIELab.new('cielab(10%, -2, 255)') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)

	  	expect { CIELab.new('cielab(0, 255, 300)') }
	      .to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
	  end
	end
end