require 'chronic'

Given(/^a future event "([^"]*)" with a custom page$/) do |title|
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
  expect(the_custom_page.title).to_not be_nil
  expect(page).to have_text(the_custom_page.title)
end
