Feature: Client Approval

In order to ensure I'm authorised to buy the media outlined in the plan
As Campaign Manager
I want to get Client approval

#mentioned 28th April - in sprint 29 [11th May] -
Scenario: Implement Plan Event History (OTD-775)

#reviewed 28th April - in sprint 29 [11th May] - accepted 13th May
Scenario: Add a Client Approver Account (OTD-771)
  Given a Client contact can approve a Plan on Clients behalf
  When Olive Admin views Client Contact Details (People - Edit details)
  Then Olive Admin can choose a "Client Plan Approver" role and assign it to the Client contact

#to reivew - in sprint 31 [8th June] -
Scenario: Preview as Client (OTD-2228)
  Given Media Plan in any of the combinations of the below status
    # Internal Status             | Client Status             |
    # ----------------------------|---------------------------|
    # Publish                     | Client Approval Requested |
    # Internal Approval Requested | Client Approval Requested |
    # Internally Approved         | Never Approved            |
    # Internally Approved         | Breached                  |
    # Internally Approved         | Client Approval Requested |
  When I'm viewing the "Internally approved" view of plan
  Then I can see a button "Preview as Client"
    And it opens up a new tab that looks like the Plan will be looking for the Client once Client approval is requested (TBC with Dalith)

#Client Approval Requested
#reviewed 28th April - in sprint 29 [11th May] -
Scenario: Request Client Approval (OTD-762)
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
    And I should see feedback toast with text "Approval request sent"
    And plan status changes to "Client Approval Requested"
    And "Request Client Approval" button changes to "Manage Approval Request"
    And an event is added to the Plan History
      #    -----------------------------------------------------------------------------------------------------------------
      #    |Time     |User                     |Action                                             |Details                |
      #    -----------------------------------------------------------------------------------------------------------------
      #    |Datetime |Currently Logged in User | Client Approval requested from [Approvers' names] | {message if available}|
      #    -----------------------------------------------------------------------------------------------------------------


#reviewed 28th April - in sprint 29 [11th May] -
Scenario: Notify Client Approver (OTD-765)
  #prototype: http://mnnl4s.axshare.com/#p=1_2_3_media_plan_view__published_
  Given Media Plan has been internally approved
    And I have chosen Client approvers
  When I request approval
  Then I am presented with a prompt to confirm my action
    And I see "[Client approver name] will be emailed a link to approve this plan from [Current Logged In User]. Are you sure you want to send this email? Cancel/Yes, send request"
    And All chosen Client approvers receive a notification email with a link to the Media plan
      # Email Subject: Media Plan approval requested: {Media Plan Name} (ID: {Media Plan ID})
      # Email Text:
      #
      # Dear {Approver name},
      #
      # This is an automated email notifying you of the newly issued Media Plan, "{Media Plan Name}".
      #
      # Please click [here|link to plan] to review and give your feedback.
      #
      # If clicking the above link does not work, please copy and paste the following into the address bar of your browser:
      # -------------------------------------
      # {link to plan as text}
      # -------------------------------------
      # Please note that timely authorisation is required to secure media and no bookings can be guaranteed until the Media Plan is approved and a Publisher Insertion Order has been signed and returned.
      #
      # Regards,
      # Olive
      # -------------------------------------
      # Essence
      # www.essencedigital.com
      # -------------------------------------
      # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.

  #reviewed 5th May - in sprint 29 [11th May] -
  Scenario: Client gives feedback (OTD-769)
    Given Client approval was requested
      And Client approver received a notificafiton email with a lilnk to the media plan
      And the Plan hasn't been rejected
    When they clicks on the link in notification
    Then they can see a Client view of the plan
      And they can Approve or Reject the plan
      And they can add a message (optional)
      And an event is added to the Plan History
        #    ------------------------------------------------------------------------------------------
        #    |Time     |User                     |Action                      |Details                |
        #    ------------------------------------------------------------------------------------------
        #    |Datetime |Currently Logged in User | [Approved/Rejected] plan   | {message if available}|
        #    ------------------------------------------------------------------------------------------

  #reviewed 5th May - in sprint 29 [11th May] -
  Scenario: Partial Client Approval (OTD-294)
    Given Client approval was requested from multiple Client Approvers
      And there is more than one pending approvals
    When only one of them approves plan
    Then the plan still stays in "Client Approval Requested" status

  #reviewed 5th May - in sprint 29 [11th May] -
  Scenario: Full Client Approval (OTD-294)
    Given Client approval was requested from one or more Client Approvers
      And one approval is still pending
    When the last approver approves plan
    Then the plan status changes to "Client Approved"
      And Media Plan Manager is notified via email
        # Email Subject: Media Plan Approved: {Media Plan Name} (ID: {Media Plan ID}) (No action required)
        # Email Text:
        #
        # Dear {Media Plan Manager},
        #
        # This is an automated email notifying that the recently issued Media Plan, "{Media Plan Name}", has been approved by all Client Approvers.
        #
        # Regards,
        # Olive
        # -------------------------------------
        # Essence
        # www.essencedigital.com
        # -------------------------------------
        # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.
        #
      And an event is added to the Plan History
        #------------------------------------------------------------------------------------------
        #|Time     |User                     |Action                      |Details                |
        #------------------------------------------------------------------------------------------
        #|Datetime |Currently Logged in User | Plan Client Approved   | {message if available}|
        #------------------------------------------------------------------------------------------

  #reviewed 5th May - in sprint 29 [11th May] -
  Scenario: Client Rejects (OTD-769)
    Given Client approval was requested from one or more Client Approvers
      And plan is not "Client Approved"
    When a Client Approver rejects the plan
    Then the plan status changes to "Client Rejected" status
      And feedback from other approvers is no longer expected
      And other approvers are notified
        # Email Subject: Media Plan Rejected: {Media Plan Name} (ID: {Media Plan ID}) (No action required)
        # Email Text:
        #
        # Dear {Client Approver},
        #
        # This is an automated email notifying that the recently issued Media Plan, "{Media Plan Name}", has been rejected. If your feedback was still pending, you will no longer be able to provide feedback on this version.
        #
        # Regards,
        # Olive
        # -------------------------------------
        # Essence
        # www.essencedigital.com
        # -------------------------------------
        # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.
        #
      And Media Plan Manager is notified
      And an event is added to the Plan History
        #------------------------------------------------------------------------------------------
        #|Time     |User                     |Action                      |Details                |
        #------------------------------------------------------------------------------------------
        #|Datetime |Currently Logged in User | [Rejected] plan   | {message if available}|
        #------------------------------------------------------------------------------------------



