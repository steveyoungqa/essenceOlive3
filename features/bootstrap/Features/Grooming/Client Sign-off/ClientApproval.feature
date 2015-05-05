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
  Given Media Plan has been internally approved
    And I have chosen Client approvers
  When I request approval
  Then I am presented with a prompt to confirm my action
    And I see "[Client approver name] will be emailed a link to approve this plan from [Current Logged In User]. Are you sure you want to send this email? Cancel/Yes, send request"
    And All chosen Client approvers receive a notification email with a link to the Media plan
    And I should see "Approval request sent"
    And plan status changes to "Client Approval Requested"
    And "Request Client Approval" button changes to "Manage Approval Request"
    And an event is added to the Plan History
#    -----------------------------------------------------------------------------------------------------------------
#    |Time     |User                     |Action                                             |Details                |
#    -----------------------------------------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Client Approval requested from [Approvers' names] | {message if available}|
#    -----------------------------------------------------------------------------------------------------------------

#(reviewed 1st May)
Scenario: Add Approvers while pending
  Given Client approval was requested from two Client Approvers
    And one of them has already approved
  When Campaign manager (anyone) looks at the media plan
  Then they can add new approver
    And receive a prompt to confirm email will be sent to Client ("[Client approver name] will be emailed a link to approve this plan from [Current Logged In User]. Are you sure you want to send this email? Cancel/Yes, send request")
    And on request a new event is added to the Plan History
#    ------------------------------------------------------------------------------------------------------
#    |Time     |User                     |Action                                                |Details  |
#    ------------------------------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Client Approval reqested from [Name of new approver] | N/A     |

#(reviewed 1st May)
Scenario: Remove Approvers while pending
  Given Given Client approval was requested from two or more Client Approvers
    And there is more than one pending approver
    And the user is a "Campaign Manager"
  When  they view the approver list
  Then  allow them to remove all but the last pending approver
    And don't allow them to remove an approver who has "Approved" the plan
    And record in the removal in the history:
#    --------------------------------------------------------------------------------------------------------------
#    |Time     |User                     |Action                                                        |Details  |
#    --------------------------------------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Client Approval reqest retracked from [Name of new approver] | N/A     |

#(reviewed 1st May)
Scenario: Popeye role
  Given User account is set up in Olive
  When Olive manager looks at the account details ("People" section)
  Then he can choose "Popeye" as a Role and assign it to User account holder


#(reviewed 1st May)
Scenario: Remove Last pending Approver
  Given Given Client approval was requested from two or more Client Approvers
    And there is only one pending Approver
    And the user is "Popeye"
  When  they view the approver list
  Then  allow them to remove the last pending approver
    And receive a prompt to confirm the plan will be approved as all other approvers have approved ("Removing the last pending approver will automatically change this plan's status to Client Approved. Are you sure you want to do this? Cancel / Yes, remove approver")
    And Plan changes status to "Client Approved"
    And record in the removal in the history:
#    -------------------------------------------------------------------------------------------------------------------
#    |Time     |User                     |Action                                                              |Details  |
#    -------------------------------------------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Client Approval reqest retracted from [Name of pending approver]   | N/A     |
#    |Datetime |Currently Logged in User | Plan has been Approved by the client                               | N/A     |

#(reviewed 1st May)
  Scenario: Removes all Client Approvers
    Given Given Client approval has one remaining client approver
      And the approver status is "Pending"
      And the user is "Popeye"
    When  they view the approver list
    Then  allow them to remove the last pending approver
      And receive a promt to confirm the plan will go back to ("text tbc")
      And Plan changes status to "Internally Approved"
      And record in the removal in the history:
#      ------------------------------------------------------------------------------------------
#      |Time     |User                     |Action                                    |Details  |
#      ------------------------------------------------------------------------------------------
#      |Datetime |Currently Logged in User | All client approvers have been removed.  | N/A     |
#      |Datetime |Currently Logged in User | Plan moved back to Internally Approved   | N/A     |


Scenario: Add another approver once it's approved

#TO REVIEW
Scenario: Attempt to remove Last Pending Approver without "Popeye" status
  Given Given Client approval was requested from two or more Client Approvers
    And there is one pending approver
    And the user is a "Campaign Manager"
  When  they select to remove the pending approver
  Then  show an alert saying "You are not authorised to remove the last pending approver. Please add another client approver before removing this approver, or ask a "Popeye" user to remove the last approver.


#TO REVIEW
Scenario: Client gives feedback
  Given Client approval was requested from two Client Approvers
    And both have received a notificaton email with a link to the media plan
    And none of them have already given feedback (approved / rejected)
  When One of them clicks on the link in notification
  Then he can see a Client view of the plan
    And he can Approve or Reject the plan
    And he can add a message (optional)
    And an event is added to the Plan History
#    ------------------------------------------------------------------------------------------
#    |Time     |User                     |Action                      |Details                |
#    ------------------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | [Approved/Rejected] plan   | {message if available}|
#    ------------------------------------------------------------------------------------------

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
