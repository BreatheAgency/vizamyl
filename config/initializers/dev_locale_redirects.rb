# Redirect locale paths to live readvizamyl.com (dev only)
# Excludes French (/fr) and UK English (/en-gb)
if ENV['REDIRECT_LOCALES_TO_LIVE'] == 'true'
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
