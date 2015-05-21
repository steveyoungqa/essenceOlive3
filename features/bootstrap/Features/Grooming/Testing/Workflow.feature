Scenario: New Property
  Given A Media Plan of a "$100" is "Client Approved"
    And it has two Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ===================================================================================================================
    # AOL         | $30       | TechCrunch  | Internally Approved | Confirmed           | $30          | $30            |
    # ------------------------------------------------------------------------------------------------------------------
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
    And I have added a new Property "Last Fm" for "$5" into Draft version for "AOL" Insertion Order
  When I publish these changes
  Then the Media Plan Status changes to "Published"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ===================================================================================================================
    # AOL         | $30       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
    #             | $5        | Last.Fm     |                     |                     | --           | --             |
    # ------------------------------------------------------------------------------------------------------------------|
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

  Scenario: Internally Approving New Property
    Given A Media Plan of a "$100" is "Published" after a new Poperty Breach
      And it has two Insertion orders as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $30       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
      #             | $5        | Last.Fm     |                     |                     | --           | --             |
      # ------------------------------------------------------------------------------------------------------------------|
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
      And I request Internal Approval of "AOL" Insertion Order
    When Internal Approver approves the Insertion Order
    Then the Media Plan Status changes "Internally Approved" #as there are no other IOs that aren't in that state
      And Insertion Order statuses and budgets are as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $30       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
      #             | $5        | Last.Fm     |                     |                     |  $5          | --             |
      # ------------------------------------------------------------------------------------------------------------------|
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

  Scenario: Internally Rejecting New Property
    Given A Media Plan of a "$100" is "Published" after a new Poperty Breach
      And it has two Insertion orders as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $30       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
      #             | $5        | Last.Fm     |                     |                     | --           | --             |
      # ------------------------------------------------------------------------------------------------------------------|
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
      And I request Internal Approval of "AOL" Insertion Order
    When Internal Approver rejectes the changes
    Then the Media Plan Status changes "Internally Rejected" #??? does it? or is it published? @zanete to confirm with indicator behaviour
      And Insertion Order statuses and budgets are as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $30       | TechCrunch  | Internally Rejected | Not Confirmed       | $30          | $30            |
      #             | $5        | Last.Fm     |                     |                     | --           | --             |
      # ------------------------------------------------------------------------------------------------------------------|
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

  Scenario: Client Approving New Property
    Given A Media Plan of a "$100" is "Internally Approved" after a new Poperty Breach
      And it has two Insertion orders as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $30       | TechCrunch  | Internally Approved | Not Confirmed       | $30          | $30            |
      #             | $5        | Last.Fm     |                     |                     |  $5          | --             |
      # ------------------------------------------------------------------------------------------------------------------|
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
      And I request Client Re-Approval of the Plan
    When All Plan approvers approve the Plan
    Then the Media Plan Status changes "Client Approved"
      And Insertion Order statuses and budgets are as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $30       | TechCrunch  | Internally Approved | Not Confirmed       | $30          | $30            |
      #             | $5        | Last.Fm     |                     |                     |  $5          |  $5            |
      # ------------------------------------------------------------------------------------------------------------------|
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

    Scenario: Client Rejects New Property
      Given A Media Plan of a "$100" is "Internally Approved" after a new Poperty Breach
        And it has two Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ===================================================================================================================
        # AOL         | $30       | TechCrunch  | Internally Approved | Not Confirmed       | $30          | $30            |
        #             | $5        | Last.Fm     |                     |                     |  $5          | --             |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Client Re-Approval of the Plan
      When a Client approver rejects the Plan
      Then the Media Plan Status changes "Client Rejected"
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ===================================================================================================================
        # AOL         | $30       | TechCrunch  | Internally Approved | Not Confirmed       | $30          | $30            |
        #             | $5        | Last.Fm     |                     |                     |  $5          | --             |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


