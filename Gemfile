source 'https://rubygems.org'
ruby '2.3.0'

# Core
gem 'sinatra', '1.4.7'
gem "rack-reverse-proxy", require: "rack/reverse_proxy"
gem 'rack-contrib'
gem 'rack-rewrite'
gem 'slim', '3.0.6'
gem 'redcarpet', '3.3.4'
gem 'htmlentities', '4.3.4'
gem 'liquid', '3.0.6'
gem 'pygments.rb', '0.6.3'
gem 'asciidoctor', '1.5.4'
gem 'octokit', '~> 4.0'
gem 'icalendar'
# TODO: Need this to get timezone support with icalendar
#gem 'activesupport'
gem 'values'

# Server
gem 'puma'

# Assets
gem 'sass'
gem 'rake'
gem 'sprockets', '~> 3.0'
gem 'sprockets-helpers'
gem 'autoprefixer-rails', '6.3.6'
gem 'uglifier', '3.0.0'

# Monitoring
gem 'newrelic_rpm'
gem 'rollbar'

group :development do
  gem 'foreman'
  gem 'launchy'
  gem 'rerun'
  gem 'rb-fsevent'
end

group :test do
  gem 'rspec'
  gem 'nokogiri', '1.6.7.2'
  gem 'cucumber'
  gem 'chronic'
  gem 'capybara'
end
