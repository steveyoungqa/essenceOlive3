Feature: Olive 3 t-Sheet
#https://docs.google.com/a/essencedigital.com/spreadsheets/d/1QSetLFGCh6UkTKw5vZiwcKcGlyfqhOhJM-3u6wZq0KI/edit#gid=1531004265
In order to map olive 2 placements to Olive 3 financial data
As Campaign Manager
I want to be able to upload a new format T-sheet in Olive 2

#(reviewed 5th May)
#in Olive 3
Scenario: Download O3 Plan with Line IDs for T-sheet (OTD-1921)
  Given I have set up a Media Plan in Olive 3
    And I have published it
  When I view the published version of the plan
  Then I can download a csv of all lines contianing the following columns:
#    -------------------------------------------------
#    |Client Name  |Campaign ID    |Campaign Name  |
#    |Media Plan ID|Media Plan Name|Initiative     |Market (code)|Start Date |End Date   |
#    |Plan Line ID |Section        |Supplier       |Property     |Platform   |Channel    |
#    |Media Type   |Currency       |Budget         |Description  |

#(reviewed 5th May)
#in Olive 2
Scenario: New Format T-Sheet (OTD-2001)
  Given Campaign financial information is due to be managed thorugh Olive 3 as of new quarter
    And the plan and all lines are set up and published in Olive 3
    And Media Detail (T-sheet) relating to that plan is ready to be trafficked
  When AdOps member log into Olive 2
  Then he can find an upload form that accepts a new format T-sheet with the following changes:
#      ----------------------------------------------------------------------------------------------
#      |Campaign ID                    | Campaign Name                    | PO ID     | Media Plan ID          | Plan Line ID          |
#      ----------------------------------------------------------------------------------------------
#      |Olive 2 Campaign ID (optional) | Olive 2 Campaign name (optional) |*REMOVE*  | Olive 3 Media Plan ID  | Olive 3 Plan Line ID  |
#      ----------------------------------------------------------------------------------------------
    And it is clearly labelled as "Olive 3 T-Sheet" in a section "Olive 3 AdOps Mapping"
    And on upload Olive 2 validates the T-Sheet format to ensure all columns are there
    And Olive 2 validates the content of new columns and displays feedback if failed:
#       ------------------------------------------------------------------------------------------------------------------------------
#       | RULE                                                         | Error Msg                                                   |
#       ------------------------------------------------------------------------------------------------------------------------------
#       | If Campaign ID provided, it's a recognised Olive 2 Campaign  | "Campaign ID not recognised"                                |
#       | If CAmpaign ID and CAmpaign Name provided, they match        | "Campaign ID and Campaign Name do not match data in Olive"  |
#       | If Campaign ID not provided, allow upload anyway             |                                                             |
#       | Plan Line ID is a recognised Olive 3 published plan line     | "Plan Line ID not recognised. Please ensure it's pubished"  |
#       | Media Plan ID is a recognised Olive 3 Pulbisehd Media Plan ID| "Media Plan ID not recognised. Please ensure it's published"|
#       | Plan Line belongs to Media Plan                              | "Plan Line belongs to a different Media Plan.               |
#       |                                                              | Please ensure IDs are correct"                              |

#reviewed 5th May
Scenario: Olive 2 Campaign Doesn't exist (OTD-1928)
  Given a new O3 style t-sheet has been prepared for a completely new campaign (Trafic not set up)
    And an O3 tsheet has never been uploaded for it before
  When Campaign Manager uploads Olive 3 T-sheet without any Olive 2 Campaign IDs
  Then Olive 2 validates the T-Sheet format to ensure all columns are there
    And Olive 2 validates the content
    And Olive 2 T-Sheet upload generates Campaigns, Budget Periods and Purchase Orders from Information

#reviewed 5th May
Scenario: Olive 2 Budget Period doesn't exist but Placements, Bookings and Campaign already set up and trafficked in the previous quarter (OTD-2001)
  Given I have already set up Campaigns / Bookings in Olive 2
    And a new budget period is starting when I have to manage finances through Olive 3
    And dOps have already trafficked most placements in previous budget periods
    And Olive 2 marketing codes have already been generated for these Placements using the  t-Sheet & DCM sheet upload or manual mappings
  When I upload a T-Sheet with Olive 3 meta data
  Then Exisitng entities (Placements / Creatives / Mktg Codes etc) are recognised and new ones are created
    And Olive 3 Meta data is added to those existing placements
    And PO - Booking links created between new POs and exisitng bookings

#(reviewed 5th May)
Scenario: Olive 2 Campaign already has a Budget Period that overlaps dates of O3 Media Plan in uploaded t-sheet (OTD-2050)
  Given Campaign financial information for an evergreen is due to be managed thorugh Olive 3 as of new quarter
   And the plan and all lines are set up and published in Olive 3
   And Media Detail (T-sheet) relating to that plan is ready to be trafficked
   And T-sheet contains reference to manually generated Olive 2 campaign
   And that campaign already has a Budget Period with overlapping dates to the Media plan referenced in T-Sheet
  When AdOps upload o3 T-sheet in Olive 2
  Then Olive 2 throws a error asking to remove existing Budget Period
    And suggest that if MAF is already signed off, submit a JIRA ticket.
    #we'd have to manually figure out what the link between the Olive 2 Placement to Olive 3 Media Plan Line is

#(reviewed 5th May)
Scenario: Olive 3 autogenerated Olive 2 entities cannot be edited via Olive 2 forms (OTD-2051)
  Given Campaign financial information for an evergreen is due to be managed thorugh Olive 3 as of new quarter
   And AdOps have uploaded o3 T-sheet in Olive 2
   And Olive 2 has generated Campaigns, Budget Periods and Purchase Orders
  When Users look at these auto-generated entities in Olive 2
  Then they clearly see that these are autogenerated from O3 t-sheet
    And they cannot Edit campaign data
    And they cannot add / edit / delete bdget periods
    And they cannot add / edit / delete DTS mappings
    And they cannot add / edit / archive purchase orders
    And they cannot add / edit / delete PO line items

#(reviewed 5th May)
Scenario: Olive 3 autogenerated Olive 2 entities cannot be edited via Olive 2 uploader
  Given Campaign financial information for an evergreen is due to be managed thorugh Olive 3 as of new quarter
   And AdOps have uploaded o3 T-sheet in Olive 2
   And Olive 2 has generated Campaigns, Budget Periods and Purchase Orders
  When Users tries to upload Olive 3 Workbook with changes to any of these auto-generated entities
  Then They see a note at the workbook upload screen
    # "Note that any changes to Entities generated by Olive 3 T-sheet (e.g. Campaigns, Budget Periods and Purchase Orders) will be ignored"
    And Olive 2 ignores any changes to auto-generated entities
