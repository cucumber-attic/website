require 'rack-rewrite'

module Api
  class App < Rack::Rewrite
    def initialize(app)
      super do
        r301 %r{/api/cucumber/ruby/yardoc(.+)}, "http://www.rubydoc.info/github/cucumber/cucumber$1"
      end
    end
  end
end
