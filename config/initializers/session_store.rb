# Be sure to restart your server when you modify this file.

# config/initializers/session_store.rb
require 'public_suffix'

Rails.application.config.session_store :cookie_store, 
  key: '_vizamyl_session',
  domain: ->(request) {
    host = request.host

    # 1. Gracefully handle plain 'localhost' or raw IP addresses
    return nil if host == 'localhost' || host =~ /\A\d{1,3}(\.\d{1,3}){3}\z/

    # 2. Extract and format the wildcard domain dynamically
    begin
      parsed = PublicSuffix.parse(host)
      ".#{parsed.domain}" # Results in e.g., '.local.com' or '.live.com'
    rescue PublicSuffix::Error
      nil # Fallback to single-host if parsing fails
    end
  }
