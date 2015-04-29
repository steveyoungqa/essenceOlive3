Feature: Client Portal

Scenario: Client logs in
  Given Client approval was requested
    And Client approver has received a notificafiton email with a lilnk to the media plan
    And Client is not logged in Olive 3
  When Client clicks on the link
  Then He is taken to Olive 3 login page
    And he can log in with his google account
