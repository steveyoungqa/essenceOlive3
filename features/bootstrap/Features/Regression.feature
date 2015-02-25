@delete
Feature: Using Mink Context Properly

  Scenario Outline:


    And I Add a Line Cost Type of "<line>"

    And I choose a Line Channel of "<channel>"
    Then I choose a Line Section of "<section>"
  Then I allow a 10000 wait to allow APIs to be loaded
    Then I choose a Line Supplier of "<supplier>"
    Then I choose a Line Platform of "<platform>"
    And I choose a Line Property of "<property>"
    Then I choose a Line Ad Unit of "<adUnit>"
    And I choose a Line Cost Model of "<costModel>"

    Then I select a Line Start Date of "<start>"
    Then I select a Line End Date of "<end>"

    Then I add a Line Currency of "<currency>"
    And I set a Line Budget of "<budget2>"

    Then I add a Line Description of "<description>"

    And I Save the new Media Plan Line

    Then I select Publish Media Plan

    Then a check is made that plan is Published

    Then I choose to change from Editable Draft to Published Draft

    Then I select the Insertion Order tab

    And I select Map Account

    And I select an Insertion Order External Platform Link DS3

    Then I add a DSThree Account ID of "<id>"

#    And I add a Description of "<description>"

    Then I save the Manually Linked Account

#    And a check is made that the Mapped Account "<description>" has been saved

    Then I select Manage mapped entities

  Then I allow a 10000 wait to allow APIs to be loaded

    Then I select the Map Search Campaign "<searchCampaign>" checkbox

    Then I select Save the Managed Entities

  Then I allow a 15000 wait to allow APIs to be loaded

    Then I close the Mapped Panel

    Then I select the Plan tab

    Then I choose to change from Editable Draft to Published Draft

    Then I select Manage Approval
    And I select the Add Approval button
    And I select an Approval Category of "<category>"
    And I select an Approval Person of "<approver>"
    Then I Save the Approval

    Then I select Request Approval
    Then I select the Insertion Order tab
    Then I select the Plan tab

#    Then I close the Approval panel
    And I select Set Status
    And enter Feedback comments of "<comments>"
    Then I choose Approve
#    Then I choose Reject

    Then I click on the Navigation header
    Then I select Campaign
    Then I search for Campaign "<campaign>"
    And I select to edit an existing Campaign of "<campaign>"
    And I select Manage Conversion Event Mapping for existing Campaign of "<campaign>"
    Then I select Add Event
    And I add an Event Number of "20"
    And I add and Event name of "<event>"
    And I add a Conversion Source of Google FloodLights
    Then I save the Event

    Then I select Add Tag
    And I add a Conversion Type of "<conversion>"
    Then I allow a 5000 wait to allow APIs to be loaded
    And I choose an Activity Category of "<activity>"
    And I choose an Activity Tag of "<tag>"
    And I choose a Weighting of "<weighting>"

    Then I save the Tag

#    Then I click on the Navigation header

#    Then I select Tracking Management
#
#  Then I allow a 75000 wait to allow APIs to be loaded
#
#    Then I search for a Campaign tracking code of "<searchCampaign>"
#
##    And a check is made to ensure that the "<searchCampaign>" is shown as Mapped
#
#    Then I select the Advanced Filter
#
#    And I choose a DS3 Advertiser of "<ds3advert>"
#
#    Then I close the Advanced Search Filter

#    Then I select the detail page for the "<searchCampaign>"
#
#    Then a check is made that the Status is MAPPED

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





