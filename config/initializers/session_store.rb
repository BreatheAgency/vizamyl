# config/initializers/session_store.rb
# Be sure to restart your server when you modify this file.

# Tell Rails to use your custom Heroku key if the standard one isn't present
ENV['SECRET_KEY_BASE'] ||= ENV['VIZAMYL_KEY_BASE']

require 'public_suffix'

Rails.application.config.session_store :cookie_store, 
  key: '_vizamyl_session',
  same_site: :lax, # Explicitly lax to allow cross-subdomain redirections
  # Only enforce secure HTTPS cookies on live/staging Heroku setups (prevents local HTTP rejection)
  secure: Rails.env.production? || Rails.env.staging?, 
  domain: ->(request) {
    host = request.host

    # Gracefully handle plain 'localhost' or raw IP addresses
    return nil if host == 'localhost' || host =~ /\A\d{1,3}(\.\d{1,3}){3}\z/

    # Extract and format the wildcard domain dynamically
    begin
      parsed = PublicSuffix.parse(host)
      ".#{parsed.domain}" # Results in e.g., '.langselector.com' or '.readvizamyl.com'
    rescue PublicSuffix::Error
      nil
    end
  }