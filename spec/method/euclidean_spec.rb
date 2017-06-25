require 'color_compare/method/euclidean'

RSpec.describe Euclidean do
	let(:white_rgb) { { :string => 'rgb(255, 255, 255)', :array => [255, 255, 255] } }
	let(:black_rgb) { { :string => 'rgb(0, 0, 0)',       :array => [0, 0, 0]       } }
	let(:grey_rgb)  { { :string => 'rgb(128, 128, 128)', :array => [128, 128, 128] } }
	let(:red_rgb)   { { :string => 'rgb(255, 0, 0)',     :array => [255, 0, 0]     } }
	let(:green_rgb) { { :string => 'rgb(0, 255, 0)',     :array => [255, 0, 0]     } }
	let(:blue_rgb)  { { :string => 'rgb(0, 0, 255)',     :array => [255, 0, 0]     } }

	before do
		@color_white = RGB.new(white_rgb[:string])
		@color_black = RGB.new(black_rgb[:string])
		@color_grey  = RGB.new(grey_rgb[:string])
		@color_red   = RGB.new(red_rgb[:string])
		@color_green = RGB.new(green_rgb[:string])
		@color_blue  = RGB.new(blue_rgb[:string])
	end

	context "" do
		it "matches equals colors" do
			distance = Euclidean.calculate(@color_white, @color_white)
			expect(distance).to eq(0)

			distance = Euclidean.calculate(@color_black, @color_black)
			expect(distance).to eq(0)
		end

		it "doesn't match opposite colors" do
			distance = Euclidean.calculate(@color_white, @color_black)
			expect(distance).to eq(1)

			distance = Euclidean.calculate(@color_black, @color_white)
			expect(distance).to eq(1)
		end

		it "matches colors partialy" do
			distance = Euclidean.calculate(@color_white, @color_red)
			expect(distance.round(2)).to eq(0.82)

			distance = Euclidean.calculate(@color_black, @color_red)
			expect(distance.round(2)).to eq(0.58)

			distance = Euclidean.calculate(@color_white, @color_green)
			expect(distance.round(2)).to eq(0.82)

			distance = Euclidean.calculate(@color_black, @color_green)
			expect(distance.round(2)).to eq(0.58)

			distance = Euclidean.calculate(@color_white, @color_blue)
			expect(distance.round(2)).to eq(0.82)

			distance = Euclidean.calculate(@color_black, @color_blue)
			expect(distance.round(2)).to eq(0.58)

			distance = Euclidean.calculate(@color_red, @color_green)
			expect(distance.round(2)).to eq(0.82)

			distance = Euclidean.calculate(@color_red, @color_blue)
			expect(distance.round(2)).to eq(0.82)
		end

		it "matches black scale" do
			distance = Euclidean.calculate(@color_black, @color_white)
			expect(distance).to eq(1)

			distance = Euclidean.calculate(@color_black, @color_grey)
			expect(distance.round(2)).to eq(0.50)

			distance = Euclidean.calculate(@color_black, @color_black)
			expect(distance).to eq(0)
		end
	end
end