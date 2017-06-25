require 'color_compare/color/color'

RSpec.describe Color do
	let(:white_rgb) { { :string => 'rgb(255, 255, 255)', :array => [255, 255, 255] } }
	let(:white_hex) { { :string => '#FFFFFF',            :array => ['FF', 'FF', 'FF'] } }
	let(:white_hsl) { { :string => 'hsl(0, 0%, 100%)',   :array => [0, 0, 1]} }
	let(:white_xyz) { { :string => 'xyz(95.05, 100, 108.9)',   :array => [95.05, 100, 108.9]} }
	let(:white_cielab) { { :string => 'cielab(100%, 0.0053, -0.0104)', :array => [1, 0.0053, -0.0104]} }
	
	context 'when right color format with code' do
		context 'when right code' do
		  it 'initializes rgb color given a string' do
				color = Color.new(white_rgb[:string], :rgb)

		  	expect(color.r).to eq 255
		  	expect(color.g).to eq 255
		  	expect(color.b).to eq 255

		  	expect(color.color).to eq white_rgb[:string]
		  	expect(color.code).to eq :rgb
		  end

		  it 'initializes rgb color given an array' do
				color = Color.new(white_rgb[:array], :rgb)

		  	expect(color.r).to eq 255
		  	expect(color.g).to eq 255
		  	expect(color.b).to eq 255

		  	expect(color.color).to eq white_rgb[:string]
		  	expect(color.code).to eq :rgb
		  end	  

		  it 'initializes hex color given a string' do
				color = Color.new(white_hex[:string], :hex)

		  	expect(color.r).to eq 'FF'
		  	expect(color.g).to eq 'FF'
		  	expect(color.b).to eq 'FF'

		  	expect(color.color).to eq white_hex[:string]
		  	expect(color.code).to eq :hex
		  end

		  it 'initializes hex color given an array' do
				color = Color.new(white_hex[:array], :hex)

		  	expect(color.r).to eq 'FF'
		  	expect(color.g).to eq 'FF'
		  	expect(color.b).to eq 'FF'

		  	expect(color.color).to eq white_hex[:string]
		  	expect(color.code).to eq :hex
		  end 

		  it 'initializes hsl color given a string' do
				color = Color.new(white_hsl[:string], :hsl)

		  	expect(color.h).to eq 0
		  	expect(color.s).to eq 0
		  	expect(color.l).to eq 1

		  	expect(color.color).to eq white_hsl[:string]
		  	expect(color.code).to eq :hsl
		  end

		  it 'initializes hsl color given an array' do
				color = Color.new(white_hsl[:array], :hsl)

		  	expect(color.h).to eq 0
		  	expect(color.s).to eq 0
		  	expect(color.l).to eq 1

		  	expect(color.color).to eq white_hsl[:string]
		  	expect(color.code).to eq :hsl
		  end

		  it 'initializes xyz color given a string' do
				color = Color.new(white_xyz[:string], :xyz)

		  	expect(color.x).to eq 95.05
		  	expect(color.y).to eq 100
		  	expect(color.z).to eq 108.9

		  	expect(color.color).to eq white_xyz[:string]
		  	expect(color.code).to eq :xyz
		  end

		  it 'initializes xyz color given an array' do
				color = Color.new(white_xyz[:array], :xyz)

		  	expect(color.x).to eq 95.05
		  	expect(color.y).to eq 100
		  	expect(color.z).to eq 108.9

		  	expect(color.color).to eq white_xyz[:string]
		  	expect(color.code).to eq :xyz
		  end

		  it 'initializes cielab color given a string' do
				color = Color.new(white_cielab[:string], :cielab)

		  	expect(color.l).to eq 1
		  	expect(color.a).to eq 0.0053
		  	expect(color.b).to eq -0.0104

		  	expect(color.color).to eq white_cielab[:string]
		  	expect(color.code).to eq :cielab
		  end

		  it 'initializes cielab color given an array' do
				color = Color.new(white_cielab[:array], :cielab)

		  	expect(color.l).to eq 1
		  	expect(color.a).to eq 0.0053
		  	expect(color.b).to eq -0.0104

		  	expect(color.color).to eq white_cielab[:string]
		  	expect(color.code).to eq :cielab
		  end
		end

		context 'when wrong color code' do
			it 'raises a ColorFormatError when code is wrong' do
				expect { Color.new(white_rgb[:string], :hex) }
	      	.to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
		  end

		  it "raises a ColorCodeError when code doesn't exist" do
				expect { Color.new(white_rgb[:string], 'other') }
	      	.to raise_error(ExceptionHandler::ColorCodeError, ErrorMessage.wrong_color_code)
		  end
		end
	end

	context 'when right color format without code' do
	  it 'initializes rgb color given a string' do
			color = Color.new(white_rgb[:string])

	  	expect(color.r).to eq 255
	  	expect(color.g).to eq 255
	  	expect(color.b).to eq 255

	  	expect(color.color).to eq white_rgb[:string]
	  	expect(color.code).to eq :rgb
	  end 

	  it 'initializes hex color given a string' do
			color = Color.new(white_hex[:string])

	  	expect(color.r).to eq 'FF'
	  	expect(color.g).to eq 'FF'
	  	expect(color.b).to eq 'FF'

	  	expect(color.color).to eq white_hex[:string]
	  	expect(color.code).to eq :hex
	  end

	  it 'initializes hsl color given a string' do
			color = Color.new(white_hsl[:string])

	  	expect(color.h).to eq 0
	  	expect(color.s).to eq 0
	  	expect(color.l).to eq 1

	  	expect(color.color).to eq white_hsl[:string]
	  	expect(color.code).to eq :hsl
	  end

	  it 'initializes xyz color given a string' do
				color = Color.new(white_xyz[:string])

		  	expect(color.x).to eq 95.05
		  	expect(color.y).to eq 100
		  	expect(color.z).to eq 108.9

		  	expect(color.color).to eq white_xyz[:string]
		  	expect(color.code).to eq :xyz
		  end

	  it "raises a ColorCodeError when try initialize with an array" do
			expect { Color.new(white_rgb[:array]) }
      	.to raise_error(ExceptionHandler::ColorCodeError, ErrorMessage.missing_color_code)
	  end
	end
end