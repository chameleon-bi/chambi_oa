module Optimadmin
  class ModuleActionsController < ApplicationController
    # load_and_authorize_resource

    def reorder
      begin
        klass = params[:model].constantize
      rescue NameError
        logger.info 'NameError'
        klass = nil
      end
      return unless klass
      authorize! :update, klass
      params[:item].each_with_index do |id, index|
        klass.find(id).update_columns(position: index + 1)
      end
      # render nothing: true
      head :ok
    end

    def toggle
      begin
        klass = params[:model].constantize
      rescue NameError
        logger.info 'NameError'
        klass = nil
      end
      return unless klass
      authorize! :update, klass
      klass.find(params[:id]).toggle!(params[:toggle].to_sym)
      @item   = "#{params[:toggle]}-#{params[:id]}"
      @object = klass.find(params[:id])
      @toggle = params[:toggle]
      render 'optimadmin/application/toggle'
    end
  end
end
