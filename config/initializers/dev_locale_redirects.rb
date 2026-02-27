# Redirect locale paths to live readvizamyl.com, but respect staging domain
if ENV['REDIRECT_LOCALES_TO_LIVE'] == 'true'
  Rails.application.config.middleware.insert_before 0, Rack::Rewrite do
    # List of locales to redirect
    %w[jp en en-us de-at de it es].each do |locale|
      r301 %r{^/#{Regexp.escape(locale)}(/.*)?(\?.*)?$}, lambda { |match, rack_env|
        path = match[1] || ''                    # path after locale
        query = rack_env['QUERY_STRING'].present? ? "?#{rack_env['QUERY_STRING']}" : ''

        host = rack_env['HTTP_HOST']

        if host.include?('langselector.com')
          # STAGING: keep staging domain, avoid double locale
          root_domain = host
          prefix = '' # don't add extra locale
        else
          # LIVE: redirect to correct live subdomain
          root_domain = "#{locale}.readvizamyl.com"
          prefix = "/#{locale}" # add locale path for live
        end

        "https://#{root_domain}#{prefix}#{path}#{query}"
      }
    end
  end
end