#(reviewed 5th May)
Scenario: Version breached before Approval (OTD-767)
#as per flow: https://docs.google.com/presentation/d/1kfVC7tLbzNUZO_W20_k8IKkkEH3l_7ZtI769Br2l8Js/edit#slide=id.g9d920b67a_0_0
  Given Client approval was requested
    And Client approver has received a notification email with a link to the media plan
    And Approval is pending
  When campaign manager publishes new changes that breach the plan
  Then pending Client approvers receive a notification about plan no longer needing approval
      # Email Subject: Media Plan changed: {Media Plan Name} (ID: {Media Plan ID}) (No action required)
      # Email Text:
      #
      # Dear {Client Approver},
      #
      # This is an automated email notifying that the recently issued Media Plan, "{Media Plan Name}", has been changed. If your feedback was still pending, you will no longer be able to provide feedback on this version.
      #
      # Regards,
      # Olive
      # -------------------------------------
      # Essence
      # www.essencedigital.com
      # -------------------------------------
      # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.
      #
    And Plan status changes to "Published"



#to be reviewed
Scenario: Version changed after Approval (OTD-2199)
#as per flow: https://docs.google.com/presentation/d/1kfVC7tLbzNUZO_W20_k8IKkkEH3l_7ZtI769Br2l8Js/edit#slide=id.g9d920b67a_0_93
  Given Client approval was given for a plan
    And minor (non-breaching) changes have been published or internally approved
  When Client approver looks at the plan in Client Portal
  Then they see the last approved version with the internally approved (or auto-approved e.g. downweights) changes included
    # Client approved 10,000 for Facebook
    # AM published and internally approved changes - upweight by 1,000
    # Client goes to view plan - they see 11,000 against Facebook
    And the changes are highlighted (OTD-788)

#reviewed 14th May -
Scenario: Version changed before Approval  (OTD-786)
# as per flow: https://docs.google.com/presentation/d/1kfVC7tLbzNUZO_W20_k8IKkkEH3l_7ZtI769Br2l8Js/edit#slide=id.g9d920b67a_0_115
  Given Client Approval was requested
    And Approval is pending
  When campiagn manager publishes new changes that do not breach terms
  Then Cients who view the version for approval can see and approve published changes as part of the first approval request
    #in other words - no need to create a new version or request new approval

