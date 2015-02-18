@mink
Feature: As a team user of Hive
  I want to be able to login
  So that I can access the site
  This feature uses an Example Table, MinkContext and CSS locators
  No # is need in front of the CSS locators when using MinkContext

Scenario Outline: Basic Login

    Given I am on "<home>"
    When I fill in "name" with "<Username>"
    And I fill in "pass" with "<Password>"
    Then I press "login-submit"

  Examples:
  |home                        |Username        |Password|
  |http://www.brand.orange.com |kirsty_anderson |K869730a|