module Optimadmin
  module AdminSessionsHelper
    def current_administrator
      @current_administrator ||= Administrator.find_by(auth_token: cookies[cookie_name]) if cookies[cookie_name]
    end

    def cookie_name
      global_site_settings['Name'] ? "#{global_site_settings['Name'].downcase.tr(' ', '_').first(10)}_auth_token" : 'optimadmin_auth_token'
    end

    def cookie_name_return_to
      "#{cookie_name}_return_to"
    end
  end
end
