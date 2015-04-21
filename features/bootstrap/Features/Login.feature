@login @CI
Feature: Test Olive 3 Login

  Scenario Outline: Login Scenarios


    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "<user>"
    And I fill in "Passwd" with "<pass>"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"


  Examples:
    |user                      |pass        |
    |steve.automation@gmail.com|Warlock1990   |