Given(/^the number of recent contributors to display is (\d+)$/) do |max|
  Cucumber::Website::CommunityLoader.max_recent_contributors = max.to_i
end

Given(/^the most recent actors on Cucumber's GitHub organization are:$/) do |contributors|
  Cucumber::Website::CommunityLoader.recent_github_contributors = contributors.raw.flatten

  # Refresh the list of contributors
  Cucumber::Website::CommunityLoader.new.refresh
end

When(/^I view the homepage$/) do
  visit '/'
end

Then(/^I see these avatars:$/) do |expected_avatars|
  actual_avatars = all(".community-avatars img").map { |e| e['alt'] }
  expect(actual_avatars.size).to eq Cucumber::Website::CommunityLoader.max_recent_contributors
  expect(actual_avatars).to eq expected_avatars.raw.flatten
end
