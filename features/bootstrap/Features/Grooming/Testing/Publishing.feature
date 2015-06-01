# S1 - S4 = severity
# if these fail we have a problem 1 - big, 4 - small

#################
# DEFAULTS - unless otherwise stated
################
# Plan:
#   Market: DE,
#   Currency: EUR,
#   Budget: 100,
#   Liable Entity: Essece LON,
#   Dates: 01-04-2015 - 30-06-2015,
#   Manager: {yoursel},
#   Label: blank,
#   KPI Type: DR,
#   Breach Threshold: 20%,
#   Use MAFs: no
#   Harvest: 7776118 - Essence Technology, Olive 3
#   Initiative: Q2-2014 1001018 GSA Awareness
#
# Media Line:
# Supplier           | Property      | Section     | Channel   | Media Type        | Buy Type | Platform | Currency | Cost Model   | Liable Entity | NET Unit Cost | Discount |
# ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
# Ebuzzing Inc       | Teads         | Off Network | Display   | Standard Banners  | Direct   | --       | GBP      | Fixed CPM    | Essence LON   | 0.10          | 15%      |
# Google Ireland Ltd.| Google Search | House Ads   | Search    | Search Text Ad    | Biddable | DS3      | USD      | Biddable CPC | Client        | --            | --       |

# First time publishes (S3)
Scenario: 1. Publish new line, only one in IO
  Given I have set up a "Draft" media plan as outlined below
    # ---------------------------------------------------------------------------------------------|
    # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
    # ---------------------------------------------------------------------------------------------|
    # Draft        | $100         | $10       | $90         | 1       | 1           | 0            |
    # Published    | $100         |           |             | 0       | 0           | 0            |
    # ---------------------------------------------------------------------------------------------|
    And it has never been published before
    And I have set up 1 plan line as outlined below my Media Plan
    # ----------------------------------------------------------------|
    # Supplier              | Property | Draft Budget | Publ. Budget  |
    # ----------------------------------------------------------------|
    # Google Ireland Ltd.   | GDN      | $10          |  --           |
    # ----------------------------------------------------------------|
    And I'm on the plan line edit form
  When I hit Save & Publish
  Then Then Media Plan status changes to "Published"
    # ---------------------------------------------------------------------------------------------|
    # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
    # ---------------------------------------------------------------------------------------------|
    # Draft        | $100         | $10       | $90         | 1       | 1           | 0            |
    # Published    | $100         | $10       | $90         | 1       | 1           | 0            |
    # ---------------------------------------------------------------------------------------------|
    And Plan line Data and IO status changes as outlined below
      # -----------------------------------------------------------------|
      # Supplier              | Property  | Draft Budget | Publ. Budget  |
      # -----------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN       | $10          |  $10          |
      # -----------------------------------------------------------------|

Scenario: 2. Publish new Line, out of two, never published IO
  Given I have set up a "Draft" media plan as outlined below
    # ---------------------------------------------------------------------------------------------|
    # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
    # ---------------------------------------------------------------------------------------------|
    # Draft        | $100         | $20       | $80         | 1       | 2           | 0            |
    # Published    | $100         |           |             | 0       | 0           | 0            |
    # ---------------------------------------------------------------------------------------------|
    And it has never been published before
    And I have set up 2 plan lines as outlined below
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Supplier              | Property          | Draft Budget | Publ. Budget  | Int appr. Budget   | Clt. appr. Budget | IO Internal Status | IO Supplier Status |
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Google Ireland Ltd.   | GDN               | $10          |  --           |  --                |  --               | Draft              | Not Confirmed      |
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Google Ireland Ltd.   | GDN               | $10          |  --           |  --                |  --               | Draft              | Not Confirmed      |
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
    And I'm on the plan line edit form for the first line
  When I hit Save & Publish
  Then Media Plan data changes to "Published"
    # ---------------------------------------------------------------------------------------------|
    # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
    # ---------------------------------------------------------------------------------------------|
    # Draft        | $100         | $20       | $80         | 1       | 2           | 0            |
    # Published    | $100         | $10       | $90         | 1       | 1           | 0            |
    # ---------------------------------------------------------------------------------------------|
    And Plan line Data and IO status changes as outlined below
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | Property          | Draft Budget | Publ. Budget  | Int appr. Budget   | Clt. appr. Budget | IO Internal Status | IO Supplier Status |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  --           |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|

