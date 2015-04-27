@debug
Feature: Olive 3 Regression Pack
  Create new campaign, Add Media Plan, Add Media Plan Line & Service
  OAT-99, OAT-111, OAT-62, OAT-72

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock1990"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks


  Examples:
    |campaign |client|owner      |period |budget|clientLiable |initiative|buyType   |supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |planline |google|automation |q4-2015|100000|Client Liable|wildfire  |Direct Buy|Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|
