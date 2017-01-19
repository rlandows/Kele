Gem::Specification.new do |s|
  s.name          = 'kele'
  s.version       = '0.0.1'
  s.date          = '2016-01-17'
  s.summary       = 'Kele API Client'
  s.description   = 'A client for the Bloc API'
  s.authors       = ['Robert Landowski']
  s.email         = 'rlandows@uci.edu'
  s.files         = `git ls-files`.split($/)
  s.require_paths = ["lib"]
  s.homepage      =
    'http://rubygems.org/gems/kele'
  s.license       = 'MIT'
  s.add_runtime_dependency 'httparty', '~> 0.13'
end
