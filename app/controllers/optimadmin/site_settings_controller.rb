module Optimadmin
  class SiteSettingsController < ApplicationController
    # before_action :set_site_setting, only: [:edit, :update, :destroy]
    load_and_authorize_resource

    # load_and_authorize_resource provides @site_settings on index and @site_setting on other actions
    # for more info visit https://github.com/CanCanCommunity/cancancan/wiki/Fetching-Records
    def index
      if Rails.env.development?
        @site_settings = @site_settings.where(environment: params[:environment] || Rails.env.to_s).order(:key).page(params[:page]).per(params[:per_page] || 25)
      else
        @site_settings = @site_settings.where(environment: Rails.env.to_s).order(:key).page(params[:page]).per(params[:per_page] || 25)
      end
    end

    def new
    end

    # load_and_authorize_resource also instantiates @site_setting = SiteSetting.new(site_setting_params)
    def create
      if @site_setting.save
        if params[:button].blank?
          path = site_settings_url
        else
          path = new_site_setting_url
        end

        redirect_to path, notice: 'Successfully created site setting'
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @site_setting.update(site_setting_params)
        redirect_to site_settings_url, notice: 'Successfully updated site setting'
      else
        render :edit
      end
    end

    def destroy
      @site_setting.destroy
      redirect_to site_settings_url, notice: 'Site setting was successfully destroyed.'
    end

    private

    def site_setting_params
      params.require(:site_setting).permit(:key, :value, :environment, :button)
    end

    def set_site_setting
      # @site_setting = SiteSetting.accessible_by(current_ability).find(params[:id])
      @site_setting = SiteSetting.find(params[:id])
    end
  end
end
