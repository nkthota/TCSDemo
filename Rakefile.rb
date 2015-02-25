require 'rake'
require 'rspec/core/rake_task'
require 'ci/reporter/rake/rspec'

RSpec::Core::RakeTask.new(:spec => ["ci:setup:rspec"]) do |t|
  t.pattern = Dir.glob('spec/**/*_spec.rb')
end
task :default => :spec