# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'erlang/jinterface/version'

Gem::Specification.new do |spec|
  spec.name          = "erlang-jinterface"
  spec.version       = Erlang::Jinterface::VERSION
  spec.authors       = ["Denis Kirichenko"]
  spec.email         = ["d.kirichenko@fun-box.ru"]
  spec.description   = %q{Erlang Jinterface jruby adapter}
  spec.summary       = %q{Erlang Jinterface jruby adapter}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
