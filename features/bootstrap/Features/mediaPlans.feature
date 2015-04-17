@mediaplans @CI
Feature: Olive 3 Media Plan Creation
         OAT-1894

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock99"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: Create Media Plan Standalone Test
# ***CREATE CAMPAIGN***
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
    Then I wait for 2000

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
    Then I wait for 7000
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link
    Then I wait for 5000

# ***LINK TO EXTERNAL PLATFORM***
    Then I click the "External Platforms Market Level" link
    And I click the "Google Sub Product" link
    Then I fill in "mapping-externalSystem-googleSubProduct" with "AdWords - A01 (Acquisition)"
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
    Then I should see an "Use Olive 2 MAFs" X-Path element
    Then I click the "Use Olive 2 MAFs" checkbox
    Then I click the "Media Plan Long Save" link
    Then I wait for 5000
    Then I should see text matching "true"

# ***DELETE CAMPAIGN CLEAN UP***
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
    Then I wait for 3000
    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign |client|owner      |period |budget|clientLiable |
    |mediaplan|google|automation |q4-2015|100000|Client Liable|
