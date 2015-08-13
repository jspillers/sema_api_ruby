# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sema_api_ruby/version'

Gem::Specification.new do |spec|
  spec.name          = 'sema_api_ruby'
  spec.version       = SemaApiRuby::VERSION
  spec.authors       = ['Jrod']
  spec.email         = ['jarrod@jtms.net']

  spec.summary       = %q{Ruby client for Sema Media Data image OCR API}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/jspillers/sema_api_ruby'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  #if spec.respond_to?(:metadata)
  #  spec.metadata['allowed_push_host'] = 'TODO: Set to "http://mygemserver.com"'
  #else
  #  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.9.1'
  spec.add_dependency 'faraday_middleware', '~> 0.10.0'
  spec.add_dependency 'fastimage', '~> 1.7.0'
  
  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'pry', '~> 0.10.1'
  spec.add_development_dependency 'vcr', '~> 2.9.3'

end
