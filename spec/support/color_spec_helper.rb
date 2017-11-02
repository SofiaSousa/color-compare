module ColorSpecHelper
	def colors
		# RGB colors
		let(:white_rgb) { { :string => 'rgb(255, 255, 255)', :array => [255, 255, 255] } }
		let(:black_rgb) { { :string => 'rgb(0, 0, 0)',       :array => [0, 0, 0]       } }
		let(:grey_rgb)  { { :string => 'rgb(128, 128, 128)', :array => [128, 128, 128] } }
		let(:red_rgb)   { { :string => 'rgb(255, 0, 0)',     :array => [255, 0, 0]     } }
		let(:green_rgb) { { :string => 'rgb(0, 255, 0)',     :array => [255, 0, 0]     } }
		let(:blue_rgb)  { { :string => 'rgb(0, 0, 255)',     :array => [255, 0, 0]     } }


		# LAB colors
		let(:white_lab) { { :string => 'cielab(100%, 0.0053, -0.0104)',        :array => [1, 0.0053, -0.0104]} }
		let(:black_lab) { { :string => 'cielab(0%, 0, 0)',                     :array => [0, 0, 0] } }
		let(:grey_lab)  { { :string => 'cielab(53.585%, 0.0056, -0.006)',      :array => [0, 0, 0] } }
		let(:red_lab)   { { :string => 'cielab(53.2329%, 80.1093, 67.2201)',   :array => [0.53241, 80.1093, 67.2201] } }
		let(:green_lab) { { :string => 'cielab(87.737%, -86.1846, 83.1812)',   :array => [0.87737, -86.1846, 83.1812] } }
		let(:blue_lab)  { { :string => 'cielab(32.3026%, 79.1967, -107.8637)', :array => [0.323026, 79.1967, -107.8637] } }
	end
end