module Cucumber
  module Website
    module Core
      class Site
        def initialize(config)
          @config = config
        end

        def posts
          pages.
            select(&:post?).
            select { |page| page.date < Time.now }.
            sort { |a, b| b.date <=> a.date }
        end

        def pages
          views_path = File.dirname(__FILE__) + "/../../../../apps/dynamic/views"
          Page.all(@config, views_path, self)
        end
      end
    end
  end
end
