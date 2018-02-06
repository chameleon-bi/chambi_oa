module Optimadmin
  class AdministratorMailer < ApplicationMailer
    # Subject can be set in your I18n file at config/locales/en.yml
    # with the following lookup:
    #
    #   en.administrator_mailer.password_reset.subject
    #
    def password_reset(administrator)
      @administrator = administrator
      mail to: @administrator.email, subject: "#{site_name} Password Reset"
    end
  end
end
