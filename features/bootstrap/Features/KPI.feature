@kpi @CI
Feature: Olive 3 Regression Pack
  Default KPI Tests

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
    Then I wait for 3000
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
    Then I wait for 8000

# ***ADD KPI***
    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
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

    Then I click the "Navigation Header" link
    Then I follow "Campaigns"
    Then I wait for 3000
    Then I fill in "campaign-search-basic" with "<campaign>"
    Then I wait for 3000
    Then I select the Delete "<campaign>" checkbox

  Examples:
  |campaign|client|owner      |period |budget|clientLiable |initiative|supplier      |ds3            |searchCampaign|approver   |conversion        |activity         |tag       |ds3Advert                    |
  |kpi     |google|automation |q4-2015|100000|Client Liable|engage    |Google Ireland|700000001004851|Madrid        |Steve Young|Post Click Revenue|Enterprise - Apps|Begin Here|Chromecast B2C - Essence EMEA|
