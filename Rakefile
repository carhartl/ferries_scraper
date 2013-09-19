require 'rubygems'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

RSpec::Core::RakeTask.new(:spec) do |task|
end

Cucumber::Rake::Task.new(:cucumber) do |task|
end

task default: [:spec, :cucumber]
