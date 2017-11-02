# require 'color_match/color_base'
# require 'color_match/color/color'

# RSpec.describe ColorBase do
# 	let(:white_rgb) { { :string => 'rgb(255, 255, 255)', :array => [255, 255, 255] } }
# 	let(:black_rgb) { { :string => 'rgb(0, 0, 0)',       :array => [0, 0, 0]       } }
# 	let(:red_rgb)   { { :string => 'rgb(255, 0, 0)',     :array => [255, 0, 0]     } }

# 	let(:white_cielab) { { :string => 'cielab(100%, 0.0053, -0.0104)', :array => [1, 0.0053, -0.0104]} }
	
# 	context "comparing colors" do
# 		it "matches colors with the same format" do
# 			white = Color.new(white_rgb[:string])

# 			distance = white.compare_with(white)

# 			expect(distance).to eq(123)
# 		end

# 		it "matches colors with different formats" do
# 			white_rgb = Color.new(white_rgb[:string])
# 			white_cielab = Color.new(white_cielab[:array])

# 			distance = white_rgb.compare_with(white_cielab)

# 			expect(distance).to eq(123)
# 		end
# 	end
# end