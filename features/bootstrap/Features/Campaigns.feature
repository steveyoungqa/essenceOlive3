@campaign
Feature: P01 - Create new campaign
         Test that the user can create a campaign and Edit.
         OAT-14 - Delete Existing Campaign. Duplicate name check

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

#   Campaign Duplicate Name Check
    Then I wait for xpath "//*[@class='menu-close icon icon--med icon--tables']" to appear
    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I follow "campaign-add"
    Then I wait for 3000

    Then I fill in the "Campaign Name" with "<campaign>"
    And I fill in "campaign-new-client" with "<client>"
    Then I wait for 5000
    Then I fill in "campaign-new-managingRegion" with "EMEA"
    And I wait for 5000
    And I fill in "campaign-new-owner" with "<owner>"
    And I wait for xpath "//*[@id='campaign-new-owner-steve-automation']" to appear
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link
    Then I should see text matching "Campaign with this Name and Client already exists."

# ***DELETE CAMPAIGN CLEAN UP***
    Then I Maximize the Browser Window
    And I wait for 2000
    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign |client|owner      |region|
    |campaigns|google|automation |EMEA  |

