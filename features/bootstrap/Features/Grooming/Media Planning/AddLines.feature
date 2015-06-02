Feature: Add Plan lines

In order to outline media buys and budget allocations across channels
As Campaign Manager
I want to add line items to my plan

#reviewed 6th May - in sprint 29 [11th May] -
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

#reviewed 11th May - in sprint 29 [11th May] -
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

#reviewed 11th May - in sprint 29 [11th May] -
Scenario: Specify Event number for "Fixed CPA" (OTD-2073)
  Given a Media plan is set up
    And I'm adding a new "Media" plan line
  When Select "Fixed CPA" as Cost Model
  Then I can choose a supported "Event" number from the following options: 1, 2, 9
  # NOTE - please remove Fixed CPV from the options as part of the story as there's no mapping for it to Olive 2 commissio metrics

#reviewed 20th May 2015 - in sprint 29 [11th May] -
# in order to minimise confusion when calculating actual spend in DS scripts and
# pass on the correct FCL cost to Olive 2 T-sheet autognerated fcls
# to reliably show people the actual value that's being used
Scenario: Store Net Budget instead of Gross (OTD-2111) 3
  Given A media Plan line is added
    And its a "FIXED" type of cost model (Fixed CPC, Fixed CPM etc)
    And Discount is applied
  When I look at the plan line in the database
  Then The stored values I see are "NET Budget" and "NET Unit Cost" #includes migrating existing



#reviewed 20th May 2015
Scenario: Re-organise Plan line fields to incorporate Unit Cost and Quantity (OTD-2110) 8
  # based on https://docs.google.com/presentation/d/138vGhxIlJKhS7j_zZ0w7ikLKRU79rjiqsrGhuAbgovY/edit#slide=id.p
  # - discount always visible
  # - % by default
  # - one amount appears to be used for both
  # - no need to show the discount amount
  # - make sure net budget is stored
  Given A media Plan is set up
  When I Add a new plan line or edit an exisitng
  Then Net Budget placeholder text says "Net"
    And Unit placeholder text says "Net" (visible when "Direct Buy" selected as Buy Type)
    And Discount field is always visible
    And % is selected by Default
    And it's empty by default which indicates that Discount is not applied
    And I cannot see a Discount toggle checkbox
    And I cannot see the actually calculated discount amount when % is used

#reviewed 20th May 2015
Scenario: Display Gross Budget when Discount applied (OTD-2110)
  # - display Gross just under budget as soon as discount applied
  # - if discount applied - auto-calculate and show Gross unit cost
  Given A I need to set up a media Plan with Discount applied
  When I add or edit it
  Then I can enter a discount in the field
    And see "Gross" budget automatically calculated and displayed as a read-only label below "Net Budget" field
    And see "Gross" unit cost automatically calculated and displayed as a read-only label below "Net Unit Cost" field

#reviewed 20th May 2015
Scenario: Display Unit Cost and Quantity when "Direct Buy" (OTD-2110)
  #NEW Handle Fixed CPM, CPC, CPA
  # - show NET unit cost and quantity
  # - do not show NET unit cost but assume it to be the same as net budget,
  # NEW - Handle Fixed Cost
  Given A I need to set up a media Plan with Fixed price (Fixed CPC, FIxed CPM etc) (except Fixed Cost)
  # (except because we do not want to see the quantity as it's always 1 and the pricing units are confusing)
  When I add or edit it
  Then I can enter a net "unit cost"
    And see quantity automatically calculated and displayed as a read-only label below "Unit Cost" field
    And I can see the pricing units (impressions or clicks etc) associated with Cost model displayed next to the value

#reviewed 20th May 2015
Scenario: One field appears to be used when toggling between discount types (OTD-2110)
  Given I have added a media plan line for Fixed CPM
    And Discount is applied
    And I'm on the line details form
    And I have entered an amount in the discount field as outlined below
    #| Cost Model | Net Budget | Net Unit Cost | Discount Type | Value in Discount Field | Quantity | Gross Budget |
    # =============================================================================================================|
    #|Fixed CPM   | 3,016.60   | 19.55         | %             | 15                      |  154302  | 3,548.94     |
  When I use a toggle from % to Amount and vice versa
  Then the amount I have entered remains in the discount field
    And the calculated values update accordingly:
    #| Cost Model | Net Budget | Net Unit Cost | Discount Type | Value in Discount Field | Quantity | Gross Budget |
    # =============================================================================================================|
    #|Fixed CPM   | 3,016.60   | 19.55         | Amount        | 15                      |  154302  | 3,031.60     |

#Plan Line tests
Scenario: Fixed CPM line without Discount
  Given I have set up a media line without discount
    And chosen 'Fixed CPM' as 'Cost Model'
    And Entered '6000' as 'Net Budget'
    And entered '0.25' as 'Unit Cost'
    And left discount field empty
  When I look at the plan line form
  Then I don't see 'Budget (Gross)'
    And I don't see 'Unit Cost (Gross)'
    And 'Quantity' is calculated as '24000000 impressions'

