Feature: Payment

  Scenario: Pay for a plan
    When I visit the plans page
    And I submit valid credit card details
    Then I should see a success message
