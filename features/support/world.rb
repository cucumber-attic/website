require 'cucumber/website/calendar'

module World

  def the_ical_event
    expect(@ical_feed.events.length).to eql 1
    @ical_feed.events.first
  end

  def create_event(attributes)
    ical_data = <<-ICAL
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//lanyrd.com//Lanyrd//EN
X-ORIGINAL-URL:http://lanyrd.com/guides/cucumber-events/cucumber-events.ics
X-WR-CALNAME;CHARSET=utf-8:Cucumber and BDD Events
METHOD:PUBLISH
X-MS-OLK-FORCEINSPECTOROPEN:TRUE
BEGIN:VEVENT
SUMMARY;CHARSET=utf-8:#{attributes[:summary]}
LOCATION;CHARSET=utf-8:Sauce Labs\, 539 Bryant Street #303 San Francisco\, CA 94107 USA\, 94107
URL:http://lanyrd.com/2015/bdd-kickstart-san-francisco/
UID:bbf17a9ff7fa28c427aac86fbc45604d48e6051e
DESCRIPTION:Three-day course on Behaviour-Driven Development
DTSTART;VALUE=DATE:#{attributes[:start_time].strftime("%Y%m%d")}
DTEND;VALUE=DATE:20150424
GEO:37.7802468;-122.3967115
END:VEVENT
    ICAL
    @ical_feed = Cucumber::Website::FakeCalendar.new(ical_data)
    Cucumber::Website::App::CONFIG['site']['events'] =
      Cucumber::Website::Events.new(event_pages=[], calendars=[@ical_feed])
  end
end

World(World)
