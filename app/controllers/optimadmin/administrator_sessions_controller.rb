module Optimadmin
  class AdministratorSessionsController < Optimadmin::ApplicationController

    skip_before_action :authorize, only: [:new, :create]
    layout 'optimadmin/logged_out', only: [:new, :create]

    def new
    end

    def create
      administrator = Administrator.authenticate_by_email_or_username(login_name: params[:login_name], password: params[:password])
      if administrator
        if params[:remember_me]
          cookies.permanent[cookie_name] = administrator.auth_token
        else
          cookies[cookie_name] = administrator.auth_token
        end

        if session[cookie_name_return_to].blank?
          redirect_to root_url, notice: 'Logged in!'
        else
          blacklist = [login_path, logout_path]
          return_to = session[cookie_name_return_to]
          return_to = root_url if blacklist.include?(return_to)

          session[cookie_name_return_to] = nil
          redirect_to return_to, notice: 'Logged in!'
        end
      else
        flash.now.alert = 'Invalid email/username or password'
        render :new
      end
    end

    def destroy
      cookies.delete(cookie_name)
      redirect_to login_url, notice: 'Logged out!'
    end
  end
end
