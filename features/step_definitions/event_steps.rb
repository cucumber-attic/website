require 'chronic'

Given(/^an event "([^"]*)" on Lanyrd starting (.+)$/) do |event_summary, start_time_description|
  start_time = Chronic.parse(start_time_description)
  create_event start_time: start_time, summary: event_summary
end

When(/^I list the upcoming events$/) do
  visit '/events'
end

Then(/^I see "([^"]*)" session in the list of events$/) do |expected_event_summary|
  expect(page).to have_css('.summary', text: expected_event_summary)
end

Then(/^I can access the Lanyrd page from the list of events$/) do
  expect(page).to have_css("a[href='#{the_ical_event.url}']")
end

Given(/^a custom event page with attributes:$/) do |table|
  # table is a Cucumber::Core::Ast::DataTable
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I can access the custom page from the list of events$/) do
  pending # Write code here that turns the phrase above into concrete actions
end
