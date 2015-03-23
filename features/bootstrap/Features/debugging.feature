@debug
Feature: Olive 3 Regression Pack
  Create new campaign, Add Media Plan, Add Media Plan Line & Service, Publish Media Plan
  Insertion Order, Map to DS3, Map to Search Campaign, Approval Process
  Conversion Evens, Tagging, Tracking Management & Mapping Status

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock99"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks


    Then I click the "Navigation Header" link
    Then I follow "Campaigns"

    Then I fill in the "Campaign Search" with "DEBUG SCREENSHOT TEST"
    Then I click the "External Platforms" link
#
#    THIS TEST WILL FAIL - TO TEST SCREENSHOT GENERATION

  Examples:
    |campaign       |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |regressiontests|google|automation |q4-2015|100000|Client Liable|engage    |Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




