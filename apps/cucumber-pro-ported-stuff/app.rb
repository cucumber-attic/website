require 'rack/contrib/try_static'
module CucumberProPortedStuff
  module App
    def self.new(app)
      config = {
        :root => File.expand_path(File.dirname(__FILE__) + "/jekyll-content/_site"),
        :urls => %w[/],
        :try => ['.html', 'index.html', '/index.html']
      }
      Rack::TryStatic.new(app, config)
    end
  end
end
