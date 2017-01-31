require 'values'
require 'cucumber/website/core/community'

module Cucumber
  module Website
    module Core
      class Site < Value.new(:config, :pages, :git_hub)

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

        def upcoming_events
          pages.select(&:event?).
            select { |page| page.dtstart >= Time.now }.
            sort { |a, b| b.dtstart <=> a.dtstart }
        end
        
        def past_events
          pages.select(&:event?).
            select { |page| page.dtstart < Time.now }.
            sort { |a, b| b.dtstart <=> a.dtstart }
        end
      end
    end
  end
end
