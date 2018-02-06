require 'optimadmin/engine'
require 'optimadmin/crops_images_for'
require 'tinymce-rails'
require 'fastimage'

module Optimadmin
end
if defined?(ActionController::Base)
  ActionController::Base.send :include, Optimadmin::CropsImagesFor
end
