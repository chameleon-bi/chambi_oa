class GoogleApi
  def initialize
    return if GA_PROFILE.blank?

    # http://stackoverflow.com/questions/18980456/how-to-pull-google-analytics-stats-in-ruby-on-rails
    # https://gist.github.com/joost/5344705
    # add user to analytics https://support.google.com/analytics/answer/1009702?hl=en
    @client = Google::APIClient.new

    begin
      @client.authorization = Signet::OAuth2::Client.new(
        token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
        audience: 'https://accounts.google.com/o/oauth2/token',
        scope: 'https://www.googleapis.com/auth/analytics.readonly',
        issuer: GA_SERVICE_ACCOUNT_EMAIL_ADDRESS,
        signing_key: Google::APIClient::PKCS12.load_key(GA_PATH_TO_KEY_FILE, 'notasecret')
      ).tap(&:fetch_access_token!)
    rescue
      nil
    end
  end

  def access_token
    @client.authorization.access_token if @client
  end
end
