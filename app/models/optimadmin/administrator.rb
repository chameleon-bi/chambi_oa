module Optimadmin
  # This class is the user class for Optiadmin
  class Administrator < ActiveRecord::Base
    has_secure_password

    validates :role, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true, email: true

    before_create :generate_auth_token

    def generate_auth_token
      generate_token(:auth_token)
    end

    def send_password_reset
      generate_token(:password_reset_token)
      self.password_reset_sent_at = Time.zone.now
      save!
      AdministratorMailer.password_reset(self).deliver_now
    end

    def generate_token(column)
      loop do
        self[column] = SecureRandom.urlsafe_base64
        break unless Administrator.exists?(column => self[column])
      end
    end

    # Return either the authenticated administrator or false if either no admin was found
    # or their password was incorrect
    #
    # @param login_name [String]
    # @param password [String]
    # @return [Administrator]
    #
    # @example
    #   Administrator.authenticare_by_email_or_username(login_name: 'username', password: 'password')
    def self.authenticate_by_email_or_username(login_name: '', password: '')
      if EMAIL_REGEX.match(login_name)
        administrator = Administrator.find_by(email: login_name)
      else
        administrator = Administrator.find_by(username: login_name)
      end
      if administrator && administrator.authenticate(password)
        return administrator
      else
        return false
      end
    end
  end
end
