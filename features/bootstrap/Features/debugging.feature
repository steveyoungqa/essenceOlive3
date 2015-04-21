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

    # ***ADD MEDIA PLAN LINE**
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Given I select Edit for the existing Campaign "<campaign>"
    Then I wait for 5000
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    Then I wait for 5000

# ***ADD 2ND MEDIA PLAN LINE **
    Then I click the "Add Media Plan Line" link
    Then I wait for 2000
    And I click the "Cost Type Media" link

    Then I click the "Buy Type" link
    Then I wait for 2000
    And I fill in the "Buy Type" with "<buyType>"
    Then I wait for 2000

    Then I click the "Line Channel" link
    And I fill in the "Line Channel" with "Display"
    Then I wait for 2000
    Then I click the "Section" link
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-lines-new-vertical" with "Custom Section"
#    Then I click the link containing Text "Custom Section"
    Then I wait for 2000
    Then I click the "Supplier" link
    Then I wait for 2000
    Then I fill in the "Supplier" with "<supplier>"
    Then I wait for 2000
    Then I click the "Platform" link
    And I click the link containing Text "DS3"
    Then I wait for 2000
    Then I click the "Property" link
    And I click the link containing Text "Google Search"
    Then I wait for 2000
    Then I click the "Media Type" link
    Then I wait for 2000

    And I click the link containing Text "Link / text ad"
    Then I wait for 2000
    Then I click the "Cost Model" link
    And I click the link containing Text "Biddable CPC"
    Then I select a Plan Line Start Date of "2015-04-04"
    Then I wait for 2000
    Then I Select a Plan Line End Date of "2015-04-04"
    Then I wait for 2000

    Then I click the "Line Currency" link
    And I click the link containing Text "British Pound"
    And I click the "Unknown Budget" checkbox
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Plan Line 2"

    Then I click the "Save Media Plan Line" link
    Then I wait for 5000

# ***CHECK INDIVIDUAL INSERTION ORDERS ARE CREATED DUE TO A MIX OF SET AND UNKNOWN BUDGET *
    Then I click the "Insertion Order tab" link
    Then I wait for 4000
    Then I should see "2 found"

#   ***EDIT FIRST MEDIA PLAN LINE***
    Then I click the "Plan tab" link
    Then I Maximize the Browser Window
    And I wait for 2000
    Then I click the "First Plan Line Edit" link
    Then I wait for 4000
    Then I click the "Liable Entity" link
    Then I wait for 2000
    Then I click the link containing Text "Essence LON"
    Then I wait for 2000
    And I click the "Unknown Budget" checkbox
    And I wait for 2000
    And I should see text matching "Client Liable"
    Then I click the "Save Edited Media Plan Line" link
    Then I wait for 5000

    # ***PUBLISH MEDIA PLAN***
    When I click the "Publish Media Plan" link
    Then I wait for 1000
    Then I should see "Media Plan published successfully"
    Then I wait for 2000

## ***DELETE CAMPAIGN CLEAN UP***
#    Then I click the "Navigation Header" link
#    Then I click the "Campaigns" link
#    Then I wait for 2000
#    Then I fill in "campaign-search-basic" with "<campaign>"
#    Then I wait for 3000
#    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign |client|owner      |period |budget|clientLiable |initiative|buyType   |supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |planline |google|automation |q4-2015|100000|Client Liable|wildfire  |Direct Buy|Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|
