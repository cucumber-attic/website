Given(/^the number of recent contributors to display is (\d+)$/) do |max|
  config['community']['max_recent_contributors'] = max.to_i
end

Given(/^the most recent actors on Cucumber's GitHub organization are:$/) do |contributor_usernames|

  contributors = contributor_usernames.raw.flatten.map do |username|
    create_contributor(username: username)
  end

  git_hub.events = contributors.map { |contributor|
    Cucumber::Website::Core::GitHubEvent.with contributor: contributor
  }
end

When(/^I view the homepage$/) do
  visit '/'
end

Then(/^I see these avatars:$/) do |expected_avatars|
  actual_avatars = all(".community-avatars img").map { |e| e['alt'] }
  expect(actual_avatars).to eq expected_avatars.raw.flatten
end
