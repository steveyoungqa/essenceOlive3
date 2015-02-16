@olive
Feature: Using Mink Context Properly

  Scenario Outline: Test that checks if media and service plan lines can be added to a media plan

     Given I am on "/login"
     Then I press "Sign in with Google"
#     Then I wait for 5000
     And I fill in "Email" with "<user>"
     And I fill in "Passwd" with "<pass>"
     Then I press "signIn"
#     Then I wait for 5000
     Then I should see "Notifications"
     Then I click on the Navigation header
     Then I follow "Campaigns"
     Then I wait for 3000
     Then I follow "campaign-add"
    Then I wait for 3000

     And I fill in "campaign-new-name" with "<campaign>"
#     Then I select "<client>" from "campaign-new-client"
#     And I select "<owner>" from "campaign-new-owner"
#    Then I wait for 10000


  Examples:
    |user                      |pass        |campaign |searchCampaign |ds3advert      |line  |line2  |service  |channel|section |supplier      |platform |property|adUnit        |costModel   |client     |owner    |memo              |period  |contact |mapping | subproduct                 |label     |market|start     |end       |entity       |currency|budget|budget2 |budget3  |managed     |description|external|existing    |id             |external2|initiative|category|approver   |comments              |event     |conversion         |activity          |tag                                                          |weighting|
    |steve.automation@gmail.com|Warlock99   |Behat    |Madrid         |chromecast emea|Media |Service|adserving|search |default |Google Ireland|DS3      |Google  |Search Text Ad|Biddable CPC|google     |zanete   |test memo comments|q42014  |greg    |google  | AdWords - A01 (Acquisition)|label test|US    |2014-01-01|2014-05-07|CLIENT       |GBP     |20000 |2500    |2500     |Steve Young |test text  |google  |consultium  |700000001004851|DS3      |engage    |Internal|Steve Young|Feedback Comments Test|automation|Post Click Revenue |Enterprise - Apps |1026481_158189_7 Enterprise - Maps - Contact Form Transport  |10       |

#   Line: Media, Service
#   Service Type: adserving, agency, creative, legal, research, management, testing , external, technology, verification, misc
#   Channel: search
#   Section: default
#   Supplier: Google Ireland,
#   Property: Google, Bing, Yandex,Baidu
#   Ad Unit: Audio Ad 10,
#   Cost Model: Biddable CPC,
#   Currency: GBP, Euro
