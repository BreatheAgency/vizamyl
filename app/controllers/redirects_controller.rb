require 'public_suffix'

class RedirectsController < ApplicationController
  def country
    origin = params[:origin].downcase
    config = COUNTRY_REDIRECTS[origin]

    return redirect_to root_url, status: :moved_permanently unless config&.dig(:redirect)

    # South Korea — fixed domain, not host-derived
    if origin == 'kr'
      return redirect_to "http://www.vizamyl.co.kr?origin=kr", status: :moved_permanently
    end

    subdomain = config[:subdomain]
    domain    = extract_domain(request.host)
    protocol  = request.protocol.chomp('://')

    redirect_to "#{protocol}://#{subdomain}.#{domain}?origin=#{origin}", status: :moved_permanently
  end

  private

  def extract_domain(host)
    return 'localhost:3000' if host.include?('localhost')

    parsed = PublicSuffix.parse(host)
    parsed.domain
  rescue PublicSuffix::Error
    host
  end
end