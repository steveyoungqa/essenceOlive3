@campaign @CI
Feature: P01 - Create new campaign
         Test that the user can create a campaign and Edit.
         OAT-14 - Delete Existing Campaign. Duplicate name check

  Background:

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "steve.automation@gmail.com"
    And I fill in "Passwd" with "Warlock99"
    Then I press "signIn"
    Then I wait for 3000
    Then I should see "Notifications"

  Scenario Outline: Olive 3 Regression Test Pack & Sanity Checks

    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I fill in the "Campaign Search" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox
    Then I wait for 10000

    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I follow "campaign-add"
    Then I wait for 3000

    Then I fill in the "Campaign Name" with "<campaign>"
#    And I fill in "campaign-new-name" with "<campaign>"
    And I fill in "campaign-new-client" with "<client>"
    Then I wait for 5000
    And I fill in "campaign-new-owner" with "<owner>"
    Then I wait for 7000
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link
    Then I wait for 8000

#   Campaign Duplicate Name Check
    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000
    Then I follow "campaign-add"
    Then I wait for 3000
    Then I fill in the "Campaign Name" with "<campaign>"
    And I fill in "campaign-new-client" with "<client>"
    Then I wait for 5000
    And I fill in "campaign-new-owner" with "<owner>"
    Then I wait for 7000
    And I fill in "campaign-new-memo" with "Test Notes"
    Then I wait for 5000
    Then I click the "Campaign Save" link
    Then I should see text matching "Campaign with this Name and Client already exists."

# ***DELETE CAMPAIGN CLEAN UP***
    Then I click the "Navigation Header" link
    Then I wait for 3000
    Then I click the "Campaigns" link
    Then I wait for 3000

    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
    |campaign |client|owner      |
    |campaigns|google|automation |

