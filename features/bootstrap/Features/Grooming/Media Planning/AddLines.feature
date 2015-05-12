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
    # TubeMogul
    # Other
    And "Platform" is mandatory
    And if "Other" is selected do not include in the IO name

#reviewed 11th May
Scenario: Specify Unit cost and Quantity (OTD-2072)
  Given I'm adding a new or edit existing "Media" plan line
    And I have specified "Direct Buy" as buy type
    And And selected one of the "Negotiated" (not biddable) Cost models
    # either Fixed CPM, Fixed CPC, Fixed CPA, Fixed Cost
  When I'm looking at the plan line
  Then I can add "Unit cost"
    And if I've selected "Fixed Cost", "Unit cost" is forced to be the same as "Budget"
    And I cannot save the plan line without Unit cost provided
    And I can see "Quantity" as a calculated field using the following:
    # ==================================================
    # Cost Model  | Quantity                           |
    # ==================================================
    # Fixed CPC,  | Gross Amount / Unit Cost           |
    # Fixed CPA   |                                    |
    # -------------------------------------------------|
    # Fixed CPM   | (Gross Amount / Unit Cost) * 1000  |
    # -------------------------------------------------|
    # Fixed Cost  | 1                                  |
    #--------------------------------------------------|

#reviewed 11th May
Scenario: Specify Event number for "Fixed CPA" (OTD-2073)
  Given a Media plan is set up
    And I'm adding a new "Media" plan line
  When Select "Fixed CPA" as Cost Model
  Then I can choose a supported "Event" number from the following options: 1, 2, 9
  # NOTE - please remove Fixed CPV from the options as part of the story as there's no mapping for it to Olive 2 commissio metrics

#to flesh out
Scenario: Store Net Budget instead of Gross

#to flesh out
Scenario: Re-organise Plan line fields to incorporate Unit Cost and Quantity
# based on https://docs.google.com/presentation/d/138vGhxIlJKhS7j_zZ0w7ikLKRU79rjiqsrGhuAbgovY/edit#slide=id.p
# - discount always visible
# - % by default
# - one amount appears to be used for both
# - no need to show the discount amount
# - make sure net budget is stored
# - display Gross just under budget as soon as discount applied
#NEW Handle Fixed CPM, CPC, CPA
# - show NET unit cost and quantity
# - if discount applied - auto-calculate and show Gross unit cost
#NEW - Handle Fixed Cost
# - do not show NET unit cost but assume it to be the same as net budget,

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
  When user publishes a selection of changed plan lines
  Then User is informed that Plan meta data changes will be published as well
    # "Changes you have made to the Media Plan details will also be published at the same time as these lines"
    And all Plan meta data changes are published along with selected lines

#to flesh out
Scenario: FE - IO List View without grid view

#to review
Scenario: FE - Hide spend when no platform integration available
  Given I have set up plan lines for platforms without Olive 3 integration
  When I look at the plan
  Then Spend column in Plan view and spend to date in IO view does not display any value (not even 0.00 as it is very misleading)

Scenario: Deleting lines after Client Approval
  Given
  When
  Then User is notified that Line will be downweighted to 0.00 instead of deleted so that Client viewing approved plan can see the changes
