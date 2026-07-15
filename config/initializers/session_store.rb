# Be sure to restart your server when you modify this file.

# config/initializers/session_store.rb

# Tell Rails to use your custom Heroku key if the standard one isn't present
ENV['SECRET_KEY_BASE'] ||= ENV['VIZAMYL_KEY_BASE']

require 'public_suffix'

Rails.application.config.session_store :cookie_store, 
  key: '_vizamyl_session',
  same_site: :lax, # Explicitly lax for cross-app redirects
  secure: true,    # And only transmits over HTTPS on Heroku
  domain: ->(request) {
    host = request.host

    # Gracefully handle plain 'localhost' or raw IP addresses
    return nil if host == 'localhost' || host =~ /\A\d{1,3}(\.\d{1,3}){3}\z/

     # Extract and format the wildcard domain dynamically
    begin
      parsed = PublicSuffix.parse(host)
      ".#{parsed.domain}"
    rescue PublicSuffix::Error
      nil
    end
  }
