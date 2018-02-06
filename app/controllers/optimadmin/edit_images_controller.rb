require_dependency 'optimadmin/application_controller'

module Optimadmin
  class EditImagesController < ApplicationController
    before_action :set_klass_instance

    def crop
    end

    private

    def set_klass_instance
      @klass_instance = params[:model].constantize.find(params[:id])
      rescue NameError => e
    end
  end
end
