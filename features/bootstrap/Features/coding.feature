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

  Scenario Outline: Debug & Coding
# ***CREATE CAMPAIGN***
    Then I click the "Campaign Tasks Notification" link
    And I should see text matching "untracked spend"
    Then I should see text matching "Go"
    Then I click the link containing Text "Go"
    Then



  Examples:
    |campaign       |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |debugtests     |google|automation |q4-2015|100000|Client Liable|wildfire  |Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|
