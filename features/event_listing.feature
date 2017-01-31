Feature: Event listing

  The event listing might appear in different places on the site, but there will 
  always be a summary at /events.

  Scenario: Event has a custom page but is not yet on Lanyrd
    Given a future event "BDD Kickstart Denver 2016" with a custom page
    When I list the upcoming events
    Then I see "BDD Kickstart Denver 2016" session in the list of events
    But I can access the event's custom page by its URL

  Scenario: Show featured event(s)
