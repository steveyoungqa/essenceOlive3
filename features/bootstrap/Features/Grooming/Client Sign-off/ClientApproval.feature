Feature: Client Approval

In order to ensure I'm authorised to buy the media outlined in the plan
As Campaign Manager
I want to get Client approval

#(mentioned 28th April)
Scenario: Implement Plan Event History

# (reviewed 28th April)
Scenario: Add a Client Approver Account
  Given a Client contact can approve a Plan on Clients behalf
  When Olive Admin views Client Contact Details (People - Edit details)
  Then Olive Admin can choose a "Client Plan Approver" role and assign it to the Client contact

#Client Approval Requested
#(reviewed 28th April)
Scenario: Request Client Approval
  Given Media plan has been internally approved
    And it's the latest version
    And verified Client Approvers have been added to the system
  When I view the published version of plan
  Then I can select one or more users with the "Client Plan Approver" role
    And I cannot choose client approvers set up for other clients, nor internal approvers
    And I cannot select the same approver more than once
    And I can add a message
    And I can request Client Approval

# TBC - could we aggregate? if e.g. 4 markets are launched on the same day
# TBC - the text
#(reviewed 28th April)
Scenario: Notify Client Approver
  Given Media Plan has been internally apprver
    And I have chosen Client approvers
  When I request approval
  Then I am presented with a promt to confirm my action
    And I see "You're about to send approval requests to [Apperover's names]. Are you sure"
    And All chosen Client approvers receive a notification email with a link to the Media plan
    And I should see "Text tbc"
    And plan status hanges to "Client Approval Requested"
    And an event is added to the Plan History
#    -----------------------------------------------------------------------------------------------------------------
#    |Time     |User                     |Action                                             |Details                |
#    -----------------------------------------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Client Approval requested from [Approvers' names] | {message if available}|
#    -----------------------------------------------------------------------------------------------------------------

#TO REVIEW
Scenario: Change Approvers while pending
  Given Client approval was requested from two Client Approvers
    And one of them has already approved
  When Campaign manager looks at the media plan last internally approved version
  Then he can edit approvers by choosing another one
    And he cannot delete chosen approvers
    And on savem a new event is added to the Plan History
#    ------------------------------------------------------------------------
#    |Time     |User                     |Action                  |Details  |
#    ------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Client Approver changed from [Name of previous approver] to [Name of new approver] | N/A     |

#TO REVIEW
Scenario: Client gives feedback
  Given Client approval was requested from two Client Approvers
    And both have received a notificafiton email with a lilnk to the media plan
    And none of them have already given feedback (approved / rejected)
  When One of them clicks on the link in notifcation
  Then he can see a Client view of the plan
    And he can Approve or Reject the plan
    And he can add a message (optional)
    And an event is added to the Plan History
#    -----------------------------------------------------------------------------
#    |Time     |User                     |Action         |Details                |
#    -----------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | [Approved/Rejected] plan | {message if available}|
#    -----------------------------------------------------------------------------

#TO REVIEW
Scenario: Partial Client Approval
  Given Client approval was requested from two Client Approvers
    And both have received a notificafiton email with a lilnk to the media plan
    And none of them have already approved
  When the first approver approves plan
  Then the plan still stays in "Client Approval Requested" status

#TO REVIEW
Scenario: Full Client Approval
  Given Client approval was requested from two Client Approvers
    And both have received a notificafiton email with a lilnk to the media plan
    And one of them has already approved
  When the last approver approves plan
  Then the plan status changes to "Client Approved"

#TO REVIEW
Scenario: Client Rejects
  Given Client approval was requested from two Client Approvers
    And both have received a notificafiton email with a lilnk to the media plan
    And none of them have already approved
  When the first approver rejects plan
  Then the plan status changes to "Client Rejected" status
    And feedback from other approvers is no longer expected

#TO REVIEW
Scenario: Version expired before Approval
  Given Client approval was requested
    And Client approver has received a notificafiton email with a lilnk to the media plan
    And campaign manager has published new changes
  When Client clicks on the link

#TO REVIEW
Scenario: View Last Client Approved Version
