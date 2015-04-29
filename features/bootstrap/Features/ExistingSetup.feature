@existing
Feature: Perform tests upon an Existing Setup
  Tests upon an Existing Campaign, Media Plan, Plan Line

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock1990"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: Tests upon Existing Campaign
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

    Then I click the "Add Media Plan Line" link
    Then I wait for 2000
    And I click the "Cost Type Media" link
    Then I click the "Line Channel" link
    And I click the "Line Channel Search" link
    Then I click the "Section" link
    And I click the link containing Text "Default"
    Then I wait for 2000
    Then I click the "Supplier" link
    And I click the link containing Text "<supplier>"
    Then I click the "Platform" link
    Then I click the "Platform DS3" link
    Then I wait for 2000
    Then I click the "Property" link
    And I click the link containing Text "Google Search"
    Then I wait for 2000
    Then I click the "Media Type" link
    And I click the link containing Text "Search Text Ad"
    Then I wait for 2000
    Then I click the "Cost Model" link
    And I click the link containing Text "Biddable CPC"
    Then I select a Plan Line Start Date of "2015-04-04"
    Then I wait for 2000
    Then I Select a Plan Line End Date of "2015-04-04"
    Then I wait for 2000

    Then I click the "Line Currency" link
    And I click the link containing Text "British Pound"
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalGross" with "100"

    Then I click the "Discount Applied" checkbox
    And I wait for 2000
    And I click the "Discount Amount Tab" link
    Then I fill in the "Discount Amount" with "50"

    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

    Then I click the "Save Media Plan Line" link
    Then I wait for 5000
    Then I reload the page
    Then I wait for 5000



##   ***DELETE CAMPAIGN CLEAN UP***
#    Then I click the "Navigation Header" link
#    Then I click the "Campaigns" link
#    Then I wait for 3000
#    Then I fill in "campaign-search-basic" with "<campaign>"
#    Then I wait for 3000
#    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign  |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |existing|google|automation |q4-2015|100000|Client Liable|wildfire  |Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|


