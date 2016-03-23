# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'os_map_ref/version'

Gem::Specification.new do |spec|
  spec.name          = "os_map_ref"
  spec.version       = OsMapRef::VERSION
  spec.authors       = ["Rob Nichols"]
  spec.email         = ["rob@undervale.co.uk"]

  spec.summary       = %q{A tool to help handle UK Ordnance Survey map references, in particular to convert them to other coordinate systems}
  spec.description   = %q{This gem allows you to gather U.K. Ordnance Survey Eastings, North, and Map References from a range of text inputs; and output them in a consistent manner}
  spec.homepage      = "https://github.com/reggieb/os_map_ref"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.license       = "LICENSE"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
