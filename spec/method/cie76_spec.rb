require 'color_match/method/cie76'

RSpec.describe CIE76 do	
	let(:white_lab) { { :string => 'cielab(100%, 0.0053, -0.0104)', :array => [1, 0.0053, -0.0104]} }
	let(:grey_lab)  { { :string => 'cielab(53.585%, 0.0056, -0.006)', :array => [0, 0, 0] } }
	let(:black_lab) { { :string => 'cielab(0%, 0, 0)', :array => [0, 0, 0] } }
	let(:red_lab)   { { :string => 'cielab(53.2329%, 80.1093, 67.2201)', :array => [0.53241, 80.1093, 67.2201] } }
	let(:green_lab) { { :string => 'cielab(87.737%, -86.1846, 83.1812)', :array => [0.87737, -86.1846, 83.1812] } }
	let(:blue_lab)  { { :string => 'cielab(32.3026%, 79.1967, -107.8637)', :array => [0.323026, 79.1967, -107.8637] } }


	before do
		@color_white = Color.new(white_lab[:string])
		@color_black = CIELab.new(black_lab[:string])
		@color_grey  = CIELab.new(grey_lab[:string])
		@color_red   = CIELab.new(red_lab[:string])
		@color_green = CIELab.new(green_lab[:string])
		@color_blue  = CIELab.new(blue_lab[:string])
	end

	context '' do
		it 'matches equals colors' do
			distance = CIE76.calculate(@color_white, @color_white)
			expect(distance).to eq(0)

			distance = CIE76.calculate(@color_black, @color_black)
			expect(distance).to eq(0)
		end

		it "doesn't match opposite colors" do
			distance = CIE76.calculate(@color_white, @color_black)
			expect(distance).to eq(1)

			distance = CIE76.calculate(@color_black, @color_white)
			expect(distance).to eq(1)
		end

		# it 'matches colors partialy' do
		# 	distance = CIE76.calculate(@color_white, @color_red)
		# 	expect(distance.round(2)).to eq(0.82)

		# 	distance = CIE76.calculate(@color_black, @color_red)
		# 	expect(distance.round(2)).to eq(0.58)

		# 	distance = CIE76.calculate(@color_white, @color_green)
		# 	expect(distance.round(2)).to eq(0.82)

		# 	distance = CIE76.calculate(@color_black, @color_green)
		# 	expect(distance.round(2)).to eq(0.58)

		# 	distance = CIE76.calculate(@color_white, @color_blue)
		# 	expect(distance.round(2)).to eq(0.82)

		# 	distance = CIE76.calculate(@color_black, @color_blue)
		# 	expect(distance.round(2)).to eq(0.58)

		# 	distance = CIE76.calculate(@color_red, @color_green)
		# 	expect(distance.round(2)).to eq(0.82)

		# 	distance = CIE76.calculate(@color_red, @color_blue)
		# 	expect(distance.round(2)).to eq(0.82)
		# end

		# it "matches black scale" do
		# 	distance = CIE76.calculate(@color_black, @color_white)
		# 	expect(distance).to eq(1)

		# 	distance = CIE76.calculate(@color_black, @color_grey)
		# 	expect(distance.round(2)).to eq(0.50)

		# 	distance = CIE76.calculate(@color_black, @color_black)
		# 	expect(distance).to eq(0)
		# end
	end
end