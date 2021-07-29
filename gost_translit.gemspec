Gem::Specification.new do |s|
  s.name = 'gost_translit'
  s.version = '0.0.2'
  s.authors = ['Viacheslav Soldatov']
  s.email = ['syntaxys0dll@gmail.com']

  s.summary = 'GOST 7.79-2000 type b transliteration'
  s.homepage = 'https://github.com/Syntaxys-dll/gost_7_79_2000_b_translit'
  s.license = 'MIT'
  s.files = Dir.glob('{lib,spec}/**/**')
  s.require_paths = ['lib']

  s.add_development_dependency 'rspec', '~> 2.7', '>= 2.7.0'
end
