@publishing
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
    Then I click the "DBM Advertiser" link
    And I click the "External System Cancel" link
    Then I click the "DS3 Advertiser" link
    And I click the "External System Cancel" link
    And I click the "Google Sub Product" link
    Then I fill in "mapping-externalSystem-googleSubProduct" with "<initiative>"
    Then I wait for 5000
    Then I click the "External System Save" link
  # The above doesnt click External Save - it takes focus off the form dropdown in the previous step
    Then I click the "External System Save" link
    And I should see text matching "You have linked the campaign to Google Sub-Product"

#   ***CREATE MEDIA PLAN***
    Then I wait for xpath "//*[@class='md-header-items']//*[contains(text(),'Media Plans')]" to appear
    Then I click the "Media Plans" link
    Then I follow "campaign-marketbudgets-add"
    Then I wait for 3000
    And I fill in "campaign-marketbudgets-new-label" with "Test Label"
    Then I wait for 2000

#    Then I click the "KPI Type" link
    Then I click the "KPI Type Long Path" link
    Then I click the "KPI DR" link
    Then I wait for 2000

    Then I click the "Add New Period" link
    And I fill in "campaign-marketbudgets-new-periods-new-name" with "<period>"
    Then I click the "New Period Save" link
    Then I wait for xpath "//*[@id='campaign-marketbudgets-new-periods-new-panel-close']" to appear
    And I click the "Close Add Period" link

    Then I fill in "campaign-marketbudgets-new-period" with "<period>"
    Then I wait for 2000
    Then I wait for xpath "//*[@id='campaign-marketbudgets-new-period-<period>']" to appear
    Then I click the link containing ID "<period>"
    Then I wait for 2000

#    Then I click the "Media Plan Market" link
    Then I click the "Market Long Path" link
    Then I wait for 2000
    Then I click the "Market Germany" link

    Then I select a Media Plan Start Date of "2015-04-01"
    Then I wait for 3000
    Then I Select a Media Plan End Date of "2015-04-30"
    Then I wait for 2000

    Then I fill in "campaign-marketbudgets-new-liableEntity" with "<liableEntity>"
    Then I wait for 2000
    Then I click the link containing Text "<liableEntity>"

    And I fill in "campaign-marketbudgets-new-currency" with "EUR"
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
    Then I wait for xpath "//*[@class='button button__label-only']" to appear
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    And I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-line-add']" to appear

    Then I click the "Add Media Plan Line" link
    Then I wait for 2000
    And I click the "Cost Type Media" link
    Then I click the "Line Channel" link
    And I click the "Line Channel Search" link
    Then I click the "Section" link
    And I click the link containing Text "Default"
    Then I wait for 2000
    Then I click the "Supplier" link
    And I fill in the "Supplier" with "<supplier>"
    Then I wait for 2000
    And I click the link containing Text "<supplier>"
    Then I click the "Platform" link
    Then I click the "Platform DS3" link
    Then I wait for 2000
    Then I click the "Property" link
    And I fill in the "Property" with "<property>"
    Then I wait for 2000
    Then I click the link containing Text "<property>"
    Then I wait for 2000
    Then I click the "Media Type" link
    Then I click the link containing Text "<mediaType>"
    Then I wait for 2000
    Then I click the "Cost Model" link
    And I click the link containing Text "<costModel>"
    Then I select a Plan Line Start Date of "2015-04-04"
    Then I wait for 2000
    Then I Select a Plan Line End Date of "2015-04-04"
    Then I wait for 2000

    Then I click the "Line Currency" link
    And I click the link containing Text "<lineCurrency>"
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalNet" with "100000"

#   ***APPLY BUDGET DISCOUNT***

    Then I fill in the "Discount Amount" with "15"
    And I click the "Discount Percentage" link
    And I wait for 2000
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

    Then I click the "Save Media Plan Line" link
    Then I wait for text "Plan line added successfully." to appear
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear

#   ***PUBLISH MEDIA PLAN***
    Then I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-publish']" to appear
    When I click the "Publish Media Plan" link
    And I wait for text "Media Plan Lines published successfully" to appear
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear
    Then I reload the page

