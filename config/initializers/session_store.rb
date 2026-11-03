# config/initializers/session_store.rb
# Be sure to restart your server when you modify this file.

# Fallback: use VIZAMYL_KEY_BASE when SECRET_KEY_BASE isn't set.
#ENV['SECRET_KEY_BASE'] ||= ENV['VIZAMYL_KEY_BASE']

# Session cookie settings.
#
# key:       cookie name. Cookies from before the upgrade use the old name, so they are never read.
# same_site: Lax sends the cookie on same-site requests, which includes the login POST.
# secure:    HTTPS only in production and staging. Development runs over HTTP.
# No domain: the cookie is host-only, so it's sent only to the host that set it.
Rails.application.config.session_store :cookie_store,
  key: '_vizamyl_session',
  same_site: :lax,
  secure: Rails.env.production? || Rails.env.staging?,
  httponly: true