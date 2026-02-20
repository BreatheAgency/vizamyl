# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

run Rack::Builder.new {

  map '/ping' do
    run proc { |_env| Rack::Response.new('PING', 200) }
  end

  case ENV['RACK_ENV'].to_sym
    when :staging
      use Rack::CanonicalHost, 'stg-www.readvizamyl.com'
    when :production
      use Rack::CanonicalHost, 'www.readvizamyl.com'
  end

  use Rack::Noindex, -> (_env) { true }
  use Rack::Deflater
  run Rails.application
}
