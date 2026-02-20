source 'https://rubygems.org'
ruby '3.1.0'

gem 'activeadmin'
gem 'active_admin_editor', github: 'ejholmes/active_admin_editor'
gem 'sassc-rails'
gem 'rake', '~> 13.2'
gem 'rails', '~> 7.0'
gem 'json', '~> 2.5'
gem 'devise', git: 'https://github.com/heartcombo/devise', branch: 'main'
gem 'globalize', '~> 6.0'
gem 'i18n-js', '~> 3.0', '>= 3.0.2'
gem 'passenger', '>= 5.0.8'
gem 'ember-rails', '~> 0.16'
gem 'ember-source', '1.9.0', path: './patched-gems/ember-source-1.9.0'
gem 'ember-data-source', '1.0.0.beta.19.2'
gem 'mime-types', require: 'mime/types/full'

gem 'bootstrap', '~> 5.3.2'

# gem 'mini_racer'
gem 'ffi', '1.16.3'
gem "simple_form", "~> 4.0"
gem "font-awesome-sass", "~> 6.4.2"

gem 'oj', '~> 2.16'
gem 'pg'
gem 'wicked'
gem 'roboto'
gem 'rollbar'
gem 'uglifier'
gem 'rails-i18n'
gem 'devise-i18n'
gem 'prawn-rails'
gem 'browsernizer'
gem 'rack-noindex'
gem 'acts_as_list'
gem 'high_voltage'
gem 'jquery-rails'
gem 'rack-rewrite'
gem 'request_store'
gem 'email_validator'
gem 'underscore-rails'
gem 'devise-i18n-views'
gem 'rack-canonical-host'
gem 'active_model_serializers'
gem 'puma'
gem "sprockets", "<4"
gem 'videojs_rails'
gem 'es5-shim-rails'
gem 'normalize-rails', '~> 3.0.3'
gem 'foundation-rails', '~> 5.5'
gem 'autoprefixer-rails'


group :development do
  gem "letter_opener"
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bullet'
  # gem 'meta_request' # Not supported with active admin and used only for development purposes.
  gem 'pry-byebug'
  # gem 'quiet_assets'
end

group :test, :development do
  gem 'foreman'
end

group :sandbox, :staging, :production do
  gem 'rails_12factor'
end

