require 'chronic'

Given(/^a future event "([^"]*)" on Lanyrd$/) do |event_summary|
  start_time = Chronic.parse('1 week from now')
  create_event start_time: start_time, summary: event_summary
end

Given(/^a future event "([^"]*)" on Lanyrd with a custom page$/) do |event_summary|
  start_time = Chronic.parse('1 week from now')
  create_event start_time: start_time, summary: event_summary, ical_url: 'http://lanyrd.com/2015/cucumberbdd/'
  create_event_page ical_url: 'http://lanyrd.com/2015/cucumberbdd/', url: '/events/bdd-analysis-london-2015'
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

Then(/^I can access the custom page from the list of events$/) do
  expect(page).to have_css("a[href$='#{the_custom_page.url}']")
end
