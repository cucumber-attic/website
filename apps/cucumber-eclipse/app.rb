require 'rack/reverse_proxy'

module CucumberEclipse
  module App
    def self.new(app)
      Rack::ReverseProxy.new(app) do
        reverse_proxy(/^\/cucumber-eclipse(.*)$/, 'http://cucumber.github.io/cucumber-eclipse$1')
      end
    end
  end
end
