# require 'minitest/autorun'
# require 'color_compare/color_compare'

# class ColorCompareTest < Minitest::Test

# 	def test_white_white
# 		# puts "test_white_white"

# 		percent = ColorDifference.difference('rgb(255, 255, 255)', 'rgb(255, 255, 255)')
#     assert_equal 100, percent

# 		percent = ColorDifference.difference('#fff', '#ffffff')
#     assert_equal 100, percent

# 		percent = ColorDifference.difference('hsl(0, 0, 1)', 'hsl(0, 0, 1)')
#     assert_equal 100, percent
# 	end	

# 	def test_white_black
# 		# puts "test_white_black"

# 		percent = ColorDifference.difference('rgb(255, 255, 255)', 'rgb(0, 0, 0)')
#     assert_equal 0, percent

# 		percent = ColorDifference.difference('#fff', '#000')
#     assert_equal 0, percent

# 		percent = ColorDifference.difference('hsl(0, 0, 1)', 'hsl(0, 0, 0)')
#     assert_equal 0, percent
# 	end

# 	def test_red_white
# 		# puts "test_red_white"

# 		percent = ColorDifference.difference('rgb(255, 0, 0)', 'rgb(255, 255, 255)')
#     assert_equal 18, percent

# 		percent = ColorDifference.difference('#ff0000', '#FFF')
#     assert_equal 18, percent

# 		percent = ColorDifference.difference('hsl(0, 1, 0.5)', 'hsl(0, 0, 1)')
#     assert_equal 18, percent
# 	end

# 	def test_green_white
# 		# puts "test_green_white"

# 		percent = ColorDifference.difference('rgb(0, 255, 0)', 'rgb(255, 255, 255)')
#     assert_equal 18, percent

# 		percent = ColorDifference.difference('#00ff00', '#FFF')
#     assert_equal 18, percent

# 		percent = ColorDifference.difference('hsl(120, 1, 0.5)', 'hsl(0, 0, 1)')
#     assert_equal 18, percent
# 	end
# end