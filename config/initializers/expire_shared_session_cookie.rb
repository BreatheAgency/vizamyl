# Be sure to restart your server when you modify this file.

# If the browser sends two session cookies with the same name (one host-only,
# one scoped to the parent domain by another app), expire the parent-domain one.
# The parent domain is derived from the request host, so this works on any host.
class ExpireSharedSessionCookie
  def initialize(app, key:, tld_length: 1)
    @app = app
    @key = key
    @tld_length = tld_length
  end

  def call(env)
    status, headers, body = @app.call(env)

    if env["HTTP_COOKIE"].to_s.scan("#{@key}=").size > 1
      host = env["HTTP_HOST"].to_s.split(":").first.to_s
      domain = ActionDispatch::Http::URL.extract_domain(host, @tld_length)

      if domain.present? && domain != host
        expire = "#{@key}=; domain=.#{domain}; path=/; max-age=0; " \
                 "expires=Thu, 01 Jan 1970 00:00:00 GMT; secure; samesite=lax"
        existing = headers["Set-Cookie"]
        list = existing.is_a?(Array) ? existing : existing.to_s.split("\n")
        headers["Set-Cookie"] = list + [expire]
      end
    end

    [status, headers, body]
  end
end

Rails.application.config.middleware.insert_before(
  ActionDispatch::Cookies,
  ExpireSharedSessionCookie,
  key: "_vizamyl_session"
)