# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

run Rack::Builder.new {

  map '/ping' do
    run proc { |_env| Rack::Response.new('PING', 200) }
  end

  use Rack::CanonicalHost, -> (env) { Rack::Request.new(env).host }

  use Rack::Noindex, -> (_env) { true }
  use Rack::Deflater
  run Rails.application
}