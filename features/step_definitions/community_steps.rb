Given(/^the number of recent contributors to display is (\d+)$/) do |arg1|
end

Given(/^the most recent actors on Cucumber's GitHub organization are:$/) do |table|
end

When(/^I view the homepage$/) do
  visit '/'
end

Then(/^I see these avatars:$/) do |expected_avatars|
  actual_avatars = all(".community-avatars img").map { |e| e['alt'] }
  expect(actual_avatars).to eq expected_avatars.raw.flatten
end
