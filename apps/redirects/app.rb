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
        r303 %r{^/(ah|jb|mw|sr|st)$}, "/"

        # redirect all other api traffic to the legacy site
        # TODO: figure out a better place to host it

        r301 %r{(/api/.+)}, "http://cucumber.github.io$1"

        r302 %r{/podcast/feed.xml}, "http://feeds.soundcloud.com/users/soundcloud:users:181591133/sounds.rss"
      end
    end
  end
end
