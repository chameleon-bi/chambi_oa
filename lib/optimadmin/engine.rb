require 'cancancan'
require 'kaminari'
require 'jquery-rails'
require 'carrierwave'
require 'mini_magick'
require 'closure_tree'
require 'optimadmin/presenter_methods'

module Optimadmin
  class Engine < ::Rails::Engine
    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end

    isolate_namespace Optimadmin
    initializer 'optimadmin.assets.precompile' do |app|
      app.config.assets.precompile += %w( optimadmin/modernizr.js )
    end
  end
end