Scenario: 3. Publish new line, out of two in IO (the other one has already been published before)
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ---------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ---------------------------------------------------------------------------------------------|
      # Draft        | $100         | $20       | $80         | 1       | 2           | 0            |
      # Published    | $100         | $10       | $90         | 1       | 1           | 0            |
      # ---------------------------------------------------------------------------------------------|
    And it contains plan lines as per below:
      # -------------------------------------------------------------------------|
      # Supplier              | Property          | Draft Budget | Publ. Budget  |
      # -------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |
      # -------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  --           |
      # -------------------------------------------------------------------------|
    And I'm on the draft view of the plan
    And I have selected 2nd plan line
  When when I hit "Publish Selected"
  Then Media Plan status remains "Published"
    # ---------------------------------------------------------------------------------------------|
    # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
    # ---------------------------------------------------------------------------------------------|
    # Draft        | $100         | $20       | $80         | 1       | 2           | 0            |
    # Published    | $100         | $20       | $80         | 1       | 2           | 0            |
    # ---------------------------------------------------------------------------------------------|
    And Plan line Data and IO status changes as outlined below
      # -------------------------------------------------------------------------|
      # Supplier              | Property          | Draft Budget | Publ. Budget  |
      # -------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |
      # -------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |
      # -------------------------------------------------------------------------|

# Second time publishes (S4)
Scenario:4.  Publish change of Channel / media type on existing line, only one in IO
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ---------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ---------------------------------------------------------------------------------------------|
      # Draft        | £100         | £10       | £90         | 1       | 1           | 0            |
      # Published    | £100         | £10       | £90         | 1       | 1           | 0            |
      # ---------------------------------------------------------------------------------------------|
    And it contains a plan line as per below:
      # ----------------------------------------------------------------------------------------------------------------------|
      # Supplier         | Property | Draft Channel / Media Type | Publ. Channel / Media Type  | Draft Budget | Publ. Budget  |
      # ----------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | *Display / In-Stream*      | Display / Standard Banners  | £10          |  £10          |
      # ----------------------------------------------------------------------------------------------------------------------|
    And I'm on the draft view of the plan
    And I have selected the plan line
  When when I hit "Publish Selected"
  Then Media Plan status and data remains the same
    And Plan line Data and IO status changes as outlined below
      # ----------------------------------------------------------------------------------------------------------------------|
      # Supplier         | Property | Draft Channel / Media Type | Publ. Channel / Media Type  | Draft Budget | Publ. Budget  |
      # ----------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | *Display / In-Stream*      | *Display / In-Stream*       | £10          |  £10          |
      # ----------------------------------------------------------------------------------------------------------------------|

Scenario: 5. Publish change of Buy type in existing line, out of two in IO (both have been published before)
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ---------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ---------------------------------------------------------------------------------------------|
      # Draft        | £100         | £20       | £80         | 1       | 2           | 0            |
      # Published    | £100         | £20       | £80         | 1       | 2           | 0            |
      # ---------------------------------------------------------------------------------------------|
    And it contains a plan line as per below:
      # ---------------------------------------------------------------------------------------------|
      # Supplier         | Property | Draft Buy Type | Publ. Buy Type | Draft Budget | Publ. Budget  |
      # ---------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | *Direct*       | Biddable       | £10          |  £10          |
      # ---------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | Direct         | Direct         | £10          |  £10          |
      # ---------------------------------------------------------------------------------------------|
    And I'm on the draft view of the plan
    And I have selected the 1st plan line
  When when I hit "Publish Selected"
  Then Media Plan status and data remains the same
    And Plan line Data and IO status changes as outlined below
    # ----------------------------------------------------------------------------------------------|
    # Supplier         | Property | Draft Buy Type | Publ. Buy Type  | Draft Budget | Publ. Budget  |
    # ----------------------------------------------------------------------------------------------|
    # Ebuzzing Inc     | Teads    | Direct         | Direct          | £10          |  £10          |
    # ----------------------------------------------------------------------------------------------|
    # Ebuzzing Inc     | Teads    | Direct         | Direct          | £10          |  £10          |
    # ----------------------------------------------------------------------------------------------|

