source 'https://rubygems.org'
ruby '2.5.8'

gem 'activeadmin', git: 'https://github.com/activeadmin/activeadmin.git', ref: 'd787029e5523be2eb2ed99816eb0cecca2b72862'
gem 'active_admin_editor', git: 'https://github.com/bazuka/active_admin_editor.git', ref: '222ea008c09002a68b556bbde2ffe8ec8c470365'

gem 'rake', '~> 10.3'
gem 'rails', '~> 4.2'
gem 'json', '~> 1.8'
gem 'devise', '3.5.11', git: 'https://github.com/totalhealth/devise.git', branch: 'backport-fix', tag: 'v3.5.11'
gem 'globalize', '= 5.1.0'
gem 'i18n-js', '3.0.0.rc6'
gem 'passenger', '>= 5.0.8'
gem 'sass-rails', '~> 5.0'
gem 'ember-rails', '0.16.4'
gem 'ember-source', '1.9.0'
gem 'ember-data-source', '1.0.0.beta.19.2'
gem 'mime-types', '~> 2.6', require: 'mime/types/columnar'

gem 'oj', '~> 2.16'
gem 'pg'
gem 'wicked'
gem 'roboto'
gem 'rollbar'
gem 'uglifier'
gem 'rails-i18n'
gem 'devise-i18n'
gem 'font_assets'
gem 'prawn-rails'
gem 'simple_form'
gem 'browsernizer'
gem 'rack-noindex'
gem 'acts_as_list'
gem 'high_voltage'
gem 'jquery-rails'
gem 'rack-rewrite'
gem 'compass-rails'
gem 'request_store'
gem 'videojs_rails'
gem 'es5-shim-rails'
gem 'email_validator'
gem 'normalize-rails'
gem 'underscore-rails'
gem 'foundation-rails'
gem 'devise-i18n-views'
gem 'autoprefixer-rails'
gem 'rack-canonical-host'
gem 'active_model_serializers'

group :development do
  gem "letter_opener"
  gem 'awesome_print'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'brakeman', require: false
  gem 'bullet'
  gem 'meta_request'
  gem 'pry-byebug'
  gem 'quiet_assets'
end

group :test, :development do
  gem 'foreman'
end

group :sandbox, :staging, :production do
  gem 'rails_12factor'
end
