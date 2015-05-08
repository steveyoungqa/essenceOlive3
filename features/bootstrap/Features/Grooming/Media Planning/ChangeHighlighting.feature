
Feature: Change Highlighting

In order to understand what has changed between different versions of the plan and where I need to pay attention in order to progress
As Campaign Manager
I want to see differences between versions or missing information highlighted

#reviewed 8th May
Scenario: View Last Internally Approved and Client Approved Versions of Plan (OTD-1178)
  Given A media plan has been internally or client approved
    When I view the plan in Olive
  Then I can see a new options in the Plan view toggle (in screenshot) labelled "Last Internally approved" and "Last Client Approved"
    And When I select that option the plan displays a snapshot of all lines as they existed in that version
    And When I select that option the IO tab lists all Ios and their content as it was at the time of approval
    And When I select that option the Purchase Order and Invoice Tabs display the same information as selecting "Published" option


#to flesh out
Scenario: FE - Highlight Plan line and meta data changes between different versions
  #prototype: http://mnnl4s.axshare.com/#p=1_2_4_media_plan_view__editable_draft_ (OTD-1976)
  #screenshots in OTD-2064
  Given A
  When I look at the plan (any version)
  Then I see each different value marked with a highlight
    And when I hover over the highlight i can see the current value in each other existing version, when and by whom the last change was made
    And Upweights / Downweights are indicated with colours red and green (TBC)
    And Cancellations are shown as downweights to 0

#to review
Scenario: FE - Display Approved plan that has IOs with missing Internall Approval or Supplier countersigned IO
  #Screenshots in https://essencedigital.atlassian.net/browse/OTD-2063
  Given Client Approved Plan exists
    And changes have been made and published
    And these changes have caused Internal approval or Supplier contersign to be revoked from some Insertion Orders
  When I look at the Plan (any version)
  Then I see Insertion Order tab marked with a warning highlight
    And the warning displays a count of Insertion Orders with missing Internal approval or Suppleir countersign confirmation
    And (@todo - decide on some sort of indicator in the IO listing)

#to review
Scenario: FE - Display Plan history
  Given A media plan has been set up and published
    And changes have been made to it or approvals have been requested
  When I look at the Media Plan
  Then I can see a "Plan History" tab
    And it displays each important workflow event recorded during its lifecycle such as (Internal Approval requested, Published upweight)


#beyond mvp
#to review
Scenario: View Last Internally Approved and Client Approved Versions of Insertion Orders (OTD-1178)
  Given A media plan has been internally or client approved
    When I view the Insertion Order in Olive
  Then I can see a dropdown (?) (@todo - confirm) with the following options: "Draft", "Published", "Last Internally approved", "Last Client Approved"
    And changing option the plan displays a snapshot of all lines as they existed in that version
