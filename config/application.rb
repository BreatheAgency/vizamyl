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
Bundler.require(*Rails.groups)

module Vizamyl
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Base URL per environment
    config.vizamyl_base_url = ENV.fetch('VIZAMYL_BASE_URL') do
      case Rails.env
      when 'production'
        'https://www.readvizamyl.com'
      else
        'https://www.langselector.com'  # Staging / dev
      end
    end

    # I18n configuration
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '*.{rb,yml}').to_s]
    config.i18n.available_locales = [:en, :'en-us', :'en-gb', :'de-at', :de, :fr, :it, :es, :jp]
    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = false
    config.i18n.fallbacks = [:'en-us', :'en-gb', :en, :'de-at', :de, :pt, :it, :fr, :es, :nl, :jp]

    # Asset precompile
    config.assets.precompile += %w(video-js.swf vjs.eot vjs.svg vjs.ttf vjs.woff course.js libs.js libs.css)
    config.assets.precompile << /\.(?:svg|eot|woff|ttf)$/
    config.assets.initialize_on_precompile = true

    # Exceptions routing
    config.exceptions_app = self.routes

    # Dev-only locale redirect initializer
    config.after_initialize do
      if Rails.env.development? && ENV['REDIRECT_LOCALES_TO_LIVE'] == 'true'
        Rails.application.config.middleware.insert_before 0, Rack::Rewrite do
          %w[jp en en-us de-at de it es].each do |locale|
            r301 %r{^/#{Regexp.escape(locale)}(/.*)?(\?.*)?$}, lambda { |match, rack_env|
              path = match[1] || ''
              query = rack_env['QUERY_STRING'].present? ? "?#{rack_env['QUERY_STRING']}" : ''
              "https://#{locale}.readvizamyl.com/#{locale}#{path}#{query}"
            }
          end
        end
      end
    end
  end
end