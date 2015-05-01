@debug
Feature: DEBUG ONLY

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock1990"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: DEBUG AND CODING ONLY

    # ***ACCESS EXISTING CAMPAIGN**
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 5000
    Given I select Edit for the existing Campaign "<campaign>"
    Then I wait for 5000

#   ***ADD MEDIA PLAN LINE**
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    Then I wait for 5000

    #   ***LINK INSERTION ORDER TO DS3***
    And I wait for 2000
    Then I click the "Insertion Order tab" link
    Then I wait for 4000
    Then I click the "Publish Dropdown" link
    Then I click the "Published State" link
    And I wait for 4000
    And I click the "View IO" link
    And I wait for 4000
    Then I click the "External Platforms Insertion Order" link
    And I click the "Link DS3" link
    And I wait for 2000
    Then I click the "DS3 Account ID" link
    And I wait for 2000
    Then I fill in the "DS3 Account ID" with "<ds3>"
#    And I fill in "mapping-externalSystem-ds3" with "<ds3>"
    Then I wait for 8000
    And I click the link containing Text "<ds3>"
    Then I click the "External System Save" link


  Examples:
    |campaign |client|owner      |period |budget|clientLiable |initiative|buyType   |supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |regressionlocal|google|automation |q4-2015|100000|Client Liable|wildfire  |Direct Buy|Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|