Scenario: 6. Publish change in Cost model of existing line, out of two in IO (only this one has been published before)
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ---------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ---------------------------------------------------------------------------------------------|
      # Draft        | £100         | £20       | £80         | 1       | 2           | 0            |
      # Published    | £100         | £10       | £90         | 1       | 1           | 0            |
      # ---------------------------------------------------------------------------------------------|
    And it contains a plan line as per below:
      # ------------------------------------------------------------------------------------------------|
      # Supplier         | Property | Draft Cost Model| Publ. Cost Model | Draft Budget | Publ. Budget  |
      # ------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | *Fixed CPM*     | Fixed CPC        | £10          |  £10          |
      # ------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | Direct          | --               | £10          |  --           |
      # ------------------------------------------------------------------------------------------------|
    And I'm on the draft view of the plan
    And I have selected the 1st plan line
  When when I hit "Publish Selected"
  Then Media Plan status and data remains the same
    And Plan line Data and IO status changes as outlined below
    # ------------------------------------------------------------------------------------------------|
    # Supplier         | Property | Draft Cost Model| Publ. Cost Model | Draft Budget | Publ. Budget  |
    # ------------------------------------------------------------------------------------------------|
    # Ebuzzing Inc     | Teads    | *Fixed CPM*     | Fixed CPM        | £10          |  £10          |
    # ------------------------------------------------------------------------------------------------|
    # Ebuzzing Inc     | Teads    | Direct          | --               | £10          |  --           |
    # ------------------------------------------------------------------------------------------------|

# publish one with meta data changes (S3)
# plan: local impact: Manager
Scenario: 7. Publish downweight with changed Plan manager
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ------------------------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Managed By   | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ------------------------------------------------------------------------------------------------------------|
      # Draft        | $100         | *{Yourself}* | *$10*     | *$90*       | 1       | 1           | 0            |
      # Published    | $100         | Zanete Ence  | $50       | $50         | 1       | 1           | 0            |
      # ------------------------------------------------------------------------------------------------------------|
    And it contains a plan line as per below:
      # ----------------------------------------------------------------|
      # Supplier              | Property | Draft Budget | Publ. Budget  |
      # ----------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN      | *$10*          |  $50        |
      # ----------------------------------------------------------------|
    And I'm on the plan line edit form
  When I hit Save & Publish
  Then User is asked to confirm Meta Data change publishing (the rest assumes they have confirmed)
    And Media Plan status remains to "Published" and data updates as outlined below:
      # ------------------------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Managed By   | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ------------------------------------------------------------------------------------------------------------|
      # Draft        | $100         | {Yourself}   | $10       | $90         | 1       | 1           | 0            |
      # Published    | $100         | {Yourself}   | $10       | $90         | 1       | 1           | 0            |
      # ------------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # ----------------------------------------------------------------|
      # Supplier              | Property | Draft Budget | Publ. Budget  |
      # ----------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN      | $10          |  $10          |
      # ----------------------------------------------------------------|

# publish one with meta data changes (S2)
# plan: reporting/client impact: Market - have a feeling these shouldn't be so easily changeable
Scenario: 8. Publish one downweight in multiple line changes with changed Market
 Given I have set up a media plan
   And it's in a "Published" state as outlined below:
     # ---------------------------------------------------------------------------------------------------------------|
     # Version      | Total Budget | Market           | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines |
     # ---------------------------------------------------------------------------------------------------------------|
     # Draft        | $100         | *United Kingdom* | *$55*     | *$45*       | 1       | 3           | 0           |
     # Published    | $100         | Ukraine          | $40       | $60         | 1       | 3           | 0           |
     # ---------------------------------------------------------------------------------------------------------------|
   And it contains a plan line as per below:
     # ----------------------------------------------------------------|
     # Supplier              | Property | Draft Budget   | Publ. Budget|
     # ----------------------------------------------------------------|
     # Google Ireland Ltd.   | GDN      | *$30*          |   $5        |
     # Google Ireland Ltd.   | GDN      | *$10*          |  $20        |
     # Google Ireland Ltd.   | GDN      | $15            |  $15        |
     # ----------------------------------------------------------------|
     #                                    $55               $40
     And I'm on the plan line edit form of the second line
  When I hit Save & Publish
  Then User is asked to confirm Meta Data change publishing (the rest assumes they have confirmed)
    And Media Plan status remains to "Published" and data updates as outlined below:
      # ---------------------------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Market           | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines |
      # ---------------------------------------------------------------------------------------------------------------|
      # Draft        | $100         | United Kingdom   | *$55*     | *$45*       | 1       | 3           | 0           |
      # Published    | $100         | United Kingdom   | $30       | $70         | 1       | 3           | 0           |
      # ---------------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # ----------------------------------------------------------------|
      # Supplier              | Property | Draft Budget   | Publ. Budget|
      # ----------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN      | *$30*          |   $5        |
      # Google Ireland Ltd.   | GDN      | $10            |  $10        |
      # Google Ireland Ltd.   | GDN      | $15            |  $15        |
      # ----------------------------------------------------------------|
      #                                    $55               $30`

