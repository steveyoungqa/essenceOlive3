@existing
Feature: Perform tests upon an Existing Setup
  Tests upon an Existing Campaign, Media Plan, Plan Line

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I wait for xpath "//*[@id='Email']" to appear
    And I fill in "Email" with "steve.automation@gmail.com"
    Then I press "signIn"
    And I wait for xpath "//*[@id='Passwd']" to appear
    And I fill in "Passwd" with "Regression1000"
    Then I press "Sign in"
    And I Maximize the Browser Window

  Scenario Outline: Tests upon Existing Campaign
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

#   ***ADD KPI***
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in the "Campaign Search" with "<campaign>"
    Then I wait for 3000
    Given I select Edit for the existing Campaign "<campaign>"
    And I click the "Default KPIs" link
    Then I click the "Add KPI" link
    Then I wait for 2000
    And I fill in the "KPI Event Type" with "Brand"
    Then I wait for 2000
    And I fill in the "KPI Event Number" with "20"
    And I fill in the "KPI Event Name" with "Regression Event"
    Then I click the "Conversion Source Field" link
    Then I fill in the "Conversion Source Field" with "<conversionSource>"
    And I wait for text "<conversionSource>" to appear
    Then I click the link containing Text "<conversionSource>"
    And I click the "Event Save" link
    And I wait for 3000
    Then I click the "Add Tag" link
    And I click the "Conversion Type" link
    And I wait for text "<conversion>" to appear
    And I fill in the "Conversion Type" with "<conversion>"
    And I click the link containing Text "<conversion>"
    And I wait for xpath "//*[@id='campaign-events-tags-new-activityGroup']" to appear
    And I click the "Activity Category" link
    And I fill in the "Activity Category" with "<activity>"
    And I wait for 3000
    And I click the link containing Text "<activity>"
    And I click the "Activity Tag" link
    And I fill in the "Activity Tag" with "<tag>"
    Then I wait for 3000
    And I click the link containing Text "<tag>"
    Then I fill in the "Weighting" with "10"
    And I click the "Tag Save" link
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear




  Examples:
    |campaign  |client|owner      |region |period |budget|liableEntity |initiative|property1|property2|supplier      |line1       |line2      |line3      |line2update              |>ds3 |searchCampaign|approver   |conversionSource  |conversion        |activity         |tag       |ds3Advert                    |
    |stevefix  |google|automation |EMEA   |q4-2015|100000|Client Liable|wildfire  |YouTube  |GDN      |Google Ireland|YouTubeDraft|GDN1Publish|GDN2Publish|Line 2 Changed to YouTube|2604|Shopping      |Steve Automation |Google Floodlights|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|



