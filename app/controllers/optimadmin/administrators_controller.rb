module Optimadmin
  class AdministratorsController < ApplicationController

    #before_action :set_administrator, only: [:edit, :update, :destroy]
    load_and_authorize_resource

    # load_and_authorize_resource provides @administrators on index and @administrator on other actions
    # for more info visit https://github.com/CanCanCommunity/cancancan/wiki/Fetching-Records
    def index
      @administrators = @administrators.order(params[:order]).page(params[:page]).per(params[:per_page] || 25)
    end

    def new
    end

    # load_and_authorize_resource also instantiates @administrator = Administrator.new(administrator_params)
    def create
      if @administrator.save
        redirect_to administrators_url, notice: 'Successfully created administrator'
      else
        render :new
      end
    end

    def edit
    end

    def edit_own_details
      @administrator = current_administrator
      render :edit
    end

    def update
      if @administrator.update(administrator_params)
        redirect_to administrators_url, notice: 'Successfully updated administrator'
      else
        render :edit
      end
    end

    def destroy
      @administrator.destroy
      redirect_to administrators_url, notice: 'Successfully destroyed administrator'
    end

    private

    def administrator_params
      params.require(:administrator).permit(:username, :email, :password, :password_confirmation, :role)
    end

    def set_administrator
      @administrator = Administrator.accessible_by(current_ability).find(params[:id])
    end
  end
end
