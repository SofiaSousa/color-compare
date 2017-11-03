module ColorSpecHelper
  COLORS  = {
    white: {
      rgb:    { string: 'rgb(255, 255, 255)',                   array: [255, 255, 255] },
      hex:    { string: '#FFFFFF',                              array: ['FF', 'FF', 'FF'] },
      hsl:    { string: 'hsl(0, 0%, 100%)',                     array: [0, 0, 1] },
      xyz:    { string: 'xyz(95.05, 100, 108.9)',               array: [95.05, 100, 108.9] },
      cielab: { string: 'cielab(100%, 0.0053, -0.0104)',        array: [1, 0.0053, -0.0104] }
    },
    black: {
      rgb:    { string: 'rgb(0, 0, 0)',                         array: [0, 0, 0] },
      hex:    { string: '#000000',                              array: ['00', '00', '00'] },
      hsl:    { string: 'hsl(0, 0%, 0%)',                       array: [0, 0, 0] },
      xyz:    { string: 'xyz(0, 0, 0)',                         array: [0, 0, 0] },
      cielab: { string: 'cielab(0%, 0, 0)',                     array: [0, 0, 0] },
    },
    grey: {
      rgb:    { string: 'rgb(128, 128, 128)',                   array: [128, 128, 128] },
      hex:    { string: '#808080',                              array: ['80', '80', '80'] },
      hsl:    { string: 'hsl(0, 0%, 50%)',                      array: [0, 0, 0.5] },
      xyz:    { string: 'xyz(20.518, 21.586, 23.507)',          array: [20.518, 21.586, 23.507] },
      cielab: { string: 'cielab(53.585%, 0.0056, -0.006)',      array: [0.53585, 0.0056, -0.006] },
    },    
    red: {
      rgb:    { string: 'rgb(255, 0, 0)',                       array: [255, 0, 0] },
      hex:    { string: '#FF0000',                              array: ['FF', '00', '00'] },
      hsl:    { string: 'hsl(0, 100%, 50%)',                    array: [0, 1, 0.5] },
      xyz:    { string: 'xyz(41.24, 21.26, 1.93)',              array: [41.24, 21.26, 1.93] },
      cielab: { string: 'cielab(53.2329%, 80.1093, 67.2201)',   array: [0.532329, 80.1093, 67.2201] },
    },
    green: {      
      rgb:    { string: 'rgb(0, 255, 0)',                       array: [0, 255, 0] },
      hex:    { string: '#00FF00',                              array: ['00', 'FF', '00'] },
      hsl:    { string: 'hsl(120, 100%, 50%)',                  array: [120, 1, 0.5] },
      xyz:    { string: 'xyz(35.76, 71.52, 11.92)',             array: [35.76, 71.52, 11.92] },
      cielab: { string: 'cielab(87.737%, -86.1846, 83.1812)',   array: [0.87737, -86.1846, 83.1812] },
    },
    blue: {
      rgb:    { string: 'rgb(0, 0, 255)',                       array: [0, 0, 255] },
      hex:    { string: '#0000FF',                              array: ['00', '00', 'FF'] },
      hsl:    { string: 'hsl(240, 100%, 50%)',                  array: [240, 1, 0.5]},
      xyz:    { string: 'xyz(18.05, 7.22, 95.05)',              array: [18.05, 7.22, 95.05]},
      cielab: { string: 'cielab(32.3026%, 79.1967, -107.8637)', array: [0.323026, 79.1967, -107.8637] },
    }
  }

  FORMATS = COLORS.values.first.keys

  TYPES   = COLORS.values.first.values.first.keys

  # Defining color methods
  COLORS.each do |c_key, c_value|
    method_name = "#{c_key}"

    self.send(:define_method, method_name) do
      color(
        color: c_key,
        format: :rgb,
        type: :string
        )
    end

    c_value.each do |f_key, f_value|
      method_name = "#{c_key}_#{f_key}"

      self.send(:define_method, method_name) do
        color(
          color: c_key,
          format: f_key,
          type: :string
          )
      end

      f_value.each do |t_key, t_value|
        method_name = "#{c_key}_#{f_key}_#{t_key}"
        
        self.send(:define_method, method_name) do
          color(
            color: c_key,
            format: f_key,
            type: t_key
            )
        end
      end
    end
  end

  # Defining expects
  FORMATS.each do |from_key, from_value|
    FORMATS.each do |to_key, to_value|
      if from_key != to_key
        method_name = "expect_convert_#{from_key}_to_#{to_key}"

        self.send(:define_method, method_name) do
          COLORS.each do |c_key, c_value|
            # puts "#{method_name} #{c_key}"

            # string
            color = Object.const_get("#{from_key.upcase}").new(c_value[from_key][:string])
            expect(color.send("to_#{to_key}")).to eq(c_value[to_key][:string])

            # array
            color = Object.const_get("#{from_key.upcase}").new(c_value[from_key][:array])
            expect(color.send("to_#{to_key}")).to eq(c_value[to_key][:string])
            
          end
        end
      end # if
    end
  end

  private
  def color(options = {})
    color  = options[:color ] && is_a_color?( options[:color ]) ? options[:color ] : :white
    format = options[:format] && is_a_format?(options[:format]) ? options[:format] : :rgb
    type   = options[:type  ] && is_a_type?(  options[:type  ]) ? options[:type  ] : :string

    COLORS[color][format][type]
  end

  def is_a_color?(color)
    COLORS.keys.include? color
  end

  def is_a_format?(format)
    FORMATS.include? format
  end

  def is_a_type?(type)
    TYPES.include? type
  end
end