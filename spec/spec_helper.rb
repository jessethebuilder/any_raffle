ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
# require 'rspec/autorun'
require 'capybara/rspec'
Capybara.default_selector = :css

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.
Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

#Capybara.register_driver :rack_test do |app|
#  Capybara::RackTest::Driver.new(app, :respect_data_method => true, :redirect_limit => 20)
#end

RSpec.configure do |config|
  config.include FactoryGirl::Syntax::Methods
  config.include ActionView::Helpers::NumberHelper
  config.include Devise::TestHelpers, :type => :controller
  config.include ControllerSpecsHelper, type: :controller
  config.include RequestsHelper, type: :feature

  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  #config.use_transactional_fixtures = false

  #  config.include DeviseHelpers

  # config.require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with :deletion
  end
  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  config.expect_with :rspec do |c|
    c.syntax = :expect, :should
  end

#  require 'support/request_helper'
#  config.include RequestHelper
end
