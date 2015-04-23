@coding
Feature: Deugging and Coding ONLY


  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock1990"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario: Debug & Coding
# ***CREATE CAMPAIGN***
    Then I click the "Campaign Tasks Notification" link
    And I should see text matching "untracked spend"
    Then I should see text matching "Go"
    Then I click the link containing Text "Go"

