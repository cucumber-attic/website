Feature: Event listing

  It should be easy for anyone to add BDD and Cucumber-related events to the events listing.

  The listing might appear in different places on the site, but there will always be a summary
  at /events.

  We want people to be able to use common event-tracking websites like Lanyrd and Meetup, but
  we need to have custom pages for certain events, like our CukeUp conferences.

  Some examples:

  - CukeUp Australia, which has a Lanyrd entry and an events page
  - Matt's Agile 2015 session, which has a Lanyrd entry only
  - BDD Meetup, which is on Meetup.com
  - Aslak's Cucumber talk at London Java Community, which is on Meetup.com

  Maybe later, we'll build something that scans a whitelist of agile / testing
  meetups for keywords like BDD / Cucumber etc and automatically adds them to
  our feed.

  We'll have an iCal feed that people can consume.

  Scenario: Show event from Lanyrd that has no custom event page
    Given a future event "Matt's Agile 2015 Session" on Lanyrd
    When I list the upcoming events
    Then I see "Matt's Agile 2015 Session" session in the list of events
    And I can access the Lanyrd page from the list of events

  Scenario: Show event that's on Lanyrd and has a custom event page
    Given a future event "BDD analysis London 2015" on Lanyrd with a custom page
    When I list the upcoming events
    Then I see "BDD analysis London 2015" session in the list of events
    And I can access the custom page from the list of events

  Scenario: Event has a custom page but is not yet on Lanyrd
    Given a future event "BDD Kickstart Denver 2016" with a custom page but not on Lanyrd
    When I list the upcoming events
    Then I cannot see "BDD Kickstart Denver 2016" session in the list of events
    But I can access the event's custom page by its URL

  Scenario: Show featured event(s)
