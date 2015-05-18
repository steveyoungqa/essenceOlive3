@individual
Feature: Breach Scenarios
  OTD-1914 Individual IO Approval

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Regression1000"
    Then I press "signIn"

  Scenario Outline: Individual IO Approval

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
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalGross" with "100000"

#   ***APPLY BUDGET DISCOUNT***
    Then I click the "Discount Applied" checkbox
    And I wait for 2000
    And I click the "Discount Amount Tab" link
    Then I fill in the "Discount Amount" with "50"
    And I wait for 2000
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"
#    Then I click the "Add Another" checkbox
    Then I click the "Save Media Plan Line" link
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear

    # ***ADD 2ND MEDIA PLAN LINE **
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
    Then I fill in "campaign-marketbudgets-versions-lines-new-totalGross" with "100000"

#   ***APPLY BUDGET DISCOUNT***
    Then I click the "Discount Applied" checkbox
    And I wait for 2000
    And I click the "Discount Amount Tab" link
    Then I fill in the "Discount Amount" with "50"
    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "<description2>"

    Then I click the "Save Media Plan Line" link
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear

#   ***PUBLISH INDIVIDUAL LINE***
    Then I wait for xpath "//*[@id='campaign-marketbudgets-mediaplan-publish']" to appear
    Then I should not see text matching "Publish Selected"
    Then I select Media Plan Line checkbox with a description of "PublishMeOnly"
    And I wait for 5000
    When I click the "Publish Selected" link
    Then I wait for 2000
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear
    Then I click the "Publish Dropdown" link
    And I click the "Published State" link
    Then I should see text matching "<description2>"



  Examples:
    |campaign  |client|owner      |region |period |budget|clientLiable |initiative|supplier      |description2 |>ds3 |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |individual|google|automation |EMEA   |q4-2015|100000|Client Liable|wildfire  |Google Ireland|PublishMeOnly|2604|Shopping      |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|




