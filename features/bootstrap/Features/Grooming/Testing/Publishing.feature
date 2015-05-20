# S1 - S4 = severity
# if these fail we have a problem 1 - big, 4 - small

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
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Supplier              | Property          | Draft Budget | Publ. Budget  | Int appr. Budget   | Clt. appr. Budget | IO Internal Status | IO Supplier Status |
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Google Ireland Ltd.   | GDN               | $10          |  --           |  --                |  --               | Draft              | Not Confirmed      |
    # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
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
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | Property          | Draft Budget | Publ. Budget  | Int appr. Budget   | Clt. appr. Budget | IO Internal Status | IO Supplier Status |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|

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
  # Number of IOs: 1
  # Number of lines: 2
  Given I have set up a media plan
    And it's in a "Published" state as outlined below:
      # ---------------------------------------------------------------------------------------------|
      # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num S lines  |
      # ---------------------------------------------------------------------------------------------|
      # Draft        | $100         | $20       | $80         | 1       | 2           | 0            |
      # Published    | $100         | $10       | $90         | 1       | 1           | 0            |
      # ---------------------------------------------------------------------------------------------|
    And it contains plan lines as per below:
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | Property          | Draft Budget | Publ. Budget  | Int appr. Budget   | Clt. appr. Budget | IO Internal Status | IO Supplier Status |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  --           |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
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
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | Property          | Draft Budget | Publ. Budget  | Int appr. Budget   | Clt. appr. Budget | IO Internal Status | IO Supplier Status |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | GDN               | $10          |  $10          |  --                |  --               | Published          | Not Confirmed      |
      # ------------------------------------------------------------------------------------------------------------------------------------------------------------|

# Second time publishes (S4)
Scenario: Publish change of Channel / media type on existing line, only one in IO
Scenario: Publish change of Buy type in existing line, out of two in IO (both have been published before)
Scenario: Publish change in Cost model of existing line, out of two in IO (only this one has been published before)

# service lines
# unknown budget

# publish one with meta data changes (S3)
# plan: local impact: Manager, label (S3)
# plan: reporting/client impact: Market, KPI Type  (S2) - have a feeling these shouldn't be so easily changeable
# line: downweights

# publish multiple with meta data changes
# plan: local impact: Manager, label (S3)
# plan: reporting/client impact: Market, KPI Type  (S2) - have a feeling these shouldn't be so easily changeable
# line: downweights

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