#   ***LINK INSERTION ORDER TO DS3***
    Then I wait for xpath "//*[@class='md-header-items']//*[contains(text(),'Insertion orders')]" to appear
    Then I click the "Insertion Order tab" link
    And I wait for xpath "//*[@class='button button__label-only']//*[contains(text(),'View IO')]" to appear
    And I click the "View IO" link
    And I wait for xpath "//*[@class='md-header-items-container']//*[contains(text(),'External platforms')]" to appear
    Then I click the "External Platforms Insertion Order" link
    And I wait for xpath "//*[@id='campaign-marketbudgets-versions-ios-ds3-link']" to appear
    And I click the "Link DS3" link
    And I wait for 2000
    And I fill in "mapping-externalSystem-ds3" with "<ds3>"
    And I wait for 2000
    And I fill in "mapping-externalSystem-ds3" with "<ds3>"
    Then I wait for 8000
    And I click the link containing Text "<ds3>"
    Then I click the "External System Save" link

#   ***MAP SEARCH CAMPAIGN***
    Then I click the "Plan Lines" link
    And I click the "Manage mappings" link
    Then I wait for xpath "//*[@class='custom-checkbox']/span[@class='custom-checkbox__icon icon icon--tick icon--md icon--cropped']" to appear

    Then I Map Search Campaign "<searchCampaign>"
    And I wait for 5000
    And I click the "Save Managed Entities" link
    Then I click the "Close Manage Mapping Panel" link
    And I wait for 3000
    Then I click the "Close Mapped Panel" link
    And I wait for 2000
    Then I click the "Plan tab" link

    Then I click the "Publish Dropdown" link
    And I click the "Published State" link

#   ***REQUEST APPROVAL***
    Then I click the "Request Approval" link
    And I click the "Add Approver" link
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-approvers-add-type" with "Internal"
    Then I wait for 2000
    And I click the "Internal Approver" link
    Then I wait for 2000
    Then I click the "Approver Field" link
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-approvers-add-person" with "<approver>"
    Then I wait for 2000
    Then I click the link containing Text "<approver>"
    Then I wait for 2000
    Then I click the "Save Approver" link
    Then I wait for 2000
    And I click the "Request Approval Confirm" link
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear

#   ***FEEDBACK & APPROVE***
    Then I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-set-status']" to appear
    Then I click the "Set Status" link
    And I fill in the "Feedback Notes" with "Regression Testing feedback test"
    Then I click the "Approve" link

#   ***EDIT FIRST MEDIA PLAN LINE***
    Then I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-editable']" to appear
    Then I click the "Editable Draft State" link
    And I wait for xpath "//*[@class='ng-scope'][1]/td//*[contains(text(),'Edit')]" to appear
    Then I click the "First Plan Line Edit" link
    And I wait for 2000
    Then I click the "Edit Line Currency" link
    And I click the link containing Text "Australian Dollar"
    Then I wait for 2000
    Then I click the "Save Media Plan Line" link
    Then I wait for text "Plan line updated successfully." to appear

#   ***PUBLISH AND ACCEPT BREACH***
    Then I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-publish']" to appear
    When I click the "Publish Media Plan" link
    Then I wait for text "Publishing this media plan you will require further internal approval for the amends you have made" to appear
    And I click the "Continue & Publish" link
    Then I wait for text "Media Plan published successfully" to appear
#    And I wait for text "Amends Published" to appear
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear
#
##   ***DELETE CAMPAIGN CLEAN UP***
#    Then I Maximize the Browser Window
#    And I wait for 2000
#    Then I click the "Navigation Header" link
#    Then I click the "Campaigns" link
#    Then I wait for 3000
#    Then I fill in "campaign-search-basic" with "<campaign>"
#    Then I wait for 3000
#    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign  |client|owner      |region |period |budget|mediaType     |costModel   |lineCurrency |liableEntity |initiative|supplier|property      |ds3 |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |conversionSource|
    |publishing|google|automation |EMEA   |q4-2015|100000|Search Text Ad|Fixed CPM   |British Pound|Essence LON  |wildfire  |Ebuzzing|Google Ireland|2604|Shopping      |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|Google Floodlights|




