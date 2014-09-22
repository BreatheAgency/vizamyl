LocaleSetter.configure do |config|
  config.url_param           = :locale
  config.user_locale_method  = :locale
  config.localized_domains   = {}
  config.current_user_method = :current_user
end
