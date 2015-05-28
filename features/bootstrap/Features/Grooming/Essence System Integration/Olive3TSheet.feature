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
Scenario: New Format T-Sheet (OTD-2001) - in sprint 27 [13th April]
  # OTD-2123 in sprint 29
  Given Campaign financial information is due to be managed thorugh Olive 3 as of new quarter
    And the plan and all lines are set up and published in Olive 3
    And Media Detail (T-sheet) relating to that plan is ready to be trafficked
  When AdOps member log into Olive 2
  Then he can find an upload form that accepts a new format T-sheet with the following changes:
#      -----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#      |Campaign ID                    | Campaign Name                    | PO ID     | Media Plan ID         | Media Plan Name         | Plan Line ID          | BOOKING
#      ----------------------------------------------------------------------------------------------------------------------------------------------------------------------
#      |Olive 2 Campaign ID (optional) | Olive 2 Campaign name (optional) |*REMOVE*  | Olive 3 Media Plan ID  | Olive 3 Media PLan Name | Olive 3 Plan Line ID  | *REMOVE*
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
#       | Media PLan Name is a recognised Olive 3 Media plan and       | "Media Plan ID and Media Plan  Name do not match data       |
#       |    matches the ID provided                                   |    in Olive 3"                                              |
#       | Plan Line belongs to Media Plan                              | "Plan Line belongs to a different Media Plan.               |
#       |                                                              | Please ensure IDs are correct"                              |
#       | Plan Line iD is a recognised Media Line (not service)        | "Plan Line ID refers to a service line, please ensure       |
#       |                                                              | you use Media Line ids"                                     |

#reviewed 5th May - in sprint 27 [11th April] -
Scenario: Olive 2 Campaign Doesn't exist (OTD-1928)
  Given a new O3 style t-sheet has been prepared for a completely new campaign (Trafic not set up)
    And an O3 tsheet has never been uploaded for it before
  When Campaign Manager uploads Olive 3 T-sheet without any Olive 2 Campaign IDs
  Then Olive 2 validates the T-Sheet format to ensure all columns are there
    And Olive 2 validates the content
    And Olive 2 T-Sheet upload generates Campaigns, Budget Periods and Purchase Orders from Information

#reviewed - in sprint 29 [11th May] -
Scenario: O2 - Create separate Off-network and House-Ads Campaigns (OTD-2084)
    Given a new O3 style t-sheet has been prepared for a completely new "Google" campaign (Trafic not set up)
      And an O3 tsheet has never been uploaded for it before
      And it has references to a mixture of liable entities (Client and Essence)
    When Campaign Manager uploads Olive 3 T-sheet without any Olive 2 Campaign IDs
    Then  for "Google" campaigns Olive 2 T-sheet upload generates a Campaign per Liable entity named and labelled as outlined below:
      # Client            | Liable Entity       | Campaign Naming Convention    | Budget Period Data      |
      # --------------------------------------------------------------------------------------------------|
      # Google            | Client Liable       | {Campaign Name}               | Label: {MP Label}       |
      #                   |                     | {MP Goal Type}                | Budget Type: House Ads  |
      #                   |                     | "House Ads"                   |                         |
      #                   |                     | {MP Period}                   |                         |
      #                   |                     | {MP Market Code}              |                         |
      # --------------------------------------------------------------------------------------------------|
      # Google            | Essence Liable      | {Campaign Name}               | Label: {MP Label}       |
      #                   |                     | {MP Goal Type}                | Budget Type: Off-Network|
      #                   |                     | "Off-Network"                 |                         |
      #                   |                     | {MP Period}                   |                         |
      #                   |                     | {MP Market Code}              |                         |
      #----------------------------------------------------------------------------------------------------

#to flesh out
Scenario: O2 - Separate House ads and Offnetwork Total Budgets (OTD-2127)
  # weight the sums of line items in each and attribute portions of total budget accordingly
  Given I have set up a Media plan in Olive 3
    And it contains a mixture of Essence and Client liable plan lines
    And I have used these plan lines as IDs in the Olive 3 T-sheet
    And I have uploaded this T-sheet in Olive 2
  When Olive generates separate budget periods for House Ads and Off Network lines (OTD-2084)
  Then It assigns a proportion of Total Budget as the Campaign Budget Period Budget as per calculations below
#   using a ratio of the Total budget (converted in Media Plan currency)
    # House Ads: sum of Client Liable lines converted in Media Plan currency) * Total Media Plan Budget in Olive 3 / Total Allocated Budget in Olive 3
    # Off-Network: Total Budget in Olive 3 - Campaign Budget Period BUdget of House Ads Budget period


