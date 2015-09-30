module Cucumber
  module Website
    module Core
      class Site < Value.new(:config, :pages, :calendars)

        def posts
          pages.
            select(&:post?).
            select { |page| page.date < Time.now }.
            sort { |a, b| b.date <=> a.date }
        end

        def events
          Cucumber::Website::Events.new(pages.select(&:event?), calendars).sync
        end
      end
    end
  end
end
