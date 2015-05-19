Feature: IO Internal Approval
In order to manage media sign-off for deals independently of each other
As Campaign Manager
I want to be able to internally approve individual IOs

#reviewed 23th April - in sprint 28 [27th April] - accepted 11th May
Scenario: View IO Event History (OTD-2013)
  Given An IO exists
    And there have been some events (such as Approval requests, post approval amount chages etc)
  When I look at the IO details page (both: draft and published)
  Then Display the Time, Username, Actio (prototye_)

#reviewed 23th April - in sprint 28, 29 [27th April] -
Scenario: Require Internal Approval (OTD-2006)
  Given the IO has been published
  When the user wants to submit for Internal Approval
  Then allow the user to select one or more internal approvers (users with IO Approver Role OTD-2005)
    And allow the user to capture a message
    And allow them to request approval
    And change the state of the IO to "Internal Approval Requested"
    And Selected approver receives a persistent (until the said IO is internally approved) notification on their homepage with the following text:
#      | { Approver Name } has requested that you review and approve the following Insertion Order: { Supplier - IO Id - label } in { Media Plan Name } for { Currency Code} {Insertion Order Total } |
#      | Zanete Ence has requested that you review and approve the following Insertion Order:  |
#      | Google Ireland Ltd. - #243 - PMP Non-AdX in Chrome EMEA Q2 2015 UK for GBP 3,500      |
#      With a link to the Published version of this Insertion Order
  And save an Event in the history:
#      ------------------------------------------------------------------------------
#      |Time     |User                     |Action                     |Document| Notes  |
#      ------------------------------------------------------------------------------
#      |Datetime |Currently Logged in User | IO Submitted for Approval | N/A    |        |

#reviewed 23th April - in sprint 28, 29 [27th April] -
Scenario: IO Approved (OTD-1914)
  Given the IO is still in the "Internal Approval Requested" state
  When  they approve the IO
  Then change the state of the IO to "Internally Approved"
    And save an Event in the history:
#    ------------------------------------------------------------------------------
#    |Time     |User                     |Action                     |Document| Notes  |
#    ------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | IO Approved               | N/A    |        |

#reviewed 23th April - - in sprint 28, 29 [27th April] -
Scenario: IO Rejected (OTD-1914)
  Given the IO is still in the "Internal Approval Requested" state
  When  they reject the IO
  Then change the state of the IO to "Internally Rejected"
    And save an Event in the history:
#    ------------------------------------------------------------------------------
#    |Time     |User                     |Action                     |Document| Notes  |
#    ------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | IO Rejected               | N/A    |        |



#to review
Scenario: Impact of Individual IO Internal Approval requests on Plan and Other Insertion orders
  # Start with 2 Published iOs
  Given There is a "Published" Media Plan
    And two published Insertion Orders exist (A and B)
    And User requests Internal Approval of one of the Insertion Orders (A)
  Then Plan is still in a "Published" State
    And Internal Status for Insertion Order A changes to "Internal Approval Requested"
    And Internal Status for insertion Order B remains "Published"

#to review
Scenario: Impact of Publishing upweights to Other Insertion orders
  # Start with 2 Published iOs
  Given There is aMedia Plan with two Insertion Orders (A and B)
    And One Insertion Order (A) is in  "Internal Approval Requested" or later state
    And budget is upweighted for a line in the other Insertion Order (B)
  When Changes are published
    And Internal Status for Insertion Order A hasn't changed
    And Status for Insertion ORder B is "Published"
    And Supplier Countersign confirmation for Insertion Order B has been revoked

#to review
Scenario: Impact of Publishing downweights to Insertion orders
  # Start with 2 Published iOs
  Given There is Media Plan with two Insertion Orders (A and B)
    And One Insertion Order (A) is in  "Internal Approval Requested" or later state
    And one or more changes to line in the other Insertion Order (B) is made (changes outlined below)
    # Budget up
  When Changes are published
    And Internal Status for Insertion Order A hasn't changed
    And Internal Status for insertion ORder B hasn't changed
    And Supplier Countersign confirmation for Insertion Order B has been revoked


#to review
Scenario: Allow re-requesting internal approval for Insertion Orders
  #relates to OTD-2006
  Given a request for Insertion Order approval has been made
    And the request is still pending (IO in "Internal approval requested" state)
  When I look at the Insertion Order "Approvals" tab
  Then I can select other internal approvers and request their approval as per (OTD-2006) until Insertion Order is "Internally Approved"

#to review
Scenario: Restrict internal IO approval (OTD-1913)
