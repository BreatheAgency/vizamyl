# This file is used by Rack-based servers to start the application.
require ::File.expand_path('../config/environment',  __FILE__)

run Rack::Builder.new {

  case ENV['RACK_ENV'].to_sym
    when :staging
      use Rack::CanonicalHost, 'readvizamyl.com', ignore: ['vizamyl-staging.herokuapp.com', 'vizamyl.herokuapp.com']
    when :production
      use Rack::Rewrite do
        r302 %r{.*}, 'https://hls2.gehealthcare.com/content/unfiltered/LIFE-VIZAMYL-NONSCORM/'
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
