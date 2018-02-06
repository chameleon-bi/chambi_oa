$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "optimadmin/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "optimadmin"
  s.version     = Optimadmin::VERSION
  s.authors     = ["James Doyley", "Paul Lonsdale"]
  s.email       = ["james@optimised.today", "paul@optimised.today"]
  s.homepage    = "http://optimised.today"
  s.summary     = "The admin system used for websites at Optimised."
  # s.description = "TODO: Description of Optimadmin."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency 'rails'
  s.add_dependency 'cancancan'
  s.add_dependency 'kaminari'
  s.add_dependency 'bcrypt'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'sass-rails'
  s.add_dependency 'mini_magick'
  s.add_dependency 'carrierwave'
  s.add_dependency 'closure_tree'
  s.add_dependency 'jquery-ui-rails'
  s.add_dependency 'google-api-client', '0.8.6'
  s.add_dependency 'tinymce-rails'#, '4.4.3'
  s.add_dependency 'fastimage'

  s.add_development_dependency 'pg'
  # Use latest minitest version
  #s.add_development_dependency 'minitest'
  #s.add_development_dependency 'minitest-reporters'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'selenium-webdriver'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'shoulda-callback-matchers'
  s.add_development_dependency 'bullet'
  s.add_development_dependency 'stackprof'
  s.add_development_dependency 'flamegraph'
  #s.add_development_dependency 'rack-mini-profiler'
  # Stubbing and mocking with mocha and shoulda
  s.add_development_dependency 'mocha'
  s.add_development_dependency 'shoulda'
  s.add_development_dependency 'yard'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'launchy'
  s.add_development_dependency 'poltergeist'

  # Add guard to autorun tests
  s.add_development_dependency 'guard'
  s.add_development_dependency 'guard-minitest'
  s.add_development_dependency 'guard-livereload'
  s.add_development_dependency 'rack-livereload'
  s.add_development_dependency 'ruby-prof'
  # Get latest version of thor otherwise errors on rake tasks
  s.add_development_dependency 'thor'
end
