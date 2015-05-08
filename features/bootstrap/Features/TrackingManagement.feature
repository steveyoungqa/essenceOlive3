@tracking
Feature: Tracking Management

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Regression1000"
    Then I press "signIn"
    Then I wait for 5000
    Then I should see "Notifications"

  Scenario Outline: Tracking Management

#   ***TRACKING MANAGEMENT***
    Then I click the "Navigation Header" link
    Then I click the "Tracking Management DS3" link
    And I click the "Tracking Code Search Box" link
    Then I fill in the "Tracking Code Search Box" with "<searchCampaign>"
    Then I wait for 3000
    And I click the "Advanced Filter" link
    Then I wait for 2000
    Then I click the "Campaign Filter" link
    And I fill in the "Campaign Filter" with "<campaign>"
    Then I wait for 2000
    Then I click the link containing Text "<campaign>"
    And I click the "Advanced Search Close" link
    Then I click the "Tracking Details" link
    And I wait for 5000
#    Then I should see "MAPPED"


  Examples:
    |campaign  |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3 |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |tracking  |google|automation |q4-2015|100000|Client Liable|wildfire  |Google Ireland|2604|Shopping      |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




