Feature: Client Portal

In order to authorise media buys for new campaigns or re-approve changes in existing
As Client Approver
I want to view an outline of all budget allocations in a plan

#to review
Scenario: Client logs in
  Given Client approval was requested
    And Client approver has received a notificafiton email with a lilnk to the media plan
    And Client is not logged in Olive 3
  When Client clicks on the link
  Then He is taken to Olive 3 login page
    And he can log in with his google account
    And he is then redirected to the Media Plan referenced in email notification

#to review
Scenario: Client views homepage
  Given Client approver has logged in Olive 3
  When they click on the Olive logo (or visit '/' in any other way)
  Then he is taken to the Campaign Management area

#to review
Scenario: Client views a list of campaigns that contain plans they can access
  Given Client has loged in Olive
  When they navigate to Campaign management
  Then they see list of all Campaigns for the Client in which there are plans they have been selected as client approvers (and never removed) and the plan is either in "Client approval requested" or Client approved at least once
    And campaigns are sorted by latest first
    And they can see the Name and Status (client version*) of that campaign
    And Status is one of these values:
    #--------------
    # Status
    #-------------
    # Your feedback required (contains a plan that Client Approver hasn't approved/rejected yet)
    # Pending other approver feedback (contains plans that still require other approver feedback but not the user who's looking)
    # Rejected (Contains a rejected plan but none of the above)
    # Approved (contains only approved plans)
    And each row is a clickable control that takes user to the details of that campaign

#to review
Scenario: Client views a list of plans that they can access
  Given Client approver has received many Plan approval requests
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
    And they cannot delete or edit plan meta data
    And each row is a clickable control that takes user to the latest version for which client approval was requested


#to review
Scenario: Client views plan that he is to approve / reject
  Given Client approver has received many Plan approval requests
  When they view the plan
  Then they can see the buttons to approve or reject the plan at the top and the bottom of the plan
    And they can see the message that was added at time of requesting approval
    And the visibility of message can be toggled
    And they can see Media Plan Name, Budget, Currency, Start and End Date
    And the grouping of lines is: Section, IO, Channel
    And the control to change line grouping is not visible
    And Insertion Orders are collapsed by default
    And if only one property is indicated as part of the IO name, if there are more, IO name mentions "Multiple Properties"
    And IO ID numbers are not visible in IO name
    And IO name doesn't appear in the columns
    And Additional columns for Liable Entity and Budget in Client currency is visible
    And if Client Currency and Media Plan currency are the same, only one budget column is shown, it references the currency code in the column name
    And Plan line start and end dates, Media Type, Cost Model and Spend column aren't visible
    And there are no other actions on lines (no checkboxes / no edit links)
    And Breach terms are visible at the bottom of the plan
     @todo - text to be confirmed with Helen

#to review
Scenario: Client views a plan for which they have already giving feedback
  Given Client approver has already given feedback about a plan
  When they view it again
  Then instead of Approve / Reject buttons they see the plan status (client version)*
    And the message that was captured at the time requesting approval
    And they can see when they gave feedback and what message they left at the time
