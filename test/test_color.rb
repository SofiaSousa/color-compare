require 'minitest/autorun'
require 'color_difference/color'

class ColorTest < Minitest::Test
  def test_to_s
    # rgb
    color = Color.new('rgb(255, 255, 255)')

    assert_equal 'rgb(255, 255, 255)',
      color.to_s

    # hex 
    color = Color.new('#ffffff')

    assert_equal '#ffffff',
      color.to_s

    color = Color.new('hsl(0, 100%, 50%)')

    assert_equal 'hsl(0, 100%, 50%)',
      color.to_s
  end

  def test_is_rgb
    # white
    color = Color.new('rgb(255, 255, 255)')

    assert_equal true,
      color.is_rgb?

    # black
    color = Color.new('rgb(0, 0, 0)')

    assert_equal true,
      color.is_rgb?

    # red
    color = Color.new('rgb(255, 0, 0)')

    assert_equal true,
      color.is_rgb?

    # green
    color = Color.new('rgb(0, 255, 0)')

    assert_equal true,
      color.is_rgb?

    # blue
    color = Color.new('rgb(0, 0, 255)')

    assert_equal true,
      color.is_rgb?

    # empty
    color = Color.new('rgb()')

    assert_equal true,
      color.is_rgb?

    # wrong format
    color = Color.new('(0, 0, 255)')

    assert_equal false,
      color.is_rgb?

    # wrong value
    color = Color.new('rgb(0, -2, 255)')

    assert_equal false,
      color.is_rgb?

    color = Color.new('rgb(0, 1, 300)')

    assert_equal false,
      color.is_rgb?
  end

  def test_is_hex
    # white
    color = Color.new('#ffffff')

    assert_equal true,
      color.is_hex?

    color = Color.new('#fff')

    assert_equal true,
      color.is_hex?

    color = Color.new('fff')

    assert_equal false,
      color.is_hex?

    # black
    color = Color.new('#000000')

    assert_equal true,
      color.is_hex?

    # red
    color = Color.new('#FF0000')

    assert_equal true,
      color.is_hex?

    # green
    color = Color.new('#00FF00')

    assert_equal true,
      color.is_hex?

    # blue
    color = Color.new('#0000FF')

    assert_equal true,
      color.is_hex?

    color = Color.new('0000FF')

    assert_equal false,
      color.is_hex?

    # empty
    color = Color.new('')

    assert_equal false,
      color.is_hex?

    # wrong format
    color = Color.new('#')

    assert_equal false,
      color.is_hex?

    # wrong value => #000000
    color = Color.new('#xx0000')

    assert_equal false,
      color.is_hex?
  end

  def test_is_hsl
    # white
    color = Color.new('hsl(0, 100%, 100%)')

    assert_equal true,
      color.is_hsl?

    # black
    color = Color.new('hsl(0, 100%, 0%)')

    assert_equal true,
      color.is_hsl?

    # red
    color = Color.new('hsl(0, 100%, 50%)')

    assert_equal true,
      color.is_hsl?

    # green
    color = Color.new('hsl(120, 100%, 50%)')

    assert_equal true,
      color.is_hsl?

    # blue
    color = Color.new('hsl(240, 100%, 50%)')

    assert_equal true,
      color.is_hsl?

    # empty
    color = Color.new('hsl()')

    assert_equal true,
      color.is_hsl?

    # wrong format
    color = Color.new('(240, 100%, 50%)')

    assert_equal false,
      color.is_hsl?

    # wrong value => #000000
    color = Color.new('hsl(370, 100%, 50%)')

    assert_equal false,
      color.is_hsl?
  end

  def test_to_rgb
    # rgb to rgb
    color = Color.new('rgb(255, 255, 255)')

    assert_equal 'rgb(255, 255, 255)',
      color.to_rgb

    # hex to rgb
    color = Color.new('#FFFFFF')

    assert_equal 'rgb(255, 255, 255)',
      color.to_rgb

    color = Color.new('#a71d5d')

    assert_equal 'rgb(167, 29, 93)',
      color.to_rgb

    # hsl to rgb
    color = Color.new('hsl(120, 1, 0.5)')

    assert_equal 'rgb(0, 255, 0)',
      color.to_rgb

    color = Color.new('hsl(0, 0, 0.4)')

    assert_equal 'rgb(102, 102, 102)',
      color.to_rgb

    color = Color.new('hsl(4, 0.90, 0.58)')

    assert_equal 'rgb(244, 64, 52)',
      color.to_rgb
  end

  def test_to_hex
    # hex to hex
    color = Color.new('#FFFFFF')

    assert_equal '#FFFFFF',
      color.to_hex

    # rgb to hex
    color = Color.new('rgb(255, 255, 255)')

    assert_equal '#ffffff',
      color.to_hex

    color = Color.new('rgb(244, 64, 52)')

    assert_equal '#f44034',
      color.to_hex
      
    # hsl to hex
    color = Color.new('hsl(120, 1, 0.5)')

    assert_equal '#00ff00',
      color.to_hex

    color = Color.new('hsl(4, 0.90, 0.58)')

    assert_equal '#f44034',
      color.to_hex
  end

  def test_to_hsl
    # hsl to hsl
    color = Color.new('hsl(0, 0, 0.4)')

    assert_equal :hsl,
      color.code

    assert_equal 'hsl(0, 0, 0.4)',
      color.to_hsl

    # rgb to hsl
    color = Color.new('rgb(0, 255, 0)')

    assert_equal 'hsl(120, 1, 0.5)',
      color.to_hsl

    color = Color.new('rgb(244, 64, 52)')

    assert_equal 'hsl(4, 0.9, 0.58)',
      color.to_hsl

    # hex to hsl
    color = Color.new('#00ff00')

    assert_equal 'hsl(120, 1, 0.5)',
      color.to_hsl

    color = Color.new('#f44034')

    assert_equal 'hsl(4, 0.9, 0.58)',
      color.to_hsl
  end
end