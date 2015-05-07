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
  #prototype: http://mnnl4s.axshare.com/#p=1_2_3_media_plan_view__published_
  Given Media plan has been internally approved
    And it's the latest version
    And verified Client Approvers have been added to the system
  When I view the published version of plan
  Then I can select one or more users with the "Client Plan Approver" role
    And I cannot choose client approvers set up for other clients, nor internal approvers
    And I cannot select the same approver more than once
    And I can add a message
    And I can request Client Approval

#(reviewed 28th April)
Scenario: Notify Client Approver
  #prototype: http://mnnl4s.axshare.com/#p=1_2_3_media_plan_view__published_
  Given Media Plan has been internally approved
    And I have chosen Client approvers
  When I request approval
  Then I am presented with a prompt to confirm my action
    And I see "[Client approver name] will be emailed a link to approve this plan from [Current Logged In User]. Are you sure you want to send this email? Cancel/Yes, send request"
    And All chosen Client approvers receive a notification email with a link to the Media plan
      # Email Subject: Media approval requested: {Media Plan Name} (ID: {Media Plan ID})
      # Email Text:
      #
      # Dear {Approver name},
      #
      # This is an automated email notifying you of the newly issued Media Plan '{Media Plan Name}'.
      #
      # Please click [here|link to plan] to review and give your feedback.
      #
      # If clicking the above link does not work, please copy and paste the following into the address bar of your browser:
      # -------------------------------------
      # {link to plan as text}
      # -------------------------------------
      # Please note that timely authorisation is required to secure media and no bookings can be guaranteed until Media plan is approved and a Publisher Insertion Order has been signed and returned
      #
      # Regards,
      # Olive
      # -------------------------------------
      # Essence
      # www.essencedigital.com
      # -------------------------------------
      # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.
      #
    And I should see feedback toast with text "Approval request sent"
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
  #prototype: http://mnnl4s.axshare.com/#p=1_2_3_media_plan_view__published_
  Given Given Client approval was requested from two or more Client Approvers
    And there is more than one pending approver
    And the user is a "Campaign Manager"
  When  they view the approver list
  Then  allow them to remove all but the last pending approver
    And don't allow them to remove an approver who has "Approved" the plan
    And removed Approver gets a notification
      #@todo - Helen please confirm notification text
      #
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


#TO REVIEW
Scenario: Attempt to remove Last Pending Approver without "Popeye" status
  Given Given Client approval was requested from two or more Client Approvers
    And there is one pending approver
    And the user is a "Campaign Manager"
  When  they select to remove the pending approver
  Then  show an alert saying "You are not authorised to remove the last pending approver. Please add another client approver before removing this approver, or ask a *Popeye* user to remove the last approver."



Scenario: Add another approver once it's approved


#(reviewed 5th May)
Scenario: Client gives feedback
  Given Client approval was requested
    And Client approver received a notificafiton email with a lilnk to the media plan
    And the Plan hasn't been rejected
  When they clicks on the link in notifcation
  Then they can see a Client view of the plan
    And they can Approve or Reject the plan
    And they can add a message (optional)
    And an event is added to the Plan History
      #    ------------------------------------------------------------------------------------------
      #    |Time     |User                     |Action                      |Details                |
      #    ------------------------------------------------------------------------------------------
      #    |Datetime |Currently Logged in User | [Approved/Rejected] plan   | {message if available}|
      #    ------------------------------------------------------------------------------------------

#(reviewed 5th May)
Scenario: Partial Client Approval
  Given Client approval was requested from multiple Client Approvers
    And there is more than one pending approvals
  When only one of them approves plan
  Then the plan still stays in "Client Approval Requested" status

#(reviewed 5th May)
Scenario: Full Client Approval
  Given Client approval was requested from one or more Client Approvers
    And one approval is still pending
  When the last approver approves plan
  Then the plan status changes to "Client Approved"
    And Media Plan Manager is notified
      #@todo - need to cnfirm text
      #""
    And an event is added to the Plan History
      #------------------------------------------------------------------------------------------
      #|Time     |User                     |Action                      |Details                |
      #------------------------------------------------------------------------------------------
      #|Datetime |Currently Logged in User | Plan Client approved   | {message if available}|
      #------------------------------------------------------------------------------------------

#(reviewed 5th May)
Scenario: Client Rejects
  Given Client approval was requested from one or more Client Approvers
    And plan is not "Client Approved"
  When the any approver rejects plan
  Then the plan status changes to "Client Rejected" status
    And feedback from other approvers is no longer expected
    And other approvers are notified
      #@todo - Helen, please write something here!
      #"[]"
    And Media Plan Manager is notified
    And an event is added to the Plan History
      #------------------------------------------------------------------------------------------
      #|Time     |User                     |Action                      |Details                |
      #------------------------------------------------------------------------------------------
      #|Datetime |Currently Logged in User | [Rejected] plan   | {message if available}|
      #------------------------------------------------------------------------------------------

#(reviewed 5th May)
Scenario: Version expired before Approval
  Given Client approval was requested
    And Client approver has received a notificafiton email with a lilnk to the media plan
  When campaign manager publishes new changes that breaches
  Then Client approvers receive a notification about plan no longer needing approval
#    @todo - helen please confirm copy
    And Plan status changes to "Published"


#(reviewed 6th May)
Scenario: Version breached after approval
  Given Client approval was given for a plan
    And breaching changes to plan have been published
    And plan is in "Published" state
  When Client approver looks at the plan in Client Portal
  Then they see the last approved verions
