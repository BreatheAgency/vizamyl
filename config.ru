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

  # use Rack::Cors do
  #   allow do
  #     origins %w(https://stg-www.readvizamyl.com http://stg-www.readvizamyl.com https://www.readvizamyl.com http://www.readvizamyl.com http://vizamyl-sandbox.herokuapp.com http://vizamyl-staging.herokuapp.com http://vizamyl.herokuapp.com http://localhost:3000)
  #     resource '*', headers: :any, credentials: true, methods: [:get, :post, :put, :patch, :delete, :options], max_age: (ENV['RACK_ENV'] == 'production' ? 86_400 : 0)
  #   end
  # end

  use Rack::Noindex, -> (_env) { true }
  use Rack::Deflater
  run Rails.application
}