# publish multiple with meta data changes (S3)
# plan: local impact: label
Scenario: 9. Publish multiple lines with changed MP Label
 Given I have set up a media plan
   And it's in a "Published" state as outlined below:
     # ----------------------------------------------------------------------------------------------------------|
     # Version      | Total Budget | Label       | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines |
     # ----------------------------------------------------------------------------------------------------------|
     # Draft        | $100         | *Awareness* | *$95*     |  *$5*       | 1       | 4           | 0           |
     # Published    | $100         | Brand       | $80       | $20         | 1       | 4           | 0           |
     # ----------------------------------------------------------------------------------------------------------|
   And it contains a plan line as per below:
     # ----------------------------------------------------------------|
     # Supplier              | Property | Draft Budget   | Publ. Budget|
     # ----------------------------------------------------------------|
     # Google Ireland Ltd.   | GDN      | *$25*          |  $20        |
     # Google Ireland Ltd.   | GDN      | *$10*          |  $20        |
     # Google Ireland Ltd.   | GDN      | *$40*          |  $20        |
     # Google Ireland Ltd.   | GDN      |  $20           |  $20        |
     # ----------------------------------------------------------------|
     #                                    $95               $80
    And I'm on the draft view of the plan
    And I have selected the first 2 lines
  When I hit Publish Selected
  Then User is asked to confirm Meta Data change publishing (the rest assumes they have confirmed)
    And Media Plan status remains to "Published" and data updates as outlined below:
      # ---------------------------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Label            | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines |
      # ---------------------------------------------------------------------------------------------------------------|
      # Draft        | $100         | Awareness        | *$95*     |  *$5*       | 1       | 4           | 0           |
      # Published    | $100         | Awareness        |  $75      | $25         | 1       | 4           | 0           |
      # ---------------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # ----------------------------------------------------------------|
      # Supplier              | Property | Draft Budget   | Publ. Budget|
      # ----------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN      |  $25           |  $25        |
      # Google Ireland Ltd.   | GDN      |  $10           |  $10        |
      # Google Ireland Ltd.   | GDN      | *$40*          |  $20        |
      # Google Ireland Ltd.   | GDN      |  $20           |  $20        |
      # ----------------------------------------------------------------|
      #                                    $95               $75

# publish multiple with meta data changes (S2)
# plan: reporting/client impact: KPI Type   - have a feeling these shouldn't be so easily changeable
Scenario: 10. Publish Multiple with changed KPI Type
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ----------------------------------------------------------------------------------------------------------|
      # Version      | Total Budget | KPI Type    | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines |
      # ----------------------------------------------------------------------------------------------------------|
      # Draft        | $100         | *DR*        | $80       | $20         | 1       | 4           | 0           |
      # Published    | $100         | Brand       | $80       | $20         | 1       | 4           | 0           |
      # ----------------------------------------------------------------------------------------------------------|
    And it contains a plan line as per below:
      # ----------------------------------------------------------------|
      # Supplier              | Property | Draft Budget   | Publ. Budget|
      # ----------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN      | *$30*          |  $20        |
      # Google Ireland Ltd.   | GDN      | *$10*          |  $20        |
      # Google Ireland Ltd.   | GDN      | *$40*          |  $20        |
      # Google Ireland Ltd.   | GDN      |  *$0*          |  $20        |
      # ----------------------------------------------------------------|
      #                                     $80              $80
     And I'm on the draft view of the plan
     And I have selected the first 2 lines
   When I hit Publish Selected
   Then User is asked to confirm Meta Data change publishing (the rest assumes they have confirmed)
     And Media Plan status remains to "Published" and data updates as outlined below:
       # ----------------------------------------------------------------------------------------------------------|
       # Version      | Total Budget | KPI Type    | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines |
       # ----------------------------------------------------------------------------------------------------------|
       # Draft        | $100         | DR          | $80       | $20         | 1       | 4           | 0           |
       # Published    | $100         | DR          | $80       | $20         | 1       | 4           | 0           |
       # ----------------------------------------------------------------------------------------------------------|
     And Individual Plan line Data change as outlined below
       # ----------------------------------------------------------------|
       # Supplier              | Property | Draft Budget   | Publ. Budget|
       # ----------------------------------------------------------------|
       # Google Ireland Ltd.   | GDN      |  $30           |  $30        |
       # Google Ireland Ltd.   | GDN      |  $10           |  $10        |
       # Google Ireland Ltd.   | GDN      | *$40*          |  $20        |
       # Google Ireland Ltd.   | GDN      |  *$0*          |  $20        |
       # ----------------------------------------------------------------|
       #                                     $80              $80


