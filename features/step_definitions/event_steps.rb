require 'chronic'

Given(/^a future event "([^"]*)" on Lanyrd$/) do |title|
  start_time = Chronic.parse('1 week from now')
  create_event start_time: start_time, title: title
end

Given(/^a future event "([^"]*)" on Lanyrd with a custom page$/) do |title|
  start_time = Chronic.parse('1 week from now')
  create_event start_time: start_time, title: title, ical_url: 'http://lanyrd.com/2015/cucumberbdd/'
  create_event_page ical_url: 'http://lanyrd.com/2015/cucumberbdd/', url: '/events/bdd-analysis-london-2015'
end

Given(/^a future event "([^"]*)" with a custom page but not on Lanyrd$/) do |title|
  create_event_page title: title, url: "/events/#{slugify title}"
end

When(/^I list the upcoming events$/) do
  visit '/events'
end

Then(/^I see "([^"]*)" session in the list of events$/) do |expected_title|
  expect(page).to have_css('.summary', text: expected_title)
end

Then(/^I cannot see "([^"]*)" session in the list of events$/) do |expected_title|
  expect(page).to have_no_css('.summary', text: expected_title)
end

Then(/^I can access the Lanyrd page from the list of events$/) do
  expect(page).to have_css("a[href='#{the_ical_event.url}']")
end

Then(/^I can access the custom page from the list of events$/) do
  expect(page).to have_css("a[href$='#{the_custom_page.url}']")
end

Then(/^I can access the event's custom page by its URL$/) do
  visit the_custom_page.url
  expect(page).to have_text(the_custom_page.title)
end
