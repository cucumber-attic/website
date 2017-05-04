require "rack/reverse_proxy"

module SquarespaceProxy
  module App
    def self.new(app)
      Rack::ReverseProxy.new(app) do
        reverse_proxy(
          /^\/events\/cukenfest-london-2017(.*)$/,
          'http://theo-england-znhb.squarespace.com$1',
          preserve_host: false, x_forwarded_headers: false
        )
      end
    end
  end
end