#reviewed 5th May - in sprint 28 [27th April] -
Scenario: Olive 2 Budget Period doesn't exist but Placements, Bookings and Campaign already set up and trafficked in the previous quarter (OTD-2001)
  Given I have already set up Campaigns / Bookings in Olive 2
    And a new budget period is starting when I have to manage finances through Olive 3
    And dOps have already trafficked most placements in previous budget periods
    And Olive 2 marketing codes have already been generated for these Placements using the  t-Sheet & DCM sheet upload or manual mappings
  When I upload a T-Sheet with Olive 3 meta data
  Then Exisitng entities (Placements / Creatives / Mktg Codes etc) are recognised and new ones are created
    And Olive 3 Meta data is added to those existing placements
    And PO - Booking links created between new POs and exisitng bookings

#(reviewed 5th May) - in sprint 28 [27th April] -
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

#reviewed 12th May - in sprint 29 [11th May] -
Scenario: O2 - Use O3 to look up Brand / DR and capping information (OTD-2067)
  Given Campaign financial information is due to be managed thorugh Olive 3 as of new quarter
    And negotiated media plan and all lines are set up and published in Olive 3
    And Media Detail (T-sheet) relating to that plan is ready to be trafficked
  When AdOps member log into Olive 2
  Then he can find an upload form that accepts a new format T-sheet with the following changes:
    # [TGC] Brand / DR is no longer required (ignored) - CANCELLED - still possible to set brand and dr
    # Capping fields are no longer present (ignored): Deal Structure	Olive Cap Amount	Billing Stats	Booking Start Date	Booking End Date	Net Unit Cost	Net Media Budget

#reviewed 12th May - in sprint 29 [11th May] -
Scenario: O2 - Autogenerated dummy biddable forecast lines for "Biddable" Olive 3 plan lines (OTD-2071)
  Given I'm uploading an Olive 3 t-sheet
    And I have entered a reference to Olive 3 Plan line which is of Cost Model "Biddable *" ("VARIABLE" type), also should be the same as Buy Type "Biddable" or "Programmatic - *"
  When I have confirmed I'm happy with the upload generated entities
  Then Olive 3 t-sheet upload behaves as if "BID" was entered in the "Deal structure" column of existing t-sheet (generate Dummy bkl & fcl)
    And Olive 2 stores a reference to Olive 3 "Plan line ID" against every Booking and forecast line

#reviewed 12th May - in sprint 29 [11th May] -
Scenario: O2 - Autogenerate Negotiated cost Booking Lines from Olive 3 Plan lines (OTD-2071)
  Given I'm uploading an Olive 3 t-sheet
    And I have entered a reference to Olive 3 Plan line which is of Buy Type "Direct Buy"
  When I have confirmed I'm happy with the upload generated entities
  Then Olive 2 creates a Booking line for each Olive plan line and stores a reference to Olive 3 "Plan line ID" and "bkl_cap" set
    And It decides Olive 2 Commission metric value from olive 3 plan line "Cost Model" as follows
      # ======================|====================
      # Cost Model            | Commission Metric
      # ======================|===================
      # Fixed CPC             | #1
      # Fixed CPM             | #2
      # Fixed Cost            | #3
      # Fixed CPA - Event 1   | #11
      # Fixed CPA - Event 2   | #44
      # Fixed CPA - Event 9   | #15
    And it uses Olive 3 PLan Line "Quantity" as Booking line Amount ("bkl_amount")
    And it always uses "SUPPLIER" as "bkl_stats" source
    And it uses Plan line "Start date" and "End date" to populate "bkl_start_date" and "bkl_end_date_fin", "bkl_end_date_del" respectively
    And it generates a child forecast line (except cap flag) with the same information as its parent booking line for each Olive 2 placement,
    And it uses Olive 3 plan line "Unit cost" to populate "fcl_cost"
    And if the Cost model is "Fixed Cost" then Olive 2  DOESN'T SET a cap flag "bkl_cap" and amount "bkl_amount"
    And if the Cost model is "Fixed Cost" then Olive 2 picks one of all placements under the booking and only applies the "Unit cost" to one of the forecast lines
    And it pickst the placement based on its "Placement Type" rank, highest first (Rank 1 = Highest rank):
      # ====================================
      # ID  | Rk | PLT_NAME
      # ====================================
      # 79  | 1  | Masthead
      # 20  | 2  | Pushdown
      # 11  | 3  | Reskin
      # 86  | 4  | Bespoke takeover
      # 89  | 5  | Expandable banner
      # 22  | 6  | Overlay
      # 18  | 7  | Hockey Stick
      # 24  | 8  | Interstitial
      # 116 | 9  | Lightbox
      # 67  | 10 | In-stream video
      # 93  | 11 | In-stream video (skippable)
      # 75  | 12 | YouTube Promoted Video
      # 117 | 13 | YouTube Preferred
      # 96  | 14 | Other video
      # 85  | 15 | Audio Ad
      # 87  | 16 | Email (Newsletter)
      # 88  | 17 | Email (Solus)
      # 19  | 18 | Poll
      # 90  | 19 | Facebook ASU
      # 91  | 20 | Facebook Reachblock
      # 92  | 21 | Facebook Sponsored Story
      # 97  | 22 | PPC Search Ad
      # 98  | 23 | Promoted Account
      # 99  | 24 | Promoted Trend
      # 100 | 25 | Promoted Tweet
      # 43  | 26 | Advertorial
      # 95  | 27 | Notification / Alert
      # 101 | 28 | Standard Banner
      # 103 | 29 | Text & image ad
      # 94  | 30 | Link / text ad
      # 61  | 31 | Companion banner
      # 102 | 32 | Synced Banner
      # 104 | 33 | Tracking Tag
      # 105 | 34 | Untracked
      #------------------------------------------



