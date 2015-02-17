@bbc
Feature: Visit the BBC Page
  Choose a Section, then a sub-section
  Filter down to a favourite
  This feature uses an Example tables, Custom Contexts, Arrays and x-Paths

Scenario Outline: Filter down to Crystal Palace

    Given I am on the "<home>" page
    And I select the "<section>" section
    Then I select the "<sport>" Sport section
    And I select the Tables section
    Then I choose my favourite team "<team>"


  Examples:
  |home                  |section|sport   |team          |
  |http://www.bbc.co.uk/ |Sport  |Football|Crystal Palace|