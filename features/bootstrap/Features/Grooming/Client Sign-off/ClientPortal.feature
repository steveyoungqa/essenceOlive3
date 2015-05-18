Feature: Client Portal

In order to authorise media buys for new campaigns or re-approve changes in existing
As Client Approver
I want to view an outline of all budget allocations in a plan

#to review
Scenario: Client logs in (OTD-781)
  Given Client approval was requested
    And Client Approver has received a notification email with a link to the media plan
    And Client is not logged in to Olive 3
  When Client clicks on the link
  Then He is taken to Olive 3 login page
    And he can log in with his Google account
    And he is then redirected to the Media Plan referenced in the email notification

#reviewed 7th May
Scenario: Client redirected to Campaign Management (OTD-781)
  Given Client approver has logged in Olive 3
  When they click on the Olive logo (or visit '/' in any other way)
  Then they are taken to the Campaign Management area

#reviewed 7th May
Scenario: Client views a list of campaigns that contain plans they can access (OTD-768)
  #prototype: http://mnnl4s.axshare.com/#p=1_2_3_7b_cliant_campaign_view_-_campaigns
  Given Client has loged in Olive
  When they navigate to Campaign management
  Then they see list of all Campaigns for the Client in which there are plans they have been selected as client approvers (and never removed) and the plan is either in "Client approval requested" status or was "Client approved" at least once
    And campaigns are sorted by latest first
    And they can see the Name and Status (client version*) of that campaign
    And Status is one of these values:
    #--------------
    # Status
    #-------------
    # Your feedback required (contains a plan pending approval that Client Approver hasn't approved/rejected yet)
    # Pending other approver feedback (contains plans that still require other approver feedback but not from the currently logged in user)
    # Rejected (Contains a rejected plan but none of the above)
    # Approved (contains only approved plans)
    And each row is a clickable control that takes user to the details of that campaign
    And Advanced filters do not contain "Client" dropdown

#reviewed 7th May
Scenario: Client views a list of plans that they can access (OTD-768)
  #prototype: http://mnnl4s.axshare.com/#p=1_2_3_7a_cliant_campaign_view_-_media_plans
  Given Client approver has received more than one Plan approval requests
  When they follow one of those links
  Then they can navigate to Campaign of that plan
    And they cannot see any edit links or checkboxes
    And they see a list of plans for which they have received client approval requests grouped by Period (ordered by "Date created" desc)
    And periods are ordered by "Date created" desc
    And they see the following information for each plan:
    #-------------
    # Field
    #-------------
    # Name
    # Status - Client version of the plan status*
    # Budget (Media Plan Currency)
    # Budget (_Client Currency code_) (e.g. "Budget (USD)" )
    # Start Date
    # End Date
    And they cannot delete or edit Plan meta data
    And each row is a clickable control that takes user to the latest version for which client approval was requested


#reviewed 7th May
Scenario: Client views plan that he is to approve / reject (OTD-292)
  Given Client approver has received more than one Plan approval requests
  When they view the plan
  Then they can see the buttons to Approve or Reject the Plan at the top and the bottom of the plan
    And they can see the message that was added at time of requesting approval
    And the visibility of the message can be toggled
    And they can see Media Plan Name, Budget, Currency, Start and End Date
    And the grouping of lines is: Section, IO, Channel
    And the control to change line grouping is not visible
    And Insertion Orders are collapsed by default
    And "IO" column header is not labelled (is blank)
    And if only one property, is indicated as part of the IO name, if there are more, IO name mentions "Multiple Properties"
    And IO ID numbers are not visible in IO name
    And IO name does not appear in the rows below the IO total rows
    And Additional column is visible for Liable Entity
    And Additional column is visible for Budget in Client currency is visible
    And if Client Currency and Media Plan currency are the same, only one budget column is shown, it references the currency code in the column name
    And Plan Line Start and End Dates, Media Type, Cost Model and Spend column are not visible
    And there are no other actions on lines (no checkboxes / no edit links)
    And Breach terms are visible at the bottom of the plan
    # Once approved by all designated approvers, this Media Plan will be considered an approved Media Plan and budget as described in the then current
    # Master Services Agreement ("MSA") with Essence. You agree that Essence will purchase the media described and that you will reimburse Essence for
    # these purchases under the terms of this MSA. Essence may not increase the overall Media Plan total without further approval, however Essence are
    # authorised to redistribute budget assigned to individual purchases within the overall Media Plan budget without further approval from the client
    # but subject to no individual addition representing more than {Breach %} of the total budget approved in this Media Plan.

#reviewed 7th May
Scenario: Client views a plan for which they have already giving feedback (OTD-292)
  Given Client approver has already given feedback about a plan
  When they view it again
  Then instead of Approve / Reject buttons they see the Plan status (client version)*
    # Pending other approver feedback (plans that still requires other approver feedback but not from the currently logged in user)
    # Rejected
    # Approved
    And the message that was captured at the time of requesting approval
    And they can see when they gave feedback and the message they left at the time

  #to flesh out
  Scenario: FE - Highlight minor changes since approval Client view of Last Approved version (OTD-788)

  #to flesh out
  Scenario: FE - Highlight changes between Client Approval Requested vs Last Approved version (OTD-788)
