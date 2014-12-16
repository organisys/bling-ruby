Gem::Specification.new do |s|
  s.name          = 'bling-ruby'
  s.version       = '0.0.1'
  s.date          = '2014-12-16'
  s.description   = "The smartest integration with Bling system"
  s.summary       = "The official Bling library"
  s.authors       = ["Luciano Sousa"]
  s.email         = ['ls@lucianosousa.net']
  s.homepage      = 'https://github.com/organisys/bling-ruby'
  s.license       = 'MIT'

  s.files         = `git ls-files`.split($/)
  s.require_paths = ["lib"]

  s.add_dependency "httparty",                '~> 0.13.3'
  s.add_development_dependency "rake",        '~> 10.3.2'
  s.add_development_dependency "rspec-rails", '~> 3.1.0'
end
