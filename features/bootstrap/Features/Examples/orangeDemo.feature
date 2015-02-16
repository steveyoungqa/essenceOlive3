@orange
Feature: As a team user of Hive
  I want to be able to login
  So that I can access the site
  This feature uses No Example Table, Custom Contexts, Arrays and CSS locators

Scenario: Basic Login not using Mink Context

    Given I am on the "http://www.brand.orange.com" page

    And I fill in the "#name" field with "kirsty_anderson"
    And I fill in the "#pass" field with "K869730a"
    Then I click the "#login-submit" link
    Then I click the "#fancybox-close" link
    And I fill in the "#searchHolder > form > input.k" field with "london"
    Then I click the "#searchHolder > form > input.btn.btn-search" link
    Then I click the "#f-region-search > div > div:nth-child(8) > a" link
    Then I select the "#search_filter_40_262" checkbox


