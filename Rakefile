begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

load 'lib/tasks/io_store_tasks.rake'

$:.unshift File.join(File.dirname(__FILE__), 'spec','support')
load 'spec/lib/tasks/io_store_spec_tasks.rake'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

Bundler::GemHelper.install_tasks

task :test_app => "io_store:dummy_app"