#reviewed 18th May - in sprint 29 [11th May] - accepted
Scenario: Do not enforce Client POs for Client Liable Plan lines (OTD-2104)
  Given I've prepared an O3 t-sheet
    And it references an Olive 3 plan line that is "Client Liable"
    And there is no Client PO - Olive 3 IO association
  When I'm uploading the t-sheet into Olive 3
  Then it lets me upload and leaves any Client PO references in O2 Purchase Orders and Budget Periods blank (or sets to "house-ads")

#to review - in sprint 30 [25th May] -
Scenario: O2 - Allow specifying the Booking for a new or existing placement through t-sheet (OTD-2148)
  Given I have prepared an O3 T-sheet as illustrated below:
      # PLACEMENT       | O3 Plan Line       | Booking Name        |
      # ===========================================================|
      # Existing Pla A  | Biddable line #123 | Existing Booking A  |
      # Existing Pla B  | Biddable line #123 | Existing Booking B  |
      # New Pla C       | Biddable line #123 | Existing Booking B  |
      # New Pla D       | Biddable line #123 | New Booking D       |
    And "Existing Pla A" and "Existing Pla B" already exist in Olive 2
    And "New Pla C" and "New Pla D" are new Placements
    And "Existing Booking A" and "Existing Booking B" already exist in Olive 2
    And "New Booking D" booking doesn't exist
    And "Biddable line #123" is an Olive 3 plan line that uses a "VARIABLE" pricing type cost model
  When I upload this t-Sheet into Olive 2
  Then Olive 2 creates "New Pla C" in the "Existing Booking B"
    And Olive 2 creates "New Pla D" in "New Booking D"

#to review - in sprint 30 [25th May] -
Scenario: O2 - Ensure 1-to-1 relationship between Bookings and FIXED pricing type cost model O3 Plan Lines (OTD-2148)
  Given I have prepared an O3 T-sheet for an existing campaign as illustrated below:
      # PLACEMENT       | O3 Plan Line    | Booking Name         |
      # =========================================================|
      # Existing Pla A  | FIXED line #123 | Existing Booking A   |
      # Existing Pla B  | FIXED line #123 | Existing Booking B   |
      # New Pla C       | FIXED line #123 | Existing Booking B   |
      # New Pla D       | FIXED line #123 | New Booking D        |
    And "Existing Pla A" and "Existing Pla B" already exist in Olive 2
    And "New Pla C" and "New Pla D" are new Placements
    And "Existing Booking A" and "Existing Booking B" already exist in Olive 2
    And "New Booking D" booking doesn't exist
    And "FIXED line #123" is an Olive 3 plan line that uses a "FIXED" pricing type cost model, e.g. one of the below:
      #Fixed CPC
      #Fixed CPM
      #Fixed CPA
      #Fixed Cost
  When I upload this t-Sheet into Olive 2
  Then Olive 2 throws an error indicating the line number in T-sheet and the following text
    # "Placements under Olive 3 Plan lines with fixed pricing type Cost Model cannot be separated into different Olive 2 bookings.
    # Please ensure all rows for this Olive 3 plan line ID reference the same Booking Name"