# illegal changes
# exceeds total budget (S1)
Scenario: 11. Publish a move causing an exceeded budget on selective publish
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | *£95*     | *£5*        | 20%      | 1      | 3           | 0            |
      # Published     | £100         | £100      |  £0         | 20%      | 1      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And it contains 3 plan line below:
      # --------------------------------------------------------------------------------------|
      # Supplier         | Property      | Draft Budget | Publ. Budget  | Status              |
      # --------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads         | *£35*        | £40           | Internally Approved |
      # Ebuzzing Inc     | Teads         | *£50*        | £40           | Internally Approved |
      # Ebuzzing Inc     | Teads         | *£10*        | £20           | Internally Approved |
      # --------------------------------------------------------------------------------------|
      #                                  |  £95         | £100
    And I'm on the draft view of the plan
    And I have selected the first two lines
  When when I hit "Publish Selected"
  Then I get an error saying the Planned amount exceeds Total Budget

Scenario: 12. Publish a move causing an upweight exceeding original published budget but with total budget increase to make up for it
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | *£105*       | *£95*     | *£5*        | 20%      | 1      | 3           | 0            |
      # Published     |  £100        | £100      |  £0         | 20%      | 1      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And it contains 3 plan line below:
      # --------------------------------------------------------------------------------------|
      # Supplier         | Property      | Draft Budget | Publ. Budget  | Status              |
      # --------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads         | *£35*        | £40           | Internally Approved |
      # Ebuzzing Inc     | Teads         | *£50*        | £40           | Internally Approved |
      # Ebuzzing Inc     | Teads         | *£10*        | £20           | Internally Approved |
      # --------------------------------------------------------------------------------------|
      #                                  |  £95         | £100
    And I'm on the draft view of the plan
    And I have selected the first two lines
  When when I hit "Publish Selected"
  Then User is asked to confirm Meta Data change publishing (the rest assumes they have confirmed)
    And Media Plan status remains to "Published" and data updates as outlined below:
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £105         | *£95*     | *£5*        | 20%      | 1      | 3           | 0            |
      # Published     | £100         | £100      |  £0         | 20%      | 1      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # --------------------------------------------------------------------------------------|
      # Supplier         | Property      | Draft Budget | Publ. Budget  | Status              |
      # --------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads         |  £35         | £35           | Published           |
      # Ebuzzing Inc     | Teads         |  £50         | £50           | Published           |
      # Ebuzzing Inc     | Teads         | *£10*        | £20           | Published           |
      # --------------------------------------------------------------------------------------|
      #                                  |  £95         | £105

