# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'rspec/rails'
require 'capybara/rspec'

Dir[Rails.root.join('spec', 'support', '**', '*.rb')].sort.each { |f| require f }

RSpec.configure do |config|
  config.fixture_paths = [ "#{::Rails.root}/spec/fixtures" ]

  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include FactoryBot::Syntax::Methods

  config.include Devise::Test::IntegrationHelpers, type: :request

  config.include AuthenticationHelper, type: :system

  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |options|
      options.add_argument('--window-size=1400,1400')

      options.add_preference('credentials_enable_service', false)
      options.add_preference('profile.password_manager_enabled', false)
      options.add_argument('--disable-features=PasswordLeakDetection')

      options.add_argument('--disable-notifications')
      options.add_argument('--disable-infobars')
      options.add_argument('--disable-gpu')
      options.add_argument('--no-sandbox')
      options.add_argument('--disable-dev-shm-usage')
    end
  end
end
