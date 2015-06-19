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
    Then I press "signIn"
    And I wait for xpath "//*[@id='Passwd']" to appear
    And I fill in "Passwd" with "Regression1000"
    Then I press "Sign in"
#    And I Maximize the Browser Window

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks

    # ***ACCESS EXISTING CAMPAIGN**
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I fill in the "Campaign Search" with "<campaign>"
    Then I wait for 3000
    Given I select Edit for the existing Campaign "<campaign>"
    Then I wait for 5000

# ***ACCESS EXISTING MEDIA PLAN**
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    Then I wait for 5000

    Then I click the "Publish Dropdown" link
    And I click the "Published State" link

  Examples:
    |campaign   |client|owner      |region |period |budget|liableEntity |initiative|supplier      |ds3 |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |conversionSource|
    |failedxpath|google|automation |EMEA   |q4-2015|100000|Client Liable|wildfire  |Google Ireland|2604|Shopping      |Steve Automation |Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|Google Floodlights|




