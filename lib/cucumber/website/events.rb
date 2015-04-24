module Cucumber
  module Website
    class Events
      include Enumerable

      def initialize(event_pages, calendars)
        @event_pages, @calendars = event_pages, calendars
      end

      def each(&block)
        events.each &block
      end

      # Updates iCal event urls with url to page
      # Updates event page attributes (title, location etc) with data from iCal event
      def sync
        @events = nil
        each do |event|
          matching_event_page = @event_pages.find do |event_page|
            event_page.ical_url == event.url.to_s
          end

          if matching_event_page
            event.url = Icalendar::Values::Uri.new(matching_event_page.url)

            matching_event_page.title   = event.summary
            # Dates are broken on Lanyrd: https://twitter.com/aslak_hellesoy/status/591272555035684864
            # Start dates is right, end date is wrong (!?!)
            # matching_event_page.dtstart = event.dtstart
            # matching_event_page.dtend   = event.dtend
          end
        end
      end

      def start(calendar_refresh_interval)
        @calendars.each do |calendar|
          Thread.new do
            loop do
              calendar.refresh
              sync
              # modify sleep time a little to distribute refresh times
              sleep_time = calendar_refresh_interval + rand*calendar_refresh_interval*0.1
              sleep sleep_time
            end
          end
        end
      end

    private

      def events
        @events ||= @calendars.map(&:events).flatten.sort { |e1, e2| e1.dtstart <=> e2.dtstart }
      end
    end
  end
end
