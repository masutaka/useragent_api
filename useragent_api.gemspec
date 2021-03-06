# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'useragent_api/version'

Gem::Specification.new do |spec|
  spec.name          = 'useragent_api'
  spec.version       = UseragentApi::VERSION
  spec.authors       = ['Takashi Masuda']
  spec.email         = ['masutaka.net@gmail.com']

  spec.summary       = 'Ruby toolkit for working with the UserAgent API'
  spec.description   = 'Simple wrapper for the UserAgent API https://useragentapi.com/'
  spec.homepage      = 'https://github.com/feedforce/useragent_api'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.x'
  spec.add_development_dependency 'rake', '~> 12.x'
  spec.add_development_dependency 'rspec', '~> 3.x'
  spec.add_development_dependency 'rubocop', '~> 0.52.x'
  spec.add_development_dependency 'webmock'
end
