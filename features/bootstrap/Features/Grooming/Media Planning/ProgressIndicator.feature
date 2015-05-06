Feature: Progress Indicator

In order to have clarity at a glance and be guided through the media plan lifecycle
As Campaign Manager
I want to see the current status of the Media Plan on a progress bar at all times

#(reviewed 21st April)
Scenario: Display the current stage in the media plan workflow (OTD-1856)
  Given that a Media Plan exists
    And I'm in the media plan details view
  Then I see a progress indicator with the following information
#  ---------------------------------------------------------
#  |Current State in Workflow  |Next Action                |
#  ---------------------------------------------------------
#  |Draft                      |Publish draft              |
#  |Published                  |Request Internal Approval  |
#  |Internal Approval Requested|Approve or Reject          |
#  |Internally Approved        |Request Client Approval    |
#  |Client Approval Requested  |Await Client approval      |
#  |Client Approved            |(Post End Date:) Reconcile |
#  |Reconciled                 |                           |
#  ---------------------------------------------------------

#(reviewed 21st April)
Scenario: Media plan has been rejected (OTD-1856)
  Given that the media plan has been rejected either internally or externally (client)
  When  displaying the progress indicator
  Then  I can see a block icon between the requested and approved statuses
    And display the next steps based on the following:
#  --------------------------------------------------------------
#  |Current State in Workflow | Next Action                     |
#  --------------------------------------------------------------
#  |Internally Rejected       | Review the Plan + Notes (hover) |
#  |Externally Rejects        | Review the Plan + Notes (hover) |

#to review
Scenario: FE - Hide spend when no platform integration available
  Given I have set up plan lines for platforms without Olive 3 integration
  When I look at the plan
  Then Spend column in Plan view and spend to date in IO view doesn't display any value (not even 0.00 as it's very misleading)

#TO FLESH OUT
Scenario: FE - Display Plan history

#TO FLESH OUT
Scenario: FE - Display Approved plan that has IOs with missing Internall Approval or Supplier countersigned IO

#TO FLESH OUT - prototype OTD-1976 ?
Scenario: FE - Highlight Plan changes published since last approval

#TO FLESH OUT
Scenario: FE - Highlight Plan meta data changes published since last approval
