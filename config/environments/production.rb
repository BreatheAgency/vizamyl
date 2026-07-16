# config/environments/production.rb

class NoCompression
  def compress(string)
    # do nothing
    string
  end
end

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # Code is not reloaded between requests.
  config.cache_classes = true

  # Eager load code on boot. This eager loads most of Rails and
  # your application in memory, allowing both threaded web servers
  # and those relying on copy on write to perform better.
  # Rake tasks automatically ignore this option for performance.
  config.eager_load = true

  # Full error reports are disabled and caching is turned on.
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Enable Rails's static asset server (although nginx should already do this on heroku).
  config.serve_static_files = true
  config.static_cache_control = 'public, max-age=31536000'

  # Compress JavaScripts and CSS.
  config.assets.js_compressor = NoCompression.new
  config.assets.css_compressor = :sass

  # Do not fallback to assets pipeline if a precompiled asset is missed.
  config.assets.compile = false

  # Generate digests for assets URLs.
  config.assets.digest = true

  # Version of your assets, change this if you want to expire all your assets.
  config.assets.version = "5.2.#{Time.now.day}"

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # Set to :debug to see everything in the log.
  config.log_level = :info

  # Enable serving of images, stylesheets, and JavaScripts from an asset server.
  config.action_controller.asset_host = "//#{Rails.application.secrets.asset_host}"

  # Ignore bad email addresses and do not raise email delivery errors.
  # Set this to true and configure the email server for immediate delivery to raise delivery errors.
  config.action_mailer.raise_delivery_errors = false

  # ActionMailer SMTP Configuration
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address: ENV['SMTP_ADDRESS'],
    port: ENV['SMTP_PORT'],
    enable_starttls_auto: true,
    user_name: ENV['SMTP_USER_NAME'],
    password: ENV['SMTP_PASSWORD'],
    authentication: ENV['SMTP_AUTHENTICATION'],
    domain: ENV['SMTP_DOMAIN'],
  }

  # Send deprecation notices to registered listeners.
  config.active_support.deprecation = :notify

  # Use default logging formatter so that PID and timestamp are not suppressed.
  config.log_formatter = ::Logger::Formatter.new

  # Do not dump schema after migrations.
  config.active_record.dump_schema_after_migration = false

  # Available Application Locales
  config.i18n.available_locales = [:en, :'en-us', :'en-gb', :'de-at', :de, :fr, :it, :es, :jp]

  # Clean fallback default options (automatically overridden in real-time by ApplicationController)
  config.action_mailer.default_url_options = { 
    host: 'localhost:3000',
    protocol: 'http'
  }