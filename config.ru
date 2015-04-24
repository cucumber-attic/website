$: << File.dirname(__FILE__) + '/lib'

Dir['apps/*'].each do |path|
  require_relative path + '/app'
end

if ENV['ROLLBAR_ACCESS_TOKEN']
  require 'rollbar'
  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  end
end

use Api::App
use CucumberEclipse::App
use Cucumber::Website::App
run Modern::NotFound
