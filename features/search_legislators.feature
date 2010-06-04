Feature: Legislators
  In order to know their legislators
  a user
  wants to find their legislators

  Scenario: A user can search by their address from the home page
    Given I am on the home page
    And I fill in "address" with "7825 Harcourt Springs Ct. Indianapolis, IN 46260"
    And I press "legislators-search-button"
    Then I should see "Senators"
    And I should see "Representative"

  Scenario: A user can search by their address from the search page
    Given I am on the legislators search page
    And I fill in "address" with "7825 Harcourt Springs Ct. Indianapolis, IN 46260"
    And I press "legislators-search-button"
    Then I should see "Senators"
    And I should see "Representative"
