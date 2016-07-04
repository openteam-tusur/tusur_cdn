# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tusur_cdn/version'

Gem::Specification.new do |spec|
  spec.name          = "tusur_cdn"
  spec.version       = TusurCdn::VERSION
  spec.authors       = ["OpenTeam"]
  spec.email         = ["developers@openteam.ru"]

  spec.summary       = %q{TUSUR CDN client}
  spec.description   = %q{TUSUR CDN client}
  spec.homepage      = "https://tusur.ru"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_dependency "activesupport"
  spec.add_dependency "configliere"
  spec.add_dependency "redis"
  spec.add_dependency "hashie"
  spec.add_dependency "rest_client"
end
