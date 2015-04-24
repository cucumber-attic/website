require 'capybara/cucumber'

ENV['RACK_ENV'] = 'test'
Capybara.app = Rack::Builder.parse_file('config.ru').first
