# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

run Rack::Builder.new {
  use Rack::CanonicalHost, 'readvizamyl.com', ignore: ['staging-vizamyl.herokuapp.com', 'vizamyl.herokuapp.com', '0.0.0.0']

  map '/ping' do
    run proc { |_env| Rack::Response.new('PING', 200) }
  end

  map '/robots.txt' do
    run proc { |_env| Rack::Response.new('User-agent: *\nDisallow: /', 200, 'Content-Type' => 'text/plain') }
  end

  use Rack::Noindex, -> (_env) { true }
  use Rack::Deflater
  run Rails.application
}
