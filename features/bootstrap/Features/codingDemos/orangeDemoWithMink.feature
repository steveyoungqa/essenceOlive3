@mink
Feature: As a team user of Hive
  I want to be able to login
  So that I can access the site
  This feature uses an Example Table, MinkContext and CSS locators
  No # is need in front of the CSS locators when using MinkContext

Scenario Outline: Basic Login

    Given I am on "/"
    When I fill in "name" with "<Username>"
    And I fill in "pass" with "<Password>"
    Then I press "login-submit"

  Then I click the "#fancybox-close" link
#  Then I follow "fancybox-close"
#  The above Mink step definition is not working TBC - using customTest instead





#  Then I fill in "searchHolder > form > input.k" with "london"
#    And I fill in "#searchHolder > form > input.k" with "<Search>"
#   Then I click the "#searchHolder > form > input.btn.btn-search" link
#    Then I click the "#f-region-search > div > div:nth-child(8) > a" link
#    Then I select the "#search_filter_40_262" checkbox




  Examples:
  |home                        |Username        |Password|Search|
  |http://www.brand.orange.com |kirsty_anderson |K869730a|london|