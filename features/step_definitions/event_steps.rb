require 'chronic'

Given(/^an event "([^"]*)" on Lanyrd starting (.+)$/) do |event_summary, start_time_description|
  start_time = Chronic.parse(start_time_description)
  create_event start_time: start_time, summary: event_summary
end

When(/^I list the upcoming events$/) do
  visit '/events'
end

Then(/^I see "([^"]*)" session in the list of events$/) do |expected_event_summary|
  expect(page).to have_css('.event .summary', text: expected_event_summary)
end