Scenario: Breaching Upweight
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has two Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================|=================================
    # AOL         | $30       | TechCrunch  | Internally Approved |  Confirmed          | $30          | $30            |
    # Channel 5   | $10       | Channel 5   | Internally Approved |  Confirmed          | $10          | $10            |
    And I have upweighted a line in "AOL" Insertion Order by $30
  When I publish these changes
  Then the Media Plan Status changes to "Published"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ===================================================================================================================
    # AOL         | $60       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

  Scenario: Internally Approving Breaching Upweight
    Given A Media Plan of a "$100" is "Published" after a "Breach"
      And it has two Insertion orders as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $60       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
      And I request Internal Approval of "AOL" Insertion Order
    When Internal Approver approves the Insertion Order
    Then the Media Plan Status changes "Internally Approved" #as there are no other IOs that aren't in that state
      And Insertion Order statuses and budgets are as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $60       | TechCrunch  | Internally Approved | Not confirmed       | $60          | $30            |
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


    Scenario: Internally Rejecting a Breaching Upweight
      Given A Media Plan of a "$100" is "Published" after a "Breach"
        And it has two Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ===================================================================================================================
        # AOL         | $60       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Internal Approval of "AOL" Insertion Order
      When Internal Approver rejects the Insertion Order
      Then the Media Plan Status changes "Published" #???? does it
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ===================================================================================================================
        # AOL         | $60       | TechCrunch  | Internally Rejected | Not confirmed       | $60          | $30            |
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

  Scenario: Client Approving Breaching Upweight
    Given A Media Plan of a "$100" is "Internally Approved" after a "Breach"
      And it has two Insertion orders as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $60       | TechCrunch  | Internally Approved | Not confirmed       | $60          | $30            |
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
      And I request Client re-approval of Plan
    When all Client Approvers approve Plan
    Then the Media Plan Status changes "Client Approved"
      And Insertion Order statuses and budgets are as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $60       | TechCrunch  | Internally Approved | Not confirmed       | $60          | $60            |
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


  Scenario: Client Rejecting Breaching Upweight
    Given A Media Plan of a "$100" is "Internally Approved" after a "Breach"
      And it has two Insertion orders as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $60       | TechCrunch  | Internally Approved | Not confirmed       | $60          | $30            |
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
      And I request Client re-approval of Plan
    When a Client Approver rejects the Plan
    Then the Media Plan Status changes "Client Rejected"
      And Insertion Order statuses and budgets are as outlined below
      # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
      # ===================================================================================================================
      # AOL         | $60       | TechCrunch  | Internally Approved | Not confirmed       | $60          | $30            |
      # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


Scenario: Upweight / Downweight with no effect on approval status
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has 3 Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Confirmed           | $30          | $30            |
    # AOL         | $30       | TechCrunch  | Internally Approved | Confirmed           | $30          | $30            |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
    And I have upweighted a line in 1st "AOL" Insertion Order by $20
    And I have downweighted a line in 2nd "AOL" Insertion Order by $20
    #the total change for supplier / property is 0$ - no client or internal re-approval required, just supplier confirmation
  When I publish these changes
  Then the Media Plan Status remains to "Client Approved"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================================================|
    # AOL         | $50       | TechCrunch  | Internally Approved | Not confirmed       | $50          | $50            |
    # AOL         | $10       | TechCrunch  | Internally Approved | Not confirmed       | $10          | $10            |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


# WIERD ONE - what to do with the downweighted IO @helen, all of a sudden the unallocated ight appear bigger in client view
# I think KJ built it so that both IOs should be re-approved but should confirm
# - what if one is approved but the other is still pending (or worse rejected) - could result in appearing as exceeding total budget
Scenario: Upweight / Downweight with Internal Re-approval
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has 3 Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Confirmed           | $30          | $30            |
    # AOL         | $30       | TechCrunch  | Internally Approved | Confirmed           | $30          | $30            |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
    And I have upweighted a line in 1st "AOL" Insertion Order by $25
    And I have downweighted a line in 2nd "AOL" Insertion Order by $10
    #the total change for supplier / property is only 15$ - not breaching but upweight requires internal re-approval
  When I publish these changes
  Then the Media Plan Status remains to "Client Approved"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================================================|
    # AOL         | $55       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
    # AOL         | $20       | TechCrunch  | Published    ??     | Not confirmed       | $30 ??       | $30 ??         |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

    Scenario: Internally approve minor Upweight / Downweight
      Given A Media Plan of a "$100" is "Client Approved"
        And I have set the breach threshold to be "20%"
        And it has 3 Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
        # AOL         | $20       | TechCrunch  | Published    ??     | Not confirmed       | $30 ??       | $30 ??         |
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Internal Approval of 1st "AOL" Insertion Order
      When Internal Approver approves the Insertion Order
      Then the Media Plan Status remains "Client Approved"
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Approved | Not confirmed       | $55          | $50            |
        # AOL         | $20       | TechCrunch  | Published    ??     | Not confirmed       | $30 ??       | $30 ??         |
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

    Scenario: Internally reject minor Upweight / Downweight
      Given A Media Plan of a "$100" is "Client Approved"
        And I have set the breach threshold to be "20%"
        And it has 3 Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
        # AOL         | $20       | TechCrunch  | Published    ??     | Not confirmed       | $30 ??       | $30 ??         |
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Internal Approval of 2nd "AOL" Insertion Order
      When Internal Approver rejects the changes
      Then the Media Plan Status remains "Client Approved"
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Published           | Not confirmed       | $30          | $30            |
        # AOL         | $20       | TechCrunch  | Internally Rejected | Not confirmed       | $30          | $30            |
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


