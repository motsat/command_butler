# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'command_butler/version'

Gem::Specification.new do |spec|
  spec.name          = "command_butler"
  spec.version       = CommandButler::VERSION
  spec.authors       = ["motsat"]
  spec.email         = ["konpeiex@gmail.com"]
  spec.summary       = %q{Commands Executer}
  spec.description   = %q{Executer to execute the command written to the file}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "thor"

end
