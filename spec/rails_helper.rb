ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../config/environment", __dir__)
abort("DATABASE_URL environment variable is set") if ENV["DATABASE_URL"]

require "rspec/rails"
require "capybara/rails"
require "selenium/webdriver"

Dir[Rails.root.join("spec/support/**/*.rb")].sort.each { |file| require file }

ActiveRecord::Migration.maintain_test_schema!

Oath.test_mode!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include Oath::Test::Helpers, type: :feature
  config.after :each do
    Oath.test_reset!
  end
end

Capybara.server = :puma, { Silent: true }
Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_driver = :selenium_chrome_headless
