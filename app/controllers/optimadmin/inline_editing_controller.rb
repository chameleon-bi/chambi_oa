module Optimadmin
  class InlineEditingController < ApplicationController
    include Optimadmin::ApplicationHelper

    #layout 'optimadmin/inline_editing'

    def navigation
      @object = params[:model].constantize.find(params[:id]) if params[:model] && params[:id]
      #@object = nil if cannot? :manage, @object.class.name
    end
  end
end
