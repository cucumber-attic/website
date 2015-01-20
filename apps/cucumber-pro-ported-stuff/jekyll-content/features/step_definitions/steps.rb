When(/^I visit the plans page$/) do
  visit '/plans.html?utm_campaign=special-promotion'
end

When(/^I submit valid credit card details$/) do
  find('#js-buy-medium .ladda-label').click
  within_frame(find('.stripe_checkout_app')) do
    fill_in('email', with: 'test@cucumber.pro')
    fill_in('billing-name', with: 'Test User')
    fill_in('billing-street', with: 'Test Street')
    fill_in('billing-zip', with: 'TTT')
    fill_in('billing-city', with: 'Testville')
    find('button[type="submit"]').click
    within('.paymentInput') do
      fill_in('card_number', with: '4242' * 4)
      fill_in('cc-exp', with: '12/20')
      fill_in('cc-csc', with: '123')
    end
    find('button[type="submit"]').click
  end
end

Then(/^I should see a success message$/) do
  find("#js-buy-medium .ladda-label", text: "Creating Account")
  find("#js-buy-medium .ladda-label", text: "Thank you. Please check your email.")
end
