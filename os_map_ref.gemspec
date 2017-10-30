lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "os_map_ref/version"

Gem::Specification.new do |spec|
  spec.name          = "os_map_ref"
  spec.version       = OsMapRef::VERSION
  spec.authors       = ["Environment Agency"]
  spec.email         = ["alan.cruikshanks@environment-agency.gov.uk"]

  # rubocop:disable Metrics/LineLength
  spec.summary       = "A tool to help handle UK Ordnance Survey map references, in particular to convert them to other coordinate systems"
  spec.description   = "This gem allows you to gather U.K. Ordnance Survey Eastings, North, and Map References from a range of text inputs; and output them in a consistent manner"
  # rubocop:enable Metrics/LineLength
  spec.homepage      = "https://github.com/DEFRA/os_map_ref"
  spec.license       = "Nonstandard"

  spec.files         = `git ls-files -z`
                       .split("\x0")
                       .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 1.9"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "simplecov", "~> 0.13"
end
