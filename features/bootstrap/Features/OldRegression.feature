@delete
Feature: Using Mink Context Properly

  Scenario Outline:

    And I choose a DS3 Advertiser of "<ds3advert>"

    Then I close the Advanced Search Filter

    Then I select the detail page for the "<searchCampaign>"

    Then a check is made that the Status is MAPPED

    Then I click on the Navigation header
    Then I select Campaign
    Then I search for Campaign "<campaign>"
    Then I select Delete Campaign "<campaign>"
    And I choose Yes to Delete

  Examples:
    |environment|user                          |pass        |campaign      |searchCampaign |ds3advert      |line  |line2  |service  |channel|section |supplier      |platform |property|adUnit        |costModel   |client     |owner    |memo              |period  |contact |mapping | subproduct                 |label     |market|start     |end       |entity       |currency|budget|budget2 |budget3  |managed     |description|external|existing    |id             |external2|initiative|category|approver   |comments              |event     |conversion         |activity          |tag                                                          |weighting|
    |Test     |steve.automation@gmail.com      |Warlock99   |fridaysteve   |Madrid         |chromecast emea|Media |Service|adserving|search |default |Google Ireland|DS3      |Google  |Search Text Ad|Biddable CPC|google     |zanete   |test memo comments|q42014  |greg    |google  | AdWords - A01 (Acquisition)|label test|US    |2014-01-01|2014-05-07|CLIENT       |GBP     |20000 |2500    |2500     |Steve Young |test text  |google  |consultium  |700000001004851|DS3      |engage    |Internal|Steve Young|Feedback Comments Test|automation|Post Click Revenue |Enterprise - Apps |1026481_158189_7 Enterprise - Maps - Contact Form Transport  |10       |

#    DO NOT USE CAPITALS or SPACES in Campaign names - current code will not allow Existing Campaign functions - ID generation issues

#    Clients: Google, Financial

#    Owners: Zanete

#    Client Contact: Zanete, Gregg

#    Markets: USA,UK,GERMANY,FRANCE,SPAIN,RUSSIA,DENMARK,HOLLAND,GLOBAL

#    Liable Entity: CLIENT, LONDON, NORTH

#    Currency: GBP, EURO, YEN, HKD, USD,

#    Managed By: Steve Young

#  Search Campaigns:
#  700000001027510 FT News Subs,2013 Asia Japan
#  700000000072641
#  700000000087427
#  700000001010341
#  700000000087252
#  700000000031702
#  700000000031703
#  700000000085945
#  700000001009562
#  700000000072604





