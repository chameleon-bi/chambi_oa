module Optimadmin
  class PasswordResetsController < ApplicationController
    skip_before_action :authorize
    layout 'optimadmin/logged_out'

    def new
    end

    def create
      administrator = Administrator.find_by(email: params[:email])
      administrator.send_password_reset if administrator
      redirect_to login_url, notice: 'Email sent with password reset instructions.'
    end

    def edit
      @administrator = Administrator.find_by!(password_reset_token: params[:id])
    end

    def update
      @administrator = Administrator.find_by!(password_reset_token: params[:id])
      if @administrator.password_reset_sent_at < 2.hours.ago
        redirect_to new_password_reset_path, alert: 'Password reset has expired.'
      elsif @administrator.update(params.require(:administrator).permit(:password, :password_confirmation))
        cookies[cookie_name] = @administrator.auth_token
        redirect_to root_url, notice: 'Password has been reset.'
      else
        render :edit
      end
    end
  end
end
