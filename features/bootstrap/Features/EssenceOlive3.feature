@olive
Feature: Using Mink Context Properly

  Scenario Outline: Test that checks if media and service plan lines can be added to a media plan

     Given I am on "/login"
     Then I press "Sign in with Google"
     And I fill in "Email" with "<user>"
     And I fill in "Passwd" with "<pass>"
     Then I press "signIn"
     Then I wait for 3000
#     Then I should see "Notifications"
#     Then I click the "Navigation Header" link
#     Then I follow "Campaigns"
#     Then I wait for 3000
#     Then I follow "campaign-add"
#     Then I wait for 3000
#
#     And I fill in "campaign-new-name" with "<campaign>"
#     And I fill in "campaign-new-client" with "<client>"
#     Then I wait for 5000
#     And I fill in "campaign-new-owner" with "<owner>"
#     Then I wait for 5000
#     And I fill in "campaign-new-memo" with "Test Notes"
#     Then I wait for 5000
#     Then I click the "Save" link
#     Then I wait for 5000
#
     Then I click the "Navigation Header" link
     Then I follow "Campaigns"

     Then I fill in "campaign-search-basic" with "<campaign>"
     Then I wait for 3000
     Then I select the "<campaign>" checkbox
     Then I wait for 3000
     Then I click the "Delete" link
     Then I wait for 5000
     Then I click the "Delete Yes" link
     Then I wait for 10000


  Examples:
    |user                      |pass        |campaign |client|owner      |searchCampaign |ds3advert      |line  |line2  |service  |channel|section |supplier      |platform |property|adUnit        |costModel   |memo              |period  |contact |mapping | subproduct                 |label     |market|start     |end       |entity       |currency|budget|budget2 |budget3  |managed     |description|external|existing    |id             |external2|initiative|category|approver   |comments              |event     |conversion         |activity          |tag                                                          |weighting|
    |steve.automation@gmail.com|Warlock99   |Behat    |google|Steve Young|Madrid         |chromecast emea|Media |Service|adserving|search |default |Google Ireland|DS3      |Google  |Search Text Ad|Biddable CPC|test memo comments|q42014  |greg    |google  | AdWords - A01 (Acquisition)|label test|US    |2014-01-01|2014-05-07|CLIENT       |GBP     |20000 |2500    |2500     |Steve Young |test text  |google  |consultium  |700000001004851|DS3      |engage    |Internal|Steve Young|Feedback Comments Test|automation|Post Click Revenue |Enterprise - Apps |1026481_158189_7 Enterprise - Maps - Contact Form Transport  |10       |



