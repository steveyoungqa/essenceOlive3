@planlines
Feature: Olive 3 Regression Pack
  Create new campaign, Add Media Plan, Add Media Plan Line & Service
  OAT-99, OAT-111, OAT-62

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock99"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks
# ***CREATE CAMPAIGN***
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"

    Then I fill in the "Campaign Search" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox
    Then I wait for 5000

    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
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

# ***LINK TO EXTERNAL PLATFORM***
    Then I click the "External Platforms Market Level" link
    And I click the "Google Sub Product" link
    Then I fill in "mapping-externalSystem-googleSubProduct" with "Wildfire - E15"
    Then I wait for 5000
    Then I click the "External System Save" link
     # The above link doesnt click External Save - it takes focus off the form dropdown in the previous step
    Then I click the "External System Save" link
    Then I wait for 5000

# ***CREATE MEDIA PLAN***

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

# ***LINK TO GOOGLE INITIATIVE***
    Then I click the "External Platforms Post Create Plan" link
    Then I click the "Link Google Initiative" link
    Then I fill in "mapping-externalSystem-googleInitiative" with "<initiative>"
    Then I wait for 2000
    Then I click the link containing ID "<initiative>"
    Then I click the "Save Mapped Account" link
    Then I wait for 10000


# ***ADD MEDIA PLAN LINE**
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
    Then I wait for 3000
    Given I select Edit for the existing Campaign "<campaign>"
    Then I wait for 5000
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    Then I wait for 5000

    Then I click the "Add Media Plan Line" link
    Then I wait for 2000
    Then I click the "Line Cost Type" link
    And I click the "Cost Type Media" link
   
    Then I click the "Buy Type" link
    Then I wait for 2000
    Then I should see text matching "Programmatic - PMP"
    Then I should see text matching "Programmatic - Preferred deal"
    Then I should see text matching "Programmatic - Open Exchange"
    Then I should see text matching "Programmatic - Guaranteed"
    Then I should see text matching "Biddable"
    Then I should see text matching "Direct Buy"
    And I fill in the "Buy Type" with "<buyType>"
    Then I wait for 2000

    Then I click the "Line Channel" link
    And I fill in the "Line Channel" with "Display"
    Then I wait for 2000
#    And I click the "Line Channel Search" link
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
    Then I wait for 2000
    Then I should see text matching "Link / text ad"
    Then I should see text matching "Text & image ad"
    Then I should see text matching "Expandable banner"
    Then I should see text matching "Lightbox"
    Then I should see text matching "Synced Roadblock"
    Then I should see text matching "Overlay"
    Then I should see text matching "Bespoke takeover"
    Then I should see text matching "Advertorial"
    Then I should see text matching "Interstitial"


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
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalNet" with "100"
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

    Then I click the "Save Media Plan Line" link
    Then I wait for 5000

# ***ADD 2ND MEDIA PLAN LINE **
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
    Then I wait for 3000
    Given I select Edit for the existing Campaign "<campaign>"
    Then I wait for 5000
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    Then I wait for 5000

    Then I click the "Add Media Plan Line" link
    Then I wait for 2000
    Then I click the "Line Cost Type" link
    And I click the "Cost Type Media" link

    Then I click the "Buy Type" link
    Then I wait for 2000
    And I fill in the "Buy Type" with "<buyType>"
    Then I wait for 2000
    Then I click the "Line Channel" link
    And I fill in the "Line Channel" with "Display"
    Then I wait for 2000
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


# ***DELETE CAMPAIGN CLEAN UP***
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
    Then I wait for 2000
    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign |client|owner      |period |budget|clientLiable |initiative|buyType   |supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |planline |google|automation |q4-2015|100000|Client Liable|wildfire  |Direct Buy|Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




