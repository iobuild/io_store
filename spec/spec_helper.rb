# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
# require File.expand_path("../../config/environment", __FILE__)
require File.expand_path("../dummy/config/environment",  __FILE__)
require 'rspec/rails'
require "capybara/rspec"
require 'timecop'

ENGINE_RAILS_ROOT = File.join(File.dirname(__FILE__), "../")

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }

require 'io_store/testing_support/factories'
