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
    And I click the link containing Text "DS3"
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
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalGross" with "10"
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

    Then I click the "Save Media Plan Line" link
    Then I wait for 5000

#   ***PUBLISH MEDIA PLAN***
    When I click the "Publish Media Plan" link
    Then I wait for 3000
    Then I should see "Media Plan published successfully"
    Then I wait for 2000

    ***LINK INSERTION ORDER TO DS3***
    Then I click the "Insertion Order tab" link
    Then I wait for 4000
    And I click the "View IO" link
    Then I click the "External Platforms Insertion Order" link
    And I click the "Link DS3" link
    And I fill in "mapping-externalSystem-ds3" with "<ds3>"
    Then I wait for 8000
    And I click the link containing Text "<ds3>"
    Then I click the "External System Save" link

#   ***MAP SEARCH CAMPAIGN***
    Then I click the "Plan Lines" link
    And I click the "Manage mappings" link
    Then I wait for 15000

    Then I Map Search Campaign "<searchCampaign>"
    And I click the "Save Managed Entities" link
    Then I wait for 3000

    Then I click the "Close Mapped Panel" link
    Then I click the "Plan tab" link

    Then I click the "Publish Dropdown" link
    And I click the "Published State" link

#   ***REQUEST APPROVAL***
    Then I click the "Manage Approval" link
    And I click the "Add Approver" link
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-approvers-add-type" with "Internal"
    Then I wait for 2000
    Then I click the "Approver Field" link
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-approvers-add-person" with "<approver>"
    Then I wait for 2000
    Then I click the link containing Text "<approver>"
    Then I wait for 2000
    Then I click the "Save Approver" link
    Then I wait for 2000
    And I click the "Request Approval" link
    Then I wait for 2000

#   ***FEEDBACK & APPROVE***
    Then I click the "Set Status" link
    And I fill in the "Feedback Notes" with "Regression Testing feedback test"
    Then I click the "Approve" link

#   ***EDIT FIRST MEDIA PLAN LINE***
    Then I click the "Editable Draft State" link
    Then I wait for 2000
    Then I click the "First Plan Line Edit" link
    And I wait for 2000
    Then I click the "Edit Line Currency" link
    And I click the link containing Text "Australian Dollar"
    Then I wait for 2000
    Then I click the "Save Edited Media Plan Line" link
    Then I wait for 5000

#   ***PUBLISH AND ACCEPT BREACH***
    When I click the "Publish Media Plan" link
    Then I wait for 3000
    Then I should see "Publishing this media plan you will require further internal approval for the amends you have made"
    And I click the "Continue & Publish" link
    Then I wait for 2000
    Then I should see "Media Plan published successfully"
    Then I wait for 3000
    And I should see "Amends Published"

#   ***ADD KPI***
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 2000
    Given I select Edit for the existing Campaign "<campaign>"
    And I click the "Default KPIs" link
    Then I click the "Add KPI" link
    Then I wait for 2000
    And I fill in the "KPI Event Type" with "Brand"
    Then I wait for 2000
    And I fill in the "KPI Event Number" with "20"
    And I fill in the "KPI Event Name" with "Regression Event"
    Then I click the "Conversion Source Field" link
    Then I click the link containing Text "Google Floodlights"
    And I click the "Event Save" link
    And I wait for 3000
    Then I click the "Add Tag" link
    And I click the "Conversion Type" link
    And I fill in the "Conversion Type" with "<conversion>"
    And I click the link containing Text "<conversion>"
    Then I wait for 5000
    And I click the "Activity Category" link
    And I fill in the "Activity Category" with "<activity>"
    And I click the link containing Text "<activity>"
    And I click the "Activity Tag" link
    And I fill in the "Activity Tag" with "<tag>"
    Then I wait for 3000
    And I click the link containing Text "<tag>"
    Then I fill in the "Weighting" with "10"
    And I click the "Tag Save" link

#   ***TRACKING MANAGEMENT***
    Then I click the "Navigation Header" link
    Then I click the "Tracking Management" link
    And I click the "Tracking Code Search Box" link
    Then I fill in the "Tracking Code Search Box" with "<searchCampaign>"
    Then I wait for 3000
    And I click the "Advanced Filter" link
    Then I wait for 2000
    Then I click the "DS3 Advertiser Filter" link
    And I fill in the "DS3 Advertiser Filter" with "<ds3Advert>"
    Then I wait for 2000
    Then I click the link containing Text "<ds3Advert>"
    And I click the "Advanced Search Close" link
    Then I click the "Tracking Details" link
    Then I should see "MAPPED"

#   ***DELETE CAMPAIGN CLEAN UP***
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign  |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |existing|google|automation |q4-2015|100000|Client Liable|wildfire  |Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|


