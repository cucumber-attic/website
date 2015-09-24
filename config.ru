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

use Api::App
use CucumberEclipse::App
use Cucumber::Website::Static::App
run Cucumber::Website::App