#to review
Scenario: Supplier Mismatch handling
  #UAT outcome - Olive shouldn't let me uplaod a T-sheet where existing Placement is under a booking with mismatching Supplier
    Given I have prepared a t-sheet
      # Placement 		  | Booking 				    | Supplier of Booking | Plan Line 	| Supplier of Plan Line |
      # --------------------------------------------------------------------------------------------------|
      # Existing Pla A 	| Existing Booking A	| Supplier A				  | O3 line 	  | Supplier B				    |
    When I upload this T-sheet in Olive 2
    Then Olive 2 throws an error indicating the line number in T-sheet and the folowing text
      # "Supplier mismatch. Plan Line Supplier is {Supplier legal entity}, but Supplier of existing booking and in T-sheet is {Supplier legal Entity}.
      # Please ensure they match"



#reviewed 21st May - in sprint 30 [25th May] -
Scenario: O2 - Ensure Booking is never linked to more than one plan line during a time (OTD-2128)
  #moving placements between bookings does not need to be supported in T-sheet
  Given a T-sheet contains 2 placements that belong to the same booking (new or existing)
    And it is referenced to by 2 different Olive 3 plan lines that overlap
  When I try to upload that T-sheet in Olive 2
  Then Olive 2 throws an error indicating the line number in T-sheet and the following text
    # "Placements that belong to different Olive 3 Plan lines running during the same time period
    # cannot be grouped under one Olive 2 Booking"

#reviewed - in sprint 29 [11th May] - accepted
Scenario: O2 - Ignore booking column and autogenerate (OTD-2105)
  Given Given I've prepared an O3 t-sheet
    And I have left the "Booking Name" column blank
  When I'm uploading the t-sheet into Olive 3
  Then Olive 2 autogenerates a booking for each plan line
    And records a reference to the Olive 3 "Plan line ID"
    And names it as per convention using Olive 3 {"PLan Line ID"} - {"Property"} - {first 20 chars from "Plan Line description"}
    And uses Plan line creator and last publisher as created and last changed events



#reviewed 21st May - in sprint 30 [22nd May] -
Scenario: O2 - Do not create dummy lines for certain platforms (OTD-2129)
  Given I have selected one of "Biddable" Cost models for plan lines in olive 3
    And the platform of these lines is one of the following:
     # DBM
     # DS3
     # GDN
     # AdMob
     # YouTube
     # Facebook
     # Twitter

     # (iAd Workbench) ??
    And I have added ids of these lines in O3 T-sheet
  When I'm uploading the T-sheet in Olive 2
  Then There are no dummy Booking and Forecast lines created for the related placements

#reviewed 18th May - in sprint 30 [22nd May] -
Scenario: O2 - Sync O3 changes to Olive 2 T-sheet entities (OTD-2106)
  Given Olive 2 has auto-generated entities as a result of O3 T-sheet upload
    And changes have been published to the source entities in Olive 3
  When x time has passed since last sync
  Then Olive 2 detects published changes in Olive 2
    And updates Olive 2 counterparts accordingly
    And Olive 2 detects manual changes done to autogenerated Campaigns, Budget Periods, Purchase Orders, Booking Lines, Forecast Lines directly in Olive 2
    And overwrites these c hanges with Olive 3 data

#reviewed 18th May - in sprint 30 [22nd May] -
Scenario: Indicate that an Olive 2 entity is auto generated as a result of updating O3 T-sheet (OTD-2107)
  #blocked by booking autogen
  Given Olive 2 has auto-generated entities as a result of O3 T-sheet upload
  When I look at them in Olive 2
  Then Any autogenerated bookings have a mention in the Memo "Created automatically by Olive 3 T-sheet upload for Olive 3 plan line {Plan Line ID}"
    And Any Budget Periods under associated MAFs:"Created automatcially by Olive 3 T-sheet upload for Olive 3 Plan: {Media Plan Name}"
    And exception is Booking Lines and Forecast Lines , due to space restrictions there are no indications

#to flesh out when re-using the property in Olive 3
Scenario: Handle DBM lines - Placement property should be Invite Media

#(reviewed 5th May)
Scenario: Olive 3 autogenerated Olive 2 entities cannot be edited via Olive 2 uploader
  Given Campaign financial information for an evergreen is due to be managed thorugh Olive 3 as of new quarter
   And AdOps have uploaded o3 T-sheet in Olive 2
   And Olive 2 has generated Campaigns, Budget Periods and Purchase Orders
  When Users tries to upload Olive 3 Workbook with changes to any of these auto-generated entities
  Then They see a note at the workbook upload screen
    # "Note that any changes to Entities generated by Olive 3 T-sheet (e.g. Campaigns, Budget Periods and Purchase Orders) will be ignored"
    And Olive 2 ignores any changes to auto-generated entities

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
