require 'rack-rewrite'

module Redirects
  class App < Rack::Rewrite
    def initialize(app)
      super do
        # redirect ruby api to rubydoc.info
        r301 %r{/api/cucumber/ruby/yardoc(.*)}, "http://www.rubydoc.info/github/cucumber/cucumber-ruby$1"
        r301 %r{/cucumber/api/ruby/latest(.*)}, "http://www.rubydoc.info/github/cucumber/cucumber-ruby$1"

        # redirect initials to homepage for tracking business cards
        # we may want to create personal pages thanking people for chatting with us
        # at these urls
        r303 %r{^/(ah|jb|mw|sr|st|tsr|rm)$}, "/"

        # redirect all other api traffic to the legacy site
        r301 %r{(/api/.+)}, "http://cucumber.github.io$1"

        # podcast feed
        r302 %r{/podcast/feed.xml}, "http://feeds.soundcloud.com/users/soundcloud:users:181591133/sounds.rss"

        # redirect old docs links
        r301 %r{/docs}, "https://docs.cucumber.io"
      end
    end
  end
end
