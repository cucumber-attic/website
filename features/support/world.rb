require 'cucumber/website/calendar'

module World

  def the_ical_event
    expect(calendars.length).to eq 1
    expect(calendars.first.events.length).to eq 1
    calendars.first.events.first
  end

  def the_custom_page
    expect(custom_pages.length).to eq 1
    custom_pages.first
  end

  def create_event(attributes)
    url = attributes[:ical_url] || 'http://lanyrd.com/2015/bdd-kickstart-san-francisco/'
    ical_data = <<-ICAL
BEGIN:VCALENDAR
VERSION:2.0
PRODID:-//lanyrd.com//Lanyrd//EN
X-ORIGINAL-URL:http://lanyrd.com/guides/cucumber-events/cucumber-events.ics
X-WR-CALNAME;CHARSET=utf-8:Cucumber and BDD Events
METHOD:PUBLISH
X-MS-OLK-FORCEINSPECTOROPEN:TRUE
BEGIN:VEVENT
SUMMARY;CHARSET=utf-8:#{attributes[:title]}
LOCATION;CHARSET=utf-8:Sauce Labs\, 539 Bryant Street #303 San Francisco\, CA 94107 USA\, 94107
URL:#{url}
UID:bbf17a9ff7fa28c427aac86fbc45604d48e6051e
DESCRIPTION:Three-day course on Behaviour-Driven Development
DTSTART;VALUE=DATE:#{attributes[:start_time].strftime("%Y%m%d")}
DTEND;VALUE=DATE:20150424
GEO:37.7802468;-122.3967115
END:VEVENT
    ICAL

    calendars << Cucumber::Website::FakeCalendar.new(ical_data)
    site_config['events'] = Cucumber::Website::Events.new(event_pages=[], calendars)
  end

  def create_event_page(front_matter)
    default_front_matter = {
      timestamp: Chronic.parse('1 week ago'),
      body: "<h1>#{front_matter.fetch(:title)}</h1>"
    }
    custom_pages << Cucumber::Website::FakeEventPage.new(default_front_matter.merge(front_matter))
    site_config['events'] = Cucumber::Website::Events.new(custom_pages, calendars).sync
    Capybara.app = Cucumber::Website.make_app(custom_pages + [
        Cucumber::Website::Page.new(Cucumber::Website::CONFIG, '/Users/matt/projects/cucumber-website/apps/dynamic/views/events.slim', '/Users/matt/projects/cucumber-website/apps/dynamic/views')
      ]
    )
  end

  def slugify(string)
    string.gsub(' ', '-').downcase
  end

  private

    def calendars
      @calendars ||= []
    end

    def custom_pages
      @custom_pages ||= []
    end

    def site_config
      Cucumber::Website::CONFIG['site']
    end
end

World(World)