# Internally approved
# publish one with line breaches internally (S1) -
# internal: less discount
Scenario: 13. Publish a discount decrease causing an upweight after Internal Approval
  Given I have set up a media plan
    And it's in an "Internally Approved" state as outlined below:
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | *£90*     | *£10*       | 20%      | 1      | 1           | 0            |
      # Published     | £100         |  £85      |  £15        | 20%      | 1      | 1           | 0            |
      # Int. Approved | £100         |  £85      |  £15        | 20%      | 1      | 1           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And it contains a plan line below:
      # --------------------------------------------------------------------------------------------------------------------------------|
      # Supplier         | Property | Draft Gross Budget | Draft Discount | Publ. Gross Budget  | Publ. Discount  | Status              |
      # --------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | £100               | *10%*          | £100                |  15%            | Internally Approved |
      # --------------------------------------------------------------------------------------------------------------------------------|
    And I'm on the details panel of the plan line
  When when I hit "Save & Publish"
  Then Media Plan status changes to "Published"
    And Plan Data updates as outlined below
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | £90       | £10         | 20%      | 1      | 1           | 0            |
      # Published     | £100         | £90       | £10         | 20%      | 1      | 1           | 0            |
      # Int. Approved | £100         | £90       | £10         | 20%      | 1      | 1           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # --------------------------------------------------------------------------------------------------------------------------------|
      # Supplier         | Property | Draft Gross Budget | Draft Discount | Publ. Gross Budget  | Publ. Discount  | Status              |
      # --------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads    | £100               | 10%            | £100                |  10%            | Amends Published    |
      # --------------------------------------------------------------------------------------------------------------------------------|

# publish multiple with line breaches internally (S1)
# internal: move between props
Scenario: 14. Publish a move within IO causing an upweight for internal re-approval
  Given I have set up a media plan
    And it's in an "Internally Approved" state as outlined below:
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | *£90*     | *£10*       | 20%      | 2      | 3           | 0            |
      # Published     | £100         | £100      |  £0         | 20%      | 2      | 3           | 0            |
      # Int. Approved | £100         | £100      |  £0         | 20%      | 2      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And it contains 3 plan line below:
      # ----------------------------------------------------------------------------------------------------------|
      # Supplier         | Property      | Draft Budget | Publ. Budget  | Int. appr. Budget | Status              |
      # ----------------------------------------------------------------------------------------------------------|
      # Aol UK Ltd       | TechCrunch    | *£35*        | £50           | £50               | Internally Approved |
      # Aol UK Ltd       | About.me      | *£45*        | £30           | £30               | Internally Approved |
      # ----------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads         | *£10*        | £20           | £20               | Internally Approved |
      # ----------------------------------------------------------------------------------------------------------|
      #                                  |  £90         | £100          | £100
    And I'm on the draft view of the plan
    And I have selected all 3 lines
  When when I hit "Publish Selected"
  Then I get an warning saying that Internal approval will be breached (?) (£5 upweight for supplier / property is enough to require re-approval)
  Then Media Plan status remains "Published"
    And Plan Data changes as outlined below
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | £90       | £10         | 20%      | 2      | 3           | 0            |
      # Published     | £100         | £90       | £10         | 20%      | 2      | 3           | 0            |
      # Int. Approved | £100         | £95       |  £5         | 20%      | 2      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # ----------------------------------------------------------------------------------------------------------|
      # Supplier         | Property      | Draft Budget | Publ. Budget  | Int. appr. Budget | Status              |
      # ----------------------------------------------------------------------------------------------------------|
      # Aol UK Ltd       | TechCrunch    | £35          |  £35          | £35               | Amends Published    | # downweight auto-approved
      # Aol UK Ltd       | About.me      | £45          | *£45*         | £40               | Amends Published    | # upweight needs re-approval
      # ----------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc     | Teads         | £10          | £10           | £10               | Internally Approved | # downweight auto-approved
      # ----------------------------------------------------------------------------------------------------------|
      #                                  |  £90         | £90           | £85