Scenario: Breaching Move within IO
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has 2 Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Confirmed           | $30          | $30            |
    #             | $30       | Last.Fm     |                     |                     | $30          | $30            |
    # ------------------------------------------------------------------------------------------------------------------|
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
    And I have upweighted a "TechCrunch" line by "$25"
    And I have downweighted "LastFM" line by "$25"
    #the total of iO remains unchanged but breaching thresholds for supplier / property
    #- requires internal re-approval and client re-approval
  When I publish these changes
  Then the Media Plan Status changes to "Published"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
    # ==================================================================================================================|
    # AOL         | $55       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
    #             |  $5       | Last.Fm     |                     |                     | $30          | $30            |
    # ------------------------------------------------------------------------------------------------------------------|
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

    Scenario: Internally Approving a Breaching move within IO
      Given A Media Plan of a "$100" is "Published" after a Breaching move within IO
        And I have set the breach threshold to be "20%"
        And it has 2 Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
        #             |  $5       | Last.Fm     |                     |                     | $30          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Internal Approval of "AOL" Insertion Order
      When Internal Approver approves the Insertion Order
      Then the Media Plan Status changes "Internally Approved" # as there are no IOs in other status
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Approved | Not Confirmed       | $55          | $30            |
        #             |  $5       | Last.Fm     |                     |                     |  $5          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |


    Scenario: Internally Rejecting a Breaching move within IO
      Given A Media Plan of a "$100" is "Published" after a breaching move within IO
        And I have set the breach threshold to be "20%"
        And it has 2 Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Published           | Not Confirmed       | $30          | $30            |
        #             |  $5       | Last.Fm     |                     |                     | $30          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Internal Approval of "AOL" Insertion Order
      When Internal Approver rejects the Insertion Order
      Then the Media Plan Status remains "Published"
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Rejected | Not Confirmed       | $30          | $30            |
        #             |  $5       | Last.Fm     |                     |                     | $30          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

    Scenario: Client Approving a Breaching move within IO
      Given A Media Plan of a "$100" is "Internally Approved" after a breaching move within IO
        And I have set the breach threshold to be "20%"
        And it has 2 Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Approved | Not Confirmed       | $55          | $30            |
        #             |  $5       | Last.Fm     |                     |                     |  $5          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Client re-approval of Plan
      When all Client Approvers approve Plan
      Then the Media Plan Status changes "Client Approved"
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Approved | Not Confirmed       | $55          | $55            |
        #             |  $5       | Last.Fm     |                     |                     |  $5          |  $5            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

    Scenario: Client Rejecting a Breaching move within IO
      Given A Media Plan of a "$100" is "Internally Approved" after a breaching move within IO
        And I have set the breach threshold to be "20%"
        And it has 2 Insertion orders as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Approved | Not Confirmed       | $55          | $30            |
        #             |  $5       | Last.Fm     |                     |                     |  $5          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |
        And I request Client re-approval of Plan
      When all Client Approvers approve Plan
      Then the Media Plan Status remains "Client Rejected"
        And Insertion Order statuses and budgets are as outlined below
        # Supplier    | Total net | Property    | Internal Status     | Supplier Status     | Int. appr.v. | Client appr.v. |
        # ==================================================================================================================|
        # AOL         | $55       | TechCrunch  | Internally Approved | Not Confirmed       | $55          | $30            |
        #             |  $5       | Last.Fm     |                     |                     |  $5          | $30            |
        # ------------------------------------------------------------------------------------------------------------------|
        # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           | $10          | $10            |

# TO BE CONTINUED

Scenario: Upweight / Downweight with localised impact (only 2 out of 3 IOs)
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has 3 Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Supplier Confirmed  |
    # AOL         | $30       | TechCrunch  | Internally Approved | Supplier Confirmed  |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |
    And I have upweighted a line in 1st "AOL" Insertion Order by $20
    And I have downweighted a line in 2nd "AOL" Insertion Order by $20
    #the total change for supplier / property is 0$ - no client or internal re-approval required, just supplier confirmation
  When I publish these changes
  Then the Media Plan Status remains to "Client Approved"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Not confirmed       |
    # AOL         | $30       | TechCrunch  | Internally Approved | Not confirmed       |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |


#unbreach
# unbreach that needs internal reapproval

# client approved plan for $100
# upweight total budget post approval to $120
# client approval is breached
# Plan changess to "Published" @ todo a story - recognise meta data that breaches internally 
# Client sees $100 (last approved version)
# Last internally approved - $100
# Request internal approval
# a - INternally approve
# a - Plan satus changes to "Internally approved"
# a - Client sees $100 (last approved version)
# a - Last internally approved - $120
# a - publish total budget downwegight to $100 & minor upweight in plan for $5