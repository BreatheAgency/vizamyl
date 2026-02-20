require File.expand_path('../boot', __FILE__)

# Pick the frameworks you want:
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'
require 'action_mailer/railtie'
require 'action_view/railtie'
require 'sprockets/railtie'
# require 'rails/test_unit/railtie'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Vizamyl
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run 'rake -D time' for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    config.vizamyl_base_url = case ENV['RACK_ENV']
    when 'staging'
      'https://stg-www.readvizamyl.com'
    when 'production'
      'https://www.readvizamyl.com'
    else
      'http://localhost:3000' # Default for other environments
    end

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.before_configuration do
      I18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
      I18n.locale = :en
      I18n.default_locale = :en
      I18n.reload!
    end

    config.i18n.enforce_available_locales = false

    config.i18n.available_locales = [:en, :'en-us', :'en-gb', :'de-at', :de, :fr, :it, :es, :jp]

    config.i18n.fallbacks = [:'en-us', :'en-gb', :en, :'de-at', :de, :pt, :it, :fr, :es, :nl, :jp]

    config.assets.precompile += %w(video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff)
    config.assets.precompile += %w(course.js libs.js libs.css)
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    config.assets.initialize_on_precompile = true

    config.exceptions_app = self.routes
  end
end
