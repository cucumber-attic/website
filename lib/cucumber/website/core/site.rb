module Cucumber
  module Website
    module Core
      class Site
        attr_reader :pages

        def initialize(config, pages)
          @config = config
          @pages = pages
        end

        def posts
          pages.
            select(&:post?).
            select { |page| page.date < Time.now }.
            sort { |a, b| b.date <=> a.date }
        end
      end
    end
  end
end
