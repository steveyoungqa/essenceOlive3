Feature: Client Portal

Scenario: Client logs in
  Given Client approval was requested
    And Client approver has received a notificafiton email with a lilnk to the media plan
    And Client is not logged in Olive 3
  When Client clicks on the link
  Then He is taken to Olive 3 login page
    And he can log in with his google account

Scenario: Client views a list of plans under a campaign
  Given Client approver has received many Plan approval requests
  When they follow one of those links
  Then they can navigate to Campaign of that plan
    And Plans for which client approval has been requested
    And Clicking on the name of any plan takes them to details of the latest version for which client approval was requested


Scenario: Client views plan that he is to approve / reject
  Given
  When 
  Then Default grouping of lines is: Section, IO, Channel
    And Insertion Orders are collapsed by default
    And IO name doesn't appear in the columns
    And Additional column for Budget in Client currency is visible
    And individual plan line dates are hidden from view
    And there are no other actions on lines (no checkboxes / no edit links)
    And Spend column isn't visible (there shouldn't be any spend)
    And

Scenario: Client views approved plan

Scenario: Client views a list of campaigns
  Given Client has loged in Olive
  When they navigate to Campaign management
  Then they see list of all Campaigns for the Client in which there are plans they can access
