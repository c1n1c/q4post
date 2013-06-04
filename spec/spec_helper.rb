ENV["RAILS_ENV"] ||= 'test'

require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'shoulda-matchers'
require 'factory_girl'
require 'database_cleaner'
require 'webmock/rspec'
require 'simplecov'

SimpleCov.start

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join('spec/factories/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_base_class_for_anonymous_controllers = false

  config.order = "random"

  config.include FactoryGirl::Syntax::Methods

  config.before(:each, :non_transactional) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.start
  end

  config.after(:each, :non_transactional) do
    DatabaseCleaner.clean
    DatabaseCleaner.strategy = :transaction
  end
end
