require 'rspec/core'
require 'rspec/core/rake_task'

task :default do
  puts "run 'rake -T' for a List of commands"
end

RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = Dir['spec/**/*_spec.rb']
  t.rspec_opts = "--tty --color --format doc"
end

desc "Integration Tests"
RSpec::Core::RakeTask.new(:"spec:integration") do |t|
  t.pattern = Dir['spec/integration/**/*_spec.rb']
  t.rspec_opts = "--tty --color --format doc"
end

desc "Unit Tests"
RSpec::Core::RakeTask.new(:"spec:unit") do |t|
  t.pattern = Dir['spec/unit/**/*_spec.rb']
  t.rspec_opts = "--tty --color --format doc"
end
