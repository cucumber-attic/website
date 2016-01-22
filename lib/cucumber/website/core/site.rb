require 'values'
require 'cucumber/website/core/community'

module Cucumber
  module Website
    module Core
      class Site < Value.new(:config, :pages, :calendars, :git_hub)

        def to_liquid
          config
        end

        def community
          Community.with(config: config, contributors: git_hub.events.map(&:contributor).uniq)
        end

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
