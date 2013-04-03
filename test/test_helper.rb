if ENV["COVERAGE"]
  require 'simplecov'
  SimpleCov.start('rails') do
    add_filter "/annotate/"
    add_filter "app/models/ckeditor/"
  end
end

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
FactoryGirl.find_definitions

if ENV["TRAVIS"]
  require 'coveralls'
  Coveralls.wear! 'rails'
end


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  #fixtures :all
  include FactoryGirl::Syntax::Methods
  include SessionHelper
  # Add more helper methods to be used by all tests here...
end
