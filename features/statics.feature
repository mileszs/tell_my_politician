Feature: Static Pages

  Scenario: A user should see the button example on the home page
    Given I go to the home page
    Then I should see a "a" tag with its "onclick" attribute set to "return tmp_click()"
