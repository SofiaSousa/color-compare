require 'color_match/method/euclidean'

RSpec.describe Euclidean do
	let(:white_rgb) { { :string => 'rgb(255, 255, 255)', :array => [255, 255, 255] } }
	let(:black_rgb) { { :string => 'rgb(0, 0, 0)',       :array => [0, 0, 0]       } }
	let(:grey_rgb)  { { :string => 'rgb(128, 128, 128)', :array => [128, 128, 128] } }
	let(:red_rgb)   { { :string => 'rgb(255, 0, 0)',     :array => [255, 0, 0]     } }
	let(:green_rgb) { { :string => 'rgb(0, 255, 0)',     :array => [255, 0, 0]     } }
	let(:blue_rgb)  { { :string => 'rgb(0, 0, 255)',     :array => [255, 0, 0]     } }

	before do
		@color_white = Color.new(white_rgb[:string])
		@color_black = RGB.new(black_rgb[:string])
		@color_grey  = RGB.new(grey_rgb[:string])
		@color_red   = RGB.new(red_rgb[:string])
		@color_green = RGB.new(green_rgb[:string])
		@color_blue  = RGB.new(blue_rgb[:string])
	end

	context "when format is correct" do
		it "matches equals colors" do
			distance = Euclidean.calculate(@color_white, @color_white)
			expect(distance).to eq(0)

			distance = Euclidean.calculate(@color_black, @color_black, { :percent => true })
			expect(distance).to eq(0)
		end

		it "doesn't match opposite colors (white and black)" do
			distance = Euclidean.calculate(@color_white, @color_black, { :percent => true })
			expect(distance).to eq(1)

			distance = Euclidean.calculate(@color_black, @color_white)
			expect(distance).to eq(441.67)
		end

		it "matches colors partialy" do
			distance = Euclidean.calculate(@color_white, @color_red)
			expect(distance).to eq(360.62)

			distance = Euclidean.calculate(@color_black, @color_red)
			expect(distance).to eq(255.0)

			distance = Euclidean.calculate(@color_white, @color_green, { :percent => true })
			expect(distance).to eq(0.82)

			distance = Euclidean.calculate(@color_black, @color_green, { :percent => true })
			expect(distance).to eq(0.58)

			distance = Euclidean.calculate(@color_white, @color_blue)
			expect(distance).to eq(360.62)

			distance = Euclidean.calculate(@color_black, @color_blue, { :percent => true })
			expect(distance).to eq(0.58)

			distance = Euclidean.calculate(@color_red, @color_green, { :percent => true })
			expect(distance).to eq(0.82)

			distance = Euclidean.calculate(@color_red, @color_blue)
			expect(distance).to eq(360.62)
		end

		it "matches black's scale" do
			distance = Euclidean.calculate(@color_black, @color_white, { :percent => true })
			expect(distance).to eq(1)

			distance = Euclidean.calculate(@color_black, @color_grey, { :percent => true })
			expect(distance).to eq(0.50)

			distance = Euclidean.calculate(@color_black, @color_black, { :percent => true })
			expect(distance).to eq(0)
		end
	end

	context "when format is wrong" do
		it 'raises a ColorFormatError' do
			expect { Euclidean.calculate(@color_white, HEX.new(@color_white.to_hex)) }
	      	.to raise_error(ExceptionHandler::ColorFormatError, ErrorMessage.wrong_color_format)
		end
	end
end