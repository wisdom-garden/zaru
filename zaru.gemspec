Gem::Specification.new do |s|
  s.name        = 'zaru'
  s.version     = '0.1.0'
  s.date        = '2014-04-26'
  s.summary     = "Filename sanitization for Ruby"
  s.description = "Zaru takes a given filename (a string) and normalizes, filters and truncates it, so it can be safely used as a filename in modern operating systems. Zaru doesn't remove Unicode characters when not necessary."
  s.authors     = ["Thomas Fuchs"]
  s.email       = 'thomas@slash7.com'
  s.files       = ["lib/zaru.rb"]
  s.homepage    = 'http://github.com/madrobby/zaru'
end