Scenario: 15. Publish a move within DBM IO not causing a breach
  Given I have set up a media plan
    And it's in an "Internally Approved" state as outlined below:
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | *£90*     | *£10*       | 20%      | 1      | 3           | 0            |
      # Published     | £100         | £100      |  £0         | 20%      | 1      | 3           | 0            |
      # Int. Approved | £100         | £100      |  £0         | 20%      | 1      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And it contains 3 plan line below:
      # --------------------------------------------------------------------------------------------------------------------|
      # Supplier            | Platform | Property  | Draft Budget | Publ. Budget  | Int. appr. Budget | Status              |
      # --------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd  | DBM      | ESPN      | *£35*        | £50           | £50               | Internally Approved |
      # Google Ireland Ltd  | DBM      | Telegraph | *£45*        | £30           | £30               | Internally Approved |
      # Google Ireland Ltd  | DBM      | Guardian  | *£10*        | £20           | £20               | Internally Approved |
      # --------------------------------------------------------------------------------------------------------------------|
      #                                            |  £90         | £100          | £100
    And I'm on the draft view of the plan
    And I have selected all 3 lines
  When when I hit "Publish Selected"
  Then Media Plan status remains "Internally Approved"
    And Plan Data is updated as outlined below
      # --------------------------------------------------------------------------------------------------------|
      # Version       | Total Budget | Allocated | Unallocated | Breach % |Num IOs | Num M Lines | Num S lines  |
      # --------------------------------------------------------------------------------------------------------|
      # Draft         | £100         | £90       | £10         | 20%      | 1      | 3           | 0            |
      # Published     | £100         | £90       | £10         | 20%      | 1      | 3           | 0            |
      # Int. Approved | £100         | £90       | £10         | 20%      | 1      | 3           | 0            |
      # --------------------------------------------------------------------------------------------------------|
    And Individual Plan line Data change as outlined below
      # --------------------------------------------------------------------------------------------------------------------|
      # Supplier            | Platform | Property  | Draft Budget | Publ. Budget  | Int. appr. Budget | Status              |
      # --------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd  | DBM      | ESPN      | £35          | £35           | £35               | Internally Approved |
      # Google Ireland Ltd  | DBM      | Telegraph | £45          | £45           | £45               | Internally Approved |
      # Google Ireland Ltd  | DBM      | Guardian  | £10          | £10           | £10               | Internally Approved |
      # --------------------------------------------------------------------------------------------------------------------|
      #                                            | £90          | £90           | £90

# CLIENT APPROVAL REQUESTED @todo
Scenario: 16. Publish no impact changes
  #appear in all versions immediatelly
Scenario: 17. Publish internal approval breaching changes
  #appear in client version after internal approval
Scenario: 18. Publish client approval breaching changes
  #clients are no longer required to re-approve

# CLIENT APPROVED
# publish one with notifications to clients (S2)
# plan: total budget downweight, dates, breach thresholds, initiative (!not on publish)
# line, cancels, deletes
Scenario: 19. Publish deleted line with Total Budget Downweight
Scenario: 20. Publish cancelled IO with Plan end date extended (multiple notifications for Client)
Scenario: 21. Publish change in unkown budget flag with updated breach thresholds

# publish multiple with notifications (S2)
# plan: dates, total budget downweight, breach thresholds, initiative (!not on publish)
# line: cancels, deletes
Scenario: 22. Publish multiple deleted lines with Total budget downweight
Scenario: 23. Publish multiple downweights to 0 with Plan Start Date set earlier
Scenario: 24. Publish property change (cancelling but not adding) with breach threshold change

# publish one with line upweight breaching client approval (S1)
Scenario: 25. Publish one major upweight after Client approval
Scenario: 26. Publish new property after Client approval

# publish multiple lines with breacheing client approval (S1)
Scenario: 27. Publish multiple minor upweights breaching client approval

# publish one with breaching meta data (S1)
# plan: Total budget,
# line: dates, new property
Scenario: 28. Publish total budget increase with single line date change publish
  #notification that meta has changed
  #notification that breaching client approval
Scenario: 29. Publish new property with total budget increase

# publish multiple with breaching meta data (S1)
# plan: Total budget,
# line: dates, description
Scenario: 30. Publish total budget increase with multiple line description publish
Scenario: 31. Publish multiple lines for new property with total budget increase

# publish one with IO level attribute changes
# local impact: Notes, owner (S4)
# finace/client impact: Currency, Liable Entity (S2)
Scenario: 32. Publish line with Liable change on IO (2)
Scenario: 33. Publish line line with Liable Entity change on the line itself (2)
  #new io
Scenario: 34. Publish change of description of line in IO with Liable Entity change in other line in IO (2)

# publish all in IO with IO level attribute changes (local impact) (S2)
# local impact: Notes, owner (S4)
# finace/client impact: Currency, Liable Entity (S2)
Scenario: 35. Publish existing line, out of two in IO, after changing Currency in both
Scenario: 36. Publish existing line, out of two in IO, after changing Currency in this one
Scenario: 37. Publish existing line, out of two in IO, after changing Currency in this one


# service lines @todo
# unknown budget @todo
# downweight below invoiced (S1) @todo
# Internal approval requested @todo
