@debug
Feature: Olive 3 Regression Pack
  Create new campaign, Add Media Plan, Add Media Plan Line & Service with Discount Applied,
  Publish Media Plan, Insertion Order, Map to DS3, Map to Search Campaign, Approval Process,
  Edit Media PLan, Breach Media Plan, Conversion Evens, Tagging, Tracking Management & Mapping Status

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I wait for xpath "//*[@id='Email']" to appear
    And I fill in "Email" with "steve.automation@gmail.com"
    And I wait for xpath "//*[@id='Passwd']" to appear
    And I fill in "Passwd" with "Regression1000"
    Then I press "signIn"

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks

#   ***CREATE CAMPAIGN***
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in the "Campaign Search" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox
    And I wait for xpath "//*[@class='toast-message success--message show']" to disappear

    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I follow "campaign-add"
    Then I wait for 3000

    Then I fill in the "Campaign Name" with "<campaign>"
    And I fill in "campaign-new-client" with "<client>"
    Then I wait for 5000
    Then I fill in "campaign-new-managingRegion" with "EMEA"
    And I wait for 5000
    And I fill in "campaign-new-owner" with "<owner>"
    And I wait for xpath "//*[@id='campaign-new-owner-steve-automation']" to appear
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link





  Examples:
    |campaign  |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3 |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |purchaseorders|google|automation |q4-2015|100000|Client Liable|wildfire  |Google Ireland|2604|Shopping      |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