#reviewed 6th May - in sprint 31 [8th June] -
Scenario: Version breached after approval (OTD-786)
#as per flow: https://docs.google.com/presentation/d/1kfVC7tLbzNUZO_W20_k8IKkkEH3l_7ZtI769Br2l8Js/edit#slide=id.g9d920b67a_0_55
  Given Client approval was given for a plan
    And breaching changes to plan have been published
    And plan is in "Published" state
  When Client approver looks at the plan in Client Portal
  Then they see the last approved verions including auto-approved changes


#to reivew - in sprint 31 [8th June] -
Scenario: View as Client (OTD-772)
  Given Media Plan has been approved by Client
    #https://docs.google.com/spreadsheets/d/1bRTlE5cDOuWZUpXc7cYVXqr2hCcOUFkDqm2TJfZ3HdI/edit#gid=0
  When I'm viewing the "Client approved" view of plan
  Then I can see a button "View as Client"
    And it opens up a new tab that looks like the Plan version that the Client sees in Client Portal (TBC with Dalith)

#to review
Scenario: Clearer labels on Client view of Plan
  Given I have received an approval request
  When I look at Media Plan in Client Portal
  Then I do not see the search box
    And the Message that Requester has left me does NOT obstruct the header information
    And I cannot toggle help system (The tooltip off/on control isn't visible)
    And "Media Costs" ISN'T one of the column headers #after having seen how it looks, it feels out of place, it looked better without
    And instead of "Budget([ISO code of Media Plan Currency])" relabel column header to "Budget (Buying Currency)"
    And approver area is labelled "Approval Status" (instead of "Plan Feedback")
    And while my approval is pending, when I click on "Approve" and approval panel opens up, I see the following note just by "Approve" button (highlighted in screenshot attached):
      # Please note that by submitting "Approve", you are also indicating that you approve the association of this Media Plan with the Initiative (MRF ID), "{Initiative without quarter and year, just the MRF ID and name}".

#to review
Scenario: Clearer labels on Media Plan Listing in Client Portal
  Given I'm a logged in Client Plan Approver
  When I view a list of Media Plans under a Campaign for which I've been requested to give approval
  Then I see Total sums of Budget for each grouping (by status) displayed on the status row for both currencies
    And instead of "Budget" relabel column header to "Budget (Buying Currency)"


#(reviewed 1st May)
Scenario: Add Approvers while pending
  Given Client approval was requested from two Client Approvers
    And there is at least one pending approver
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
      # Email Subject: Media Plan approver change: {Media Plan Name} (ID: {Media Plan ID}) (No action required)
      # Email Text:
      #
      # Dear {Approver name},
      #
      # This is an automated email notifying that the recently issued Media Plan, "{Media Plan Name}", no longer requires you to provide feedback.
      #
      # Regards,
      # Olive
      # -------------------------------------
      # Essence
      # www.essencedigital.com
      # -------------------------------------
      # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.
    And record in the removal in the history:
      #    --------------------------------------------------------------------------------------------------------------
      #    |Time     |User                     |Action                                                         |Details  |
      #    --------------------------------------------------------------------------------------------------------------
      #    |Datetime |Currently Logged in User | Client Approval request retracted from [Name of new approver] | N/A     |

#(reviewed 1st May)
Scenario: Popeye role
  Given User account is set up in Olive
  When an Olive Super Admin looks at the account details ("People" section)
  Then he can choose "Popeye" as a Role and assign it to a User account holder


#(reviewed 1st May)
Scenario: Remove last pending Approver
  Given Client approval was requested from two or more Client Approvers
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
    Given Client approval has one remaining Client Approver
      And the approver status is "Pending"
      And the user is "Popeye"
    When  they view the approver list
    Then  allow them to remove the last pending approver
      And receive a prompt to confirm the plan will go back to ("Removing all Client Approvers will revert this plan's status to Internally Approved. Do you wish to proceed? Cancel/Yes, remove Approver")
      And Plan changes status to "Internally Approved"
      And record in the removal in the history:
        #      ------------------------------------------------------------------------------------------
        #      |Time     |User                     |Action                                    |Details  |
        #      ------------------------------------------------------------------------------------------
        #      |Datetime |Currently Logged in User | All Client Approvers have been removed.  | N/A     |
        #      |Datetime |Currently Logged in User | Plan moved back to Internally Approved   | N/A     |


#TO REVIEW
Scenario: Attempt to remove Last Pending Approver without "Popeye" status
  Given Given Client approval was requested from two or more Client Approvers
    And there is one pending approver
    And the user is a "Campaign Manager"
  When  they select to remove the pending approver
  Then  show an alert saying "You are not authorised to remove the last pending Approver. Please add another Client Approver before removing this Approver, or ask a *Popeye* user to remove the last Approver."


#TO FLESH OUT
Scenario: Add another approver once a plan is approved
