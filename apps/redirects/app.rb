require 'rack-rewrite'

module Redirects
  class App < Rack::Rewrite
    def initialize(app)
      super do
        # redirect ruby api to rubydoc.info
        r301 %r{/api/cucumber/ruby/yardoc(.*)}, "http://www.rubydoc.info/github/cucumber/cucumber$1"

        # redirect all other api traffic to the legacy site
        # TODO: figure out a better place to host it
        r301 %r{(/api/.+)}, "http://cucumber.github.io$1"

        r302 %r{/podcast/feed.xml}, "http://feeds.soundcloud.com/users/soundcloud:users:181591133/sounds.rss"
      end
    end
  end
end
