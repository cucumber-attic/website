require 'rollbar'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

module Modern
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

  # This page is served from this rack app as it depends on the CSS served from here
  content = File.read(File.expand_path(File.dirname(__FILE__) + "/jekyll-content/_site/404.html"))
  length = content.size.to_s

  NotFound = proc do |env|
    Rollbar.warning("Not found: #{env['PATH_INFO']}", env)
    [404, {'Content-Type' => 'text/html', 'Content-Length' => length}, [content]]
  end

end
