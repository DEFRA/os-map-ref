require "bundler/gem_tasks"
require "rake/testtask"

begin
  require "rspec/core/rake_task"
  RSpec::Core::RakeTask.new(:spec)
rescue LoadError => err
  puts "Load error: #{err}"
end

task test: :spec

task default: :test
