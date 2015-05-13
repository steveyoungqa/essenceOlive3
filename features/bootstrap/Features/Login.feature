@login
Feature: Test Olive 3 Login

  Scenario Outline: Login Scenarios


    Given I am on "/login"
    Then I press "Sign in with Google"
    And I fill in "Email" with "<user>"
    And I fill in "Passwd" with "<pass>"
    Then I press "signIn"
    Then I wait for 3000
    Given I wait for text "Notifications" to appear
    And I should see "Notifications"
    And I wait for css element "#root-content > section.content-main.ng-scope > div > section > div.tasklist__controller > h1" to appear
    And I wait for xpath "//*[@class='header__logo']" to appear

  Examples:
    |user                      |pass          |
    |steve.automation@gmail.com|Regression1000|