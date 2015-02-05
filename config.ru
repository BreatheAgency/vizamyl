# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

run Rack::Builder.new {

  case ENV['RACK_ENV'].to_sym
    when :staging
      use Rack::CanonicalHost, 'stg-www.readvizamyl.com', ignore: ['vizamyl-staging.herokuapp.com']
    when :production
      # use Rack::CanonicalHost, 'www.readvizamyl.com', ignore: ['vizamyl.herokuapp.com']
      use Rack::Rewrite do
        r302 %r{.*}, 'https://hls2.gehealthcare.com/content/unfiltered/LIFE-VIZAMYL-NONSCORM/'
      end
  end

  use Rack::Cors do
    allow do
      origins %w(https://stg-www.readvizamyl.com http://stg-www.readvizamyl.com https://www.readvizamyl.com http://www.readvizamyl.com https://vizamyl-staging.herokuapp.com http://vizamyl-staging.herokuapp.com https://vizamyl.herokuapp.com http://vizamyl.herokuapp.com http://0.0.0.0:5000 http://0.0.0.0:3000)
      resource '*', headers: :any, credentials: true, methods: [:get, :post, :put, :patch, :delete, :options], max_age: (ENV['RACK_ENV'] == 'production' ? 86_400 : 0)
    end
  end

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
