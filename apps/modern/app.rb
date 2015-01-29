require 'rollbar'
require 'rack/contrib/try_static'
require 'rack/contrib/not_found'

IGNORED_NOT_FOUND_PATHS = /^\/(maven|netbeans)/

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
    path_info = env['PATH_INFO']
    Rollbar.warning("Not found: #{path_info}", env) unless path_info.match(IGNORED_NOT_FOUND_PATHS)
    [404, {'Content-Type' => 'text/html', 'Content-Length' => length}, [content]]
  end

end
