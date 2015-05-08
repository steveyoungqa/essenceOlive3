Feature: Add Plan lines

In order to outline media buys and budget allocations across channels
As Campaign Manager
I want to add line items to my plan

#reviewed 6th May
Scenario: Specify platform (OTD-2052)
  Given a Media plan is set up
  When I go to add a new or edit existing plan line of type "Media"
  Then I can specify a "Platform"
    And I can choose one of the following options
    #-------------------
    # Platform
    # -----------------
    # DS3
    # DBM
    # YouTube
    # GDN
    # AdMob
    # LinkedIn
    # Twitter
    # Facebook
    # Other
    And "Platform" is mandatory
    And if "Other" is selected do not include in the IO name


#reviewed 6th May
Scenario: FE - Plan line grouping (OTD-573)
  Given I have set up a media plan
    And I have added lines for different sections / IOs / Channels
  When I view the media plan
  Then I see Section -> IO -> Channel as the default line grouping
    And Channel as displayed as first column (whatever is the third level is displayed as the first column)

#reviewed 6th May
Scenario: Publish Plan meta data with individual line publishing (OTD-2053)
  Given Media Plan has been set up
    And lines have been added to it
    And the whole plan has been published
    And later changes made to a few lines and plan meta data
  When user publish a selection of changed plan lines
  Then User is informed that Plan meta data changes will be published as well
    #@todo - Helen help confirm text
    And all Plan meta data changes are published along with selected lines

#to flesh out
Scenario: FE - IO List View without grid view

#to review
Scenario: FE - Hide spend when no platform integration available
  Given I have set up plan lines for platforms without Olive 3 integration
  When I look at the plan
  Then Spend column in Plan view and spend to date in IO view doesn't display any value (not even 0.00 as it's very misleading)

Scenario: Deleting lines after Client Approval
  Given
  When
  Then User is notified that Line will be downweighted to 0.00 instead of deleted so that Client viewing approved plan can see the changes
