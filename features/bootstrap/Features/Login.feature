@login
Feature: Test Olive 3 Login

  Scenario Outline: Login Scenarios

    Given I am on "/login"
    Then I press "Sign in with Google"
    And I wait for xpath "//*[@id='Email']" to appear
    And I fill in "Email" with "steve.automation@gmail.com"
    Then I press "signIn"
    And I wait for xpath "//*[@id='Passwd']" to appear
    And I fill in "Passwd" with "Regression1000"
    Then I press "Sign in"
    And I Maximize the Browser Window
    Then I wait for 3000
    Given I wait for text "Notifications" to appear
    And I should see "Notifications"
    And I wait for css element "#root-content > section.content-main.ng-scope > div > section > div.tasklist__controller > h1" to appear
    And I wait for xpath "//*[@class='header__logo']" to appear

  Examples:
    |user                      |pass          |
    |steve.automation@gmail.com|Regression1000|

