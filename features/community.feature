Feature: Community
  Display a unique list of GitHub contributors from the most recent events.

  Scenario: See GitHub contributors
    Given the number of recent contributors to display is 3
    And the most recent actors on Cucumber's GitHub organization are:
      | aslakhellesoy  |
      | mattwynne      |
      | mattwynne      |
      | charlierudolph |
      | romaingweb     |
    When I view the homepage
    Then I see these avatars:
      | aslakhellesoy  |
      | mattwynne      |
      | charlierudolph |

  Scenario: See GitHub issue comments
