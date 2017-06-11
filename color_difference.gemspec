Gem::Specification.new do |s|
  s.name        = 'color_difference'
  s.version     = '0.1.0'
  s.licenses    = ['MIT']
  s.summary     = "Difference or distance between two colors"
  s.description = "Color Difference calculates the difference or distance between two colors using Euclidean or Delta E methods"
  s.homepage    = 'https://github.com/SofiaSousa/color_difference'
  s.authors     = ["Sofia Sousa"]
  s.email       = 'csofiamsousa@gmail.com'
  
  s.files       = Dir["{bin,lib,packages}/**/**/*"] + %w{LICENSE README.md}
  s.executables = ['color_difference']
end