@untracked
Feature: OAT-2 Untracked Spend
         UNTRACKED SPEND ONLY WORKS ON STAGING ENVIRONMENT

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock1990"
    Then I press "signIn"
    Then I wait for 5000
    Then I should see "Notifications"

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks

#   ***CREATE CAMPAIGN***
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in the "Campaign Search" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox
    Then I wait for 5000

    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I follow "campaign-add"
    Then I wait for 3000

    And I fill in "campaign-new-name" with "<campaign>"
    And I fill in "campaign-new-client" with "<client>"
    Then I wait for 5000
    And I fill in "campaign-new-owner" with "<owner>"
    Then I wait for 9000
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link
    Then I wait for 8000

#   ***LINK TO EXTERNAL PLATFORM***
    Then I click the "External Platforms Market Level" link
    And I click the "Google Sub Product" link
    Then I fill in "mapping-externalSystem-googleSubProduct" with "Wildfire - E15"
    Then I wait for 5000
    Then I click the "External System Save" link
  # The above doesnt click External Save - it takes focus off the form dropdown in the previous step
    Then I click the "External System Save" link
    Then I wait for 5000

#   ***CREATE MEDIA PLAN***
    Then I click the "Media Plans" link
    Then I follow "campaign-marketbudgets-add"
    Then I wait for 3000
    And I fill in "campaign-marketbudgets-new-label" with "Test Label"
    Then I wait for 2000

    Then I click the "KPI Type Long Path" link
    Then I click the "KPI Brand" link
    Then I wait for 2000

    Then I click the "Add New Period" link
    And I fill in "campaign-marketbudgets-new-periods-new-name" with "<period>"
    Then I click the "New Period Save" link
    And I click the "Close Add Period" link

    Then I fill in "campaign-marketbudgets-new-period" with "<period>"
    Then I wait for 2000
    Then I click the link containing ID "<period>"
    Then I wait for 2000

    Then I click the "Market Long Path" link
    Then I wait for 2000
    Then I click the "Market USA" link

    Then I select a Media Plan Start Date of "2015-04-01"
    Then I wait for 3000
    Then I Select a Media Plan End Date of "2015-04-30"
    Then I wait for 2000

    Then I fill in "campaign-marketbudgets-new-liableEntity" with "<clientLiable>"
    Then I wait for 2000
    Then I click the link containing Text "<clientLiable>"

    And I fill in "campaign-marketbudgets-new-currency" with "GBP"
    Then I wait for 2000
    Then I fill in "campaign-marketbudgets-new-budget" with "<budget>"
    Then I wait for 2000

    And I fill in "campaign-marketbudgets-new-owner" with "<owner>"
    Then I wait for 2000
    Then I click the link containing ID "<owner>"

    Then I click the "Media Plan Long Save" link
    Then I wait for 5000

#   ***LINK TO GOOGLE INITIATIVE***
    Then I click the "External Platforms Post Create Plan" link
    Then I click the "Link Google Initiative" link
    Then I fill in "mapping-externalSystem-googleInitiative" with "<initiative>"
    Then I wait for 2000
    Then I click the link containing ID "<initiative>"
    Then I click the "Save Mapped Account" link
    Then I wait for 10000
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
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
    Then I select a Plan Line Start Date of "2015-04-01"
    Then I wait for 2000
    Then I Select a Plan Line End Date of "2015-04-30"
    Then I wait for 2000

    Then I click the "Line Currency" link
    And I click the link containing Text "British Pound"
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalGross" with "100000"
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

    Then I click the "Save Media Plan Line" link
    Then I wait for 5000

#   ***PUBLISH MEDIA PLAN***
    When I click the "Publish Media Plan" link
    Then I wait for 3000
    Then I should see "Media Plan published successfully"
    Then I wait for 2000

#   ***LINK INSERTION ORDER TO DS3***
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

#   ***EDIT FIRST MEDIA PLAN LINE***
    Then I click the "Editable Draft State" link
    Then I wait for 5000
    Then I click the "First Plan Line Edit" link
    And I wait for 2000
    Then I Select a Plan Line End Date of "2015-04-01"
    Then I wait for 2000

    Then I wait for 2000
    Then I click the "Save Edited Media Plan Line" link
    Then I wait for 5000

    Then I click the "Olive Header Logo" link
    And I wait for 2000
    Then I click the "Campaign Tasks Notification" link
    Then I follow "Go"
    And I should see text matching "<ds3>"


##   ***DELETE CAMPAIGN CLEAN UP***
#    Then I click the "Navigation Header" link
#    Then I click the "Campaigns" link
#    Then I wait for 3000
#    Then I fill in "campaign-search-basic" with "<campaign>"
#    Then I wait for 3000
#    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign  |client|owner      |period |budget|clientLiable |initiative|supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |untracked |google|automation |q4-2015|100000|Client Liable|wildfire  |Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