Scenario: Fixed CPC Without discount
  Given I have set up a media line without discount
    And chosen 'Fixed CPC' as 'Cost Model'
    And Entered '50000' as 'Net Budget'
    And entered '2' as 'Unit Cost'
    And left discount field empty
  When I look at the plan line form
  Then I don't see 'Budget (Gross)'
    And I don't see 'Unit Cost (Gross)'
    And 'Quantity' is calculated as '25000 clicks'

Scenario: Fixed CPA Without discount
  Given I have set up a media line without discount
    And chosen 'Fixed CPA' as 'Cost Model'
    And Entered '3200' as 'Net Budget'
    And entered '20' as 'Unit Cost'
    And left discount field empty
  When I look at the plan line form
  Then I don't see 'Budget (Gross)'
    And I don't see 'Unit Cost (Gross)'
    And 'Quantity' is calculated as '160'

Scenario: Fixed Cost Without discount
  Given I have set up a line without discount
    And chosen 'Fixed Cost' as 'Cost Model'
    And Entered '20000' as 'Net Budget'
    And left discount field empty
  When I look at the plan line form
  Then I don't see 'Budget (Gross)'
    And I don't see 'Unit Cost (Gross)'
    And 'Unit Cost (Net)' is read only as '20000'
    And 'Quantity' is calculated as '1' but not shown

Scenario: Variable Without discount
  Given I have set up a line without discount
    And chosen a 'Variable' pricing type as 'Cost Model' (one of "Biddable")
    And Entered '3200' as 'Net Budget'
    And left discount field empty
  When I look at the plan line form
  Then I don't see 'Budget (Gross)'
    And I don't see 'Unit Cost (Gross)' or 'Unit Cost (Net)'
    And I don't see 'Quantity'


Scenario: Fixed CPM  With discount percent 
  Given I have set up a line without discount
    And chosen 'Fixed CPM' as 'Cost Model'
    And Entered '3016.6' as 'Net Budget'
    And entered '19.55' as 'Unit Cost'
    And entered '15% discount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '3548.94'
    And 'Unit Cost (Gross)' is equal to '23'
    And 'Quantity' is calculated as '154302 impressions'

Scenario: Fixed CPC  With discount percent
  Given I have set up a line without discount
    And chosen 'Fixed CPC' as 'Cost Model'
    And Entered '25000' as 'Net Budget'
    And entered '0.1' as 'Unit Cost'
    And entered '15% discount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '29411.76'
    And 'Unit Cost (Gross)' is equal to '0.12'
    And 'Quantity' is calculated as '250000 clicks'

Scenario: Fixed CPA  With discount percent
  Given I have set up a line without discount
    And chosen 'Fixed CPA' as 'Cost Model'
    And Entered '21875' as 'Net Budget'
    And entered '0.1' as 'Unit Cost'
    And entered '15% discount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '25735.29'
    And 'Unit Cost (Gross)' is equal to '0.12'
    And 'Quantity' is calculated as '218750'

Scenario: Fixed Cost  With discount percent
  Given I have set up a line without discount
    And chosen 'Fixed Cost' as 'Cost Model'
    And Entered '17850' as 'Net Budget'
    And entered '15% discount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '21000'
    And 'Unit Cost (Net)' is read-only as '17850'
    And 'Quantity' is calculated as '1' but not shown

Scenario: Fixed CPM  With discount amount
  Given I have set up a line without discount
    And chosen 'Fixed CPM' as 'Cost Model'
    And Entered '3016.6' as 'Net Budget'
    And entered '19.55' as 'Unit Cost'
    And entered '20' as 'Discount amount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '3036.6'
    And 'Unit Cost (Gross)' is equal to '19.68'
    And 'Quantity' is calculated as '154302 impressions'

Scenario: Fixed CPC  With discount amount
  Given I have set up a line without discount
    And chosen 'Fixed CPC' as 'Cost Model'
    And Entered '25000' as 'Net Budget'
    And entered '0.1' as 'Unit Cost'
    And entered '20' as 'Discount amount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '25020'
    And 'Unit Cost (Gross)' is equal to '0.10008'
    And 'Quantity' is calculated as '250000 clicks'

Scenario: Fixed CPA  With discount amount
  Given I have set up a line without discount
    And chosen 'Fixed CPA' as 'Cost Model'
    And Entered '21875' as 'Net Budget'
    And entered '0.1' as 'Unit Cost'
    And entered '20' as 'Discount amount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '21895'
    And 'Unit Cost (Gross)' is equal to '0.10'
    And 'Quantity' is calculated as '218750'

Scenario: Fixed Cost  With discount amount
  Given I have set up a line without discount
    And chosen 'Fixed Cost' as 'Cost Model'
    And Entered '17850' as 'Net Budget'
    And entered '20' as 'Discount amount'
  When I look at the plan line form
  Then I see 'Budget (Gross)' is equal to '17870'
    And 'Unit Cost (Net)' is read-only '17850'
    And 'Quantity' is calculated as '1' but not shown









#reviewed 6th May - in sprint 28 [27th April] -
Scenario: FE - Plan line grouping (OTD-573)
  Given I have set up a media plan
    And I have added lines for different sections / IOs / Channels
  When I view the media plan
  Then I see Section -> IO -> Channel as the default line grouping
    And Channel as displayed as first column (whatever is the third level is displayed as the first column)

#reviewed 6th May - in sprint 29 [11th May] -
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
