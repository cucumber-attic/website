require 'rollbar'

Dir['apps/*'].each do |path|
  require_relative path + '/app'
end

if ENV['ROLLBAR_ACCESS_TOKEN']
  Rollbar.configure do |config|
    config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']
  end
end

use Api::App
use LegacyCukesInfo::App
use CucumberEclipse::App
use Docs::App
use CucumberProPortedStuff::App
run CucumberProPortedStuff::NotFound
