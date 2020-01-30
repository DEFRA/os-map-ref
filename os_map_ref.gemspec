# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "os_map_ref/version"

Gem::Specification.new do |s|
  s.name          = "os_map_ref"
  s.version       = OsMapRef::VERSION
  s.authors       = ["Defra"]
  s.email         = ["alan.cruikshanks@environment-agency.gov.uk"]
  s.homepage      = "https://github.com/DEFRA/os-map-ref"
  # rubocop:disable Metrics/LineLength
  s.summary       = "A tool to help handle UK Ordnance Survey map references, in particular to convert them to other coordinate systems"
  s.description   = "This gem allows you to gather U.K. Ordnance Survey Eastings, North, and Map References from a range of text inputs; and output them in a consistent manner"
  # rubocop:enable Metrics/LineLength
  s.license       = "The Open Government Licence (OGL) Version 3"

  s.files = Dir["{bin,lib}/**/*", "LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["spec/**/*"]
  s.bindir        = "exe"
  s.executables   = s.files.grep(%r{^exe/}) { |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.required_ruby_version = ">= 2.4"

  s.add_development_dependency "defra_ruby_style"
  # Allows us to automatically generate the change log from the tags, issues,
  # labels and pull requests on GitHub. Added as a dependency so all dev's have
  # access to it to generate a log, and so they are using the same version.
  # New dev's should first create GitHub personal app token and add it to their
  # ~/.bash_profile (or equivalent)
  # https://github.com/skywinder/github-changelog-generator#github-token
  s.add_development_dependency "github_changelog_generator"
  s.add_development_dependency "pry-byebug"
  s.add_development_dependency "rake"
  s.add_development_dependency "rspec", "~> 3.8"
  s.add_development_dependency "simplecov", "~> 0.17.1"
end
