module Optimadmin
  class ApplicationController < ActionController::Base
    # include Optimadmin::AdminSessionsHelper
    include Optimadmin::AdminSessionsHelper
    include Optimadmin::ApplicationHelper

    before_action :global_site_settings, :authorize

    def index
      auth_token = GoogleApi.new
      @auth_token = auth_token.access_token
    end

    def link_list
      render template: 'optimadmin/application/link_list.js.erb', layout: nil
    end

    private

    def authorize
      session[cookie_name_return_to] = request.fullpath
      redirect_to login_url, alert: 'Not authorised' if current_administrator.nil?
    end

    def global_site_settings
      @global_site_settings ||= SiteSetting.current_environment
    end
    helper_method :global_site_settings

    # needs to be defined to use cancancan in engine
    def current_ability
      @current_ability ||= AdminAbility.new(current_administrator)
    end

    def redirect_to_index_or_continue_editing(model, route_options = {})
      route_hash = if continue_editing?
                     { action: :edit, id: model.id }
                   else
                     { action: :index }
                   end
      route_hash = route_hash.merge(route_options) if route_options.present?
      redirect_to(route_hash, notice: notice(model))
    end

    def continue_editing?
      params[:commit] == 'Save and continue editing'
    end

    def notice(model)
      "#{model.class.model_name.human} was successfully #{params[:action] == 'create' ? 'created' : 'updated'}."
    end

    rescue_from CanCan::AccessDenied do |exception|
      logger.info exception
      flash[:error] = 'Access denied!'
      redirect_to root_url
    end
  end
end
