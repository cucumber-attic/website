require 'cucumber/website/events'
require 'cucumber/website/calendar'
require 'cucumber/website/page'
require 'cucumber/website/config'

module Cucumber::Website
  describe Events do
    include Config

    let(:config) { load_config('test') }
    let(:views_dir) { File.dirname(__FILE__) + '/../apps/dynamic/views' }
    let(:event_pages) { Page.all(config, views_dir).select(&:event?) }
    let(:lanyrd) { ical = IO.read(File.dirname(__FILE__) + '/events/lanyrd.ics') }
    let(:bdd_london) { ical = IO.read(File.dirname(__FILE__) + '/events/bdd-london.ics') }

    it "replaces event url with local page when we have one that matches" do
      events = Cucumber::Website::Events.new(event_pages, calendars=[Cucumber::Website::FakeCalendar.new(lanyrd)])
      events.sync

      cukeup_australia = events.to_a[1]
      expect(cukeup_australia.url.to_s).to eq('https://cukes.info/events/cukeup-australia-2015')
      expect(cukeup_australia.url.class).to eq(Icalendar::Values::Uri)
    end

    it "creates aggregated ical feed"

    it "replaces page attributes with attributes from event" do
      events = Cucumber::Website::Events.new(event_pages, calendars=[Cucumber::Website::FakeCalendar.new(lanyrd)])
      events.sync

      cukeup_australia_page = event_pages.find {|page| page.title == 'CukeUp Australia'}
      expect(cukeup_australia_page).to_not be_nil
      expect(cukeup_australia_page.dtstart.strftime('%Y%m%d')).to eq('20151203')
      expect(cukeup_australia_page.dtend.strftime('%Y%m%d')).to eq('20151204')
    end

    it "updates after the ical feed changes" do
      calendars = [Cucumber::Website::FakeCalendar.new(lanyrd)]
      events = Cucumber::Website::Events.new(event_pages, calendars)
      events.sync

      calendars[0] = Cucumber::Website::FakeCalendar.new(lanyrd.gsub(/CukeUp Australia/m, 'CukeUp Australia Updated'))
      events.sync

      cukeup_australia_page = event_pages.find {|page| page.title == 'CukeUp Australia Updated'}
      expect(cukeup_australia_page).to_not be_nil
    end
  end
end
