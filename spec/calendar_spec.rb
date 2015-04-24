require 'cucumber/website/calendar'

module Cucumber::Website
  describe Calendar do
    let(:lanyrd)       { Calendar.new(File.expand_path(File.dirname(__FILE__) + '/events/lanyrd.ics'), logger) }
    let(:meetup)       { Calendar.new(File.expand_path(File.dirname(__FILE__) + '/events/bdd-london.ics'), logger) }
    let(:bad_calendar) { Calendar.new(File.expand_path(File.dirname(__FILE__) + '/events/bad.ics'), logger) }

    let(:logger) { double.as_null_object }

    it "starts out with no events" do
      expect(lanyrd.events).to be_empty
    end

    it "fetches events from the URL when refreshed" do
      expect(lanyrd.refresh.events).to_not be_empty
    end

    it "prepends Meetup name to meetup.com events" do
      expect(meetup.refresh.events[0].summary).to eq('BDD London: [June meetup]')
    end

    it "logs when refresh fails to parse the data" do
      expect(logger).to receive(:warn)
      bad_calendar.refresh
      expect(bad_calendar.events).to be_empty
    end
  end
end
