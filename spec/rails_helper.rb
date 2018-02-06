# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../test/dummy/config/environment.rb', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'capybara/rspec'
# require 'capybara/poltergeist'
require 'shoulda-matchers'
require 'shoulda-callback-matchers'
require 'database_cleaner'

# require files in spec/support
Dir[Rails.root.join("../../spec/support/**/*.rb")].each { |file| require file }
# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migrations before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

# Capybara.javascript_driver = :poltergeist
Capybara.javascript_driver = :selenium

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers
  config.include Optimadmin::Engine.routes.url_helpers

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do |example|
    DatabaseCleaner.strategy = example.metadata[:js] ? :truncation : :transaction
    DatabaseCleaner.start

    CarrierWave.configure do |config|
      config.storage = :file
      config.enable_processing = false
    end
    CarrierWave::Uploader::Base.descendants.each do |klass|
      next if klass.anonymous?
      klass.class_eval do
        def cache_dir
          "#{Rails.root}/spec/support/uploads/tmp"
        end

        def store_dir
          "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
        end
      end
    end
  end

  config.after(:each) do
    DatabaseCleaner.clean
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/support/uploads"])
  end

  config.include FactoryGirl::Syntax::Methods
  config.include ActionView::TestCase::Behavior, type: :presenter
  config.include Capybara::DSL, type: :feature
  config.include MailerMacros
  config.include LoginMacros
  config.include ControllerHelpers, type: :controller
  config.include SiteSettingsMacros, type: :feature
  config.before(:each, type: :feature) { reset_email }
  config.before(:each, type: :feature) do
    create(:administrator)
    create(:site_setting_name)
    create(:site_setting_email)
  end
  config.before(:each, type: :mailer) do
    create(:site_setting_name)
    create(:site_setting_email)
  end
  config.before(:each, js: true) do
    # this is for poltergeist
    # page.driver.browser.url_blacklist = ["https://maps.googleapis.com", "connect.facebook.net"]
  end

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!
end
