@planlines
Feature: Olive 3 Regression Pack
  Create new campaign, Add Media Plan, Add Media Plan Line & Service
  OAT-99, OAT-111, OAT-62, OAT-72, OAT-102, OAT-28, OAT-17, OTD-1908

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
    Then I fill in "campaign-new-managingRegion" with "<region>"
    And I wait for 5000
    And I fill in "campaign-new-owner" with "<owner>"
    And I wait for xpath "//*[@id='campaign-new-owner-steve-automation']" to appear
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link

#   ***LINK TO EXTERNAL PLATFORM***
    And I wait for xpath "//*[contains(text(),'External platforms')]" to appear
    Then I click the "External Platforms Market Level" link
    And I click the "Google Sub Product" link
    Then I fill in "mapping-externalSystem-googleSubProduct" with "Wildfire - E15"
    Then I wait for 5000
    Then I click the "External System Save" link
  # The above doesnt click External Save - it takes focus off the form dropdown in the previous step
    Then I click the "External System Save" link

#   ***CREATE MEDIA PLAN***
    Then I wait for xpath "//*[@class='md-header-items']//*[contains(text(),'Media Plans')]" to appear
    Then I click the "Media Plans" link
    Then I follow "campaign-marketbudgets-add"
    Then I wait for 3000
    And I fill in "campaign-marketbudgets-new-label" with "Test Label"
    Then I wait for 2000

#    Then I click the "KPI Type" link
    Then I click the "KPI Type Long Path" link
    Then I click the "KPI Brand" link
    Then I wait for 2000

    Then I click the "Add New Period" link
    And I fill in "campaign-marketbudgets-new-periods-new-name" with "<period>"
    Then I click the "New Period Save" link
    And I click the "Close Add Period" link

    Then I fill in "campaign-marketbudgets-new-period" with "<period>"
    And I wait for text "<period>" to appear
    Then I wait for 2000
    Then I click the link containing ID "<period>"
    Then I wait for 2000

#    Then I click the "Media Plan Market" link
    Then I click the "Market Long Path" link
    Then I wait for 2000
    Then I click the "Market USA" link

    Then I select a Media Plan Start Date of "2015-04-01"
    Then I wait for 3000
    Then I Select a Media Plan End Date of "2015-04-30"
    Then I wait for 2000

    Then I fill in "campaign-marketbudgets-new-liableEntity" with "<liableEntity>"
    Then I wait for 2000
    Then I click the link containing Text "<liableEntity>"

    And I fill in "campaign-marketbudgets-new-currency" with "GBP"
    Then I wait for 2000
    Then I fill in "campaign-marketbudgets-new-budget" with "<budget>"
    Then I wait for 2000

    And I fill in "campaign-marketbudgets-new-owner" with "<owner>"
    Then I wait for 2000
    Then I click the link containing ID "<owner>"

#    Then I click the "Media Plan Save" link
    Then I click the "Media Plan Long Save" link

#   ***LINK TO GOOGLE INITIATIVE***
    And I wait for xpath "//*[contains(@class,'active--panel')]//*[contains(text(),'External platforms')]" to appear
    Then I click the "External Platforms Post Create Plan" link
    Then I click the "Link Google Initiative" link
    Then I fill in "mapping-externalSystem-googleInitiative" with "<initiative>"
    Then I wait for 2000
    Then I click the link containing ID "<initiative>"
    Then I click the "Save Mapped Account" link
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Given I select Edit for the existing Campaign "<campaign>"

#   ***ADD MEDIA PLAN LINE**
    Then I wait for xpath "//*[@class='ng-scope']/div[@class='ng-scope']/ol-list[@class='ng-isolate-scope']/table[@class='standard-table table__records-editable']/tbody[@class='ng-scope']//*[@class='ol-list-item ol-drag-preview ng-scope']" to appear
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    And I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-line-add']" to appear
    Then I click the "Add Media Plan Line" link
    Then I wait for 2000
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
    Then I click the "Section" link
    Then I wait for 2000
    Then I double click the "Section Edit" link
    Then I wait for 2000
    Then I fill in the "Section Edit Input" with "Custom Section"
    Then I wait for 2000
    And I click the "Confirm Section Edit" link
    Then I wait for 2000
    Then I click the "Supplier" link
    And I click the link containing Text "<supplier>"
    Then I should see text matching "<liableEntity>"
    Then I click the "Platform" link
    Then I click the "Platform DS3" link
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

#   ***APPLY BUDGET DISCOUNT***

    Then I fill in the "Discount Amount" with "50"
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

    Then I click the "Save Media Plan Line" link
    Then I wait for text "Plan line added successfully." to appear
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear

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
    Then I wait for 2000
    Then I click the "Supplier" link
    Then I wait for 2000
    Then I fill in the "Supplier" with "<supplier>"
    Then I wait for 2000
    Then I click the "Platform" link
    Then I click the "Platform DS3" link
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
    And I fill in the "Plan Line Description" with "<description2>"
    Then I click the "Save Media Plan Line" link
    Then I wait for text "Plan line added successfully." to appear
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear


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
    Then I click the "Save Media Plan Line" link
    Then I wait for text "Plan line added successfully." to appear

# ***PUBLISH MEDIA PLAN***
    Then I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-publish']" to appear
    When I click the "Publish Media Plan" link
    And I wait for text "Media Plan published successfully." to appear
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear

#   DELETE PLAN LINES
    Then I click the "Editable Draft State" link
    Then I wait for 2000
    Then I delete Media Plan Line with a description of"<description2>"

# ***DELETE CAMPAIGN CLEAN UP***
    Then I Maximize the Browser Window
    And I wait for 2000
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign      |client|owner      |region |period |budget|liableEntity |initiative|buyType   |supplier      |description1|description2|ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |planlinetests |google|automation |EMEA   |q42015 |100000|Client Liable|wildfire  |Direct Buy|Google Ireland|Plan Line 1 |Plan Line 2 |700000001004851|Madrid        |Steve Automation |Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




