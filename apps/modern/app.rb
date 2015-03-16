require 'rollbar'

IGNORED_NOT_FOUND_PATHS = /^\/(maven|netbeans)/

module Modern

  NotFound = proc do |env|
    path_info = env['PATH_INFO']
    Rollbar.warning("Not found: #{path_info}", env) unless path_info.match(IGNORED_NOT_FOUND_PATHS)
    content = "404 NOT FOUND"
    [404, {'Content-Type' => 'text/html', 'Content-Length' => content.length}, [content]]
  end

end
