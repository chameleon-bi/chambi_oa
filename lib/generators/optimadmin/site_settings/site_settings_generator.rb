module Optimadmin
  class SiteSettingsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def add_to_application
      inject_into_file(
          'app/controllers/application_controller.rb',
          [ "\n\n  private",
            "\n\n  def global_site_settings",
            "\n    @global_site_settings ||= Optimadmin::SiteSetting.current_environment",
            "\n  end",
            "\n  helper_method :global_site_settings\n"
          ].join,
          after: "def index\n  end"
        )
    end

    def add_before_action
      inject_into_file(
          'app/controllers/application_controller.rb',
          [ "\n  before_action :global_site_settings",
            "\n  include Optimadmin::AdminSessionsHelper",
            "\n  helper_method :current_administrator",
          ].join,
          after: 'protect_from_forgery with: :exception'
        )
    end
  end
end
