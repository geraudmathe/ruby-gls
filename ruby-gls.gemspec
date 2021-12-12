require_relative 'lib/ruby-gls/version'

Gem::Specification.new do |spec|
  spec.name          = 'ruby-gls'
  spec.version       = RubyGLS::VERSION
  spec.authors       = ['Adem Dinarevic']
  spec.email         = ['ademdinarevic@gmail.com']
  spec.homepage      = 'https://github.com/ademdc/ruby-gls'
  spec.license       = 'MIT'
  spec.summary       = "Ruby client for GLS API"
  spec.description   = "Ruby client for GLS API"
  spec.require_paths = ['lib']
  
  spec.files         =  %w[
    lib/ruby-gls.rb
    lib/ruby-gls/version.rb
    lib/ruby-gls/configuration.rb
  ]

  spec.required_ruby_version = '>= 2.3'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_dependency 'nokogiri', '~> 1.8.5'
end