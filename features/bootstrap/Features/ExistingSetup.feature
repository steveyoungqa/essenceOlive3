@existing
Feature: Perform tests upon an Existing Setup
  Tests upon an Existing Campaign, Media Plan, Plan Line

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I wait for xpath "//*[@id='Email']" to appear
    And I fill in "Email" with "steve.automation@gmail.com"
    And I wait for xpath "//*[@id='Passwd']" to appear
    And I fill in "Passwd" with "Regression1000"
    Then I press "signIn"

  Scenario Outline: Tests upon Existing Campaign
# ***ACCESS EXISTING CAMPAIGN**
    Then I click the "Navigation Header" link
    Then I click the "Campaigns" link
    Then I wait for 5000
    Given I select Edit for the existing Campaign "<campaign>"
    Then I wait for 5000

# ***ACCESS EXISTING MEDIA PLAN**
    Then I click the "Media Plan Whole Column" link
    Then I wait for 5000
    And I select the Media Plan linked to Campaign of "<campaign>"
    Then I wait for 5000

##   ***ADD MEDIA PLAN LINE**
#    Then I click the "Add Media Plan Line" link
#    Then I wait for 2000
#    And I click the "Cost Type Media" link
#    Then I click the "Line Channel" link
#    And I click the "Line Channel Search" link
#    Then I click the "Section" link
#    And I click the link containing Text "Default"
#    Then I wait for 2000
#    Then I click the "Supplier" link
#    And I click the link containing Text "<supplier>"
#    Then I click the "Platform" link
#    Then I click the "Platform DS3" link
#    Then I wait for 2000
#    And I fill in the "Property" with "<property2>"
#    And I fill in the "Property" with "<property2>"
#    And I wait for 2000
#    Then I click the "Media Type" link
#    And I click the link containing Text "Search Text Ad"
#    Then I wait for 2000
#    Then I click the "Cost Model" link
#    And I click the link containing Text "Biddable CPC"
#    Then I select a Plan Line Start Date of "2015-04-04"
#    Then I wait for 2000
#    Then I Select a Plan Line End Date of "2015-04-04"
#    Then I wait for 2000
#
#    Then I click the "Line Currency" link
#    And I click the link containing Text "British Pound"
#    Then I fill in "campaign-marketbudgets-versions-lines-new-totalGross" with "100000"
#    Then I wait for 2000
#    And I fill in "campaign-marketbudgets-versions-lines-new-description" with "<line2>"
#    Then I click the "Save Media Plan Line" link
#    Then I reload the page
#    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear


    #***EDIT FIRST MEDIA PLAN LINE***
    Then I click the "Third Plan Line Edit" link
    And I wait for 2000
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-medialines-indicativeProperty" with "<property1>"
   And I fill in "campaign-marketbudgets-versions-medialines-indicativeProperty" with "<property1>"
#    And I fill in the "Property Edit" with "<property1>"
    Then I wait for 2000
    And I fill in "campaign-marketbudgets-versions-medialines-description" with "<line2update>"
    And I wait for 2000
    Then I click the "Save Media Plan Line" link
    Then I reload the page
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear




  Examples:
    |campaign  |client|owner      |region |period |budget|clientLiable |initiative|property1|property2|supplier      |line1       |line2      |line3      |line2update              |>ds3 |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
    |individual|google|automation |EMEA   |q4-2015|100000|Client Liable|wildfire  |YouTube  |GDN      |Google Ireland|YouTubeDraft|GDN1Publish|GDN2Publish|Line 2 Changed to YouTube|2604|Shopping      |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|



