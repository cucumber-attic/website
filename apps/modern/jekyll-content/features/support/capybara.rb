require 'capybara/cucumber'

Capybara.app_host = 'http://localhost:4000'
Capybara.default_driver = :selenium
Capybara.default_wait_time = 20
