$: << File.dirname(__FILE__) + '/lib'
ENV['RACK_ENV'] ||= "development"

Dir['apps/*'].each do |path|
  require_relative path + '/app'
end

if ENV['ROLLBAR_ACCESS_TOKEN']
  require 'rollbar'
  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
    config.exception_level_filters.merge!('Sinatra::NotFound' => 'ignore')
  end
end

require 'newrelic_rpm'

use Redirects::App
use CucumberEclipse::App
use Cucumber::Website::Static::App

require 'split/dashboard'

Split::Dashboard.use Rack::Auth::Basic do |username, password|
  username == 'admin' && password == ENV['SPLIT_DASHBOARD_PASSWORD'] || 'password'
end

Split.configure do |config|
  config.redis_url = ENV['REDIS_URL'] || 'localhost:6379'
end

map "/abtest" do
  use Split::Dashboard
end

run Cucumber::Website::App
