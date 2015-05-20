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
Scenario: Publish new line, only one in IO
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

Scenario: Publish new Line, out of two, never published IO
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

Scenario: Publish new line, out of two in IO (the other one has already been published before)
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
Scenario: Publish change of Channel / media type on existing line, only one in IO
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

Scenario: Publish change of Buy type in existing line, out of two in IO (both have been published before)
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

Scenario: Publish change in Cost model of existing line, out of two in IO (only this one has been published before)
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

# service lines
# unknown budget

# publish one with meta data changes (S3)
# plan: local impact: Manager (S3)
# plan: reporting/client impact: Market  (S2) - have a feeling these shouldn't be so easily changeable
# line: downweights
Scenario: Publish downweight with changed Plan manager
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

Scenario: Publish one downweight in multiple line changes with changed Market
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

# publish multiple with meta data changes
# plan: local impact: label (S3)
# plan: reporting/client impact: KPI Type  (S2) - have a feeling these shouldn't be so easily changeable
# line: downweights
Scenario: Publish multiple lines with changed MP Label
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

Scenario: Publish Multiple with changed KPI Type
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


# publish one with notifications (S2)
# plan: dates, total budget downweight
# line, cancels, deletes

# publish multiple with notifications (S2)
# plan: dates, total budget downweight
# line: cancels, deletes

# publish one with line breaches (S1)
# internal: less discount
# client: upweight

# publish multiple with line breaches (S1)
# internal: less discount
# client: upweight

# publish one with breaching meta data (S1)
# plan: Total budget,
# line: dates, description

# publish multiple with breaching meta data (S1)
# plan: Total budget,
# line: dates, description

# publish one with IO level attribute changes
# local impact: Notes, owner (S4)
# finace/client impact: Currency, Liable Entity (S2)
Scenario: Publish line with Liable change on IO (2)
Scenario: Publish line line with Currency change on the line itself (2)
  #new io
Scenario: Publish change of description of line in IO with Currency change in other line in IO (2)

# publish all in IO with IO level attribute changes (local impact) (S2)
# local impact: Notes, owner (S4)
# finace/client impact: Currency, Liable Entity (S2)
Scenario: Publish existing line, out of two in IO, after changing Currency in both
Scenario: Publish existing line, out of two in IO, after changing Currency in this one
Scenario: Publish existing line, out of two in IO, after changing Currency in this one
