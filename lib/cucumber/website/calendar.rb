require 'open-uri'
require 'icalendar'

module Cucumber
  module Website
    class Calendar
      def initialize(url, logger)
        @url, @logger = url, logger
        @calendars = []
      end

      def events
        @calendars.map(&:events).flatten
      end

      def refresh
        @logger.debug "Fetching events from #{@url}"
        @calendars = Icalendar::Parser.new(open(@url), true).parse
        tweak
        @logger.debug "Fetched #{events.length} events from #{@url}"
        self
      rescue => exception
        @logger.warn exception.to_s
      end

      def tweak
        @calendars.each do |calendar|
          calendar.events.each do |event|
            # Meetup.com events' summaries are tweaked to have the Meetup name as a prefix
            if calendar.prodid == '-//Meetup//RemoteApi//EN'
              meetup_name = (calendar.x_wr_calname[0] || '').split(' - ')[1]
              event.summary = [meetup_name, event.summary].compact.join(': ')
            end
          end
        end
      end
    end

    # Stub used for specs and scenarios
    class FakeCalendar
      def initialize(data)
        @data = data
      end

      def events
        calendars = Icalendar::Parser.new(@data, true).parse
        calendars.map(&:events).flatten
      end
    end
  end
end
