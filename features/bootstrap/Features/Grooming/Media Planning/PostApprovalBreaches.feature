Feature: Post approval breaches
In order to ensure that media plans continusouly comply with agreements I've made with the Client and Suppliers
As Campaign Manager
I want Olive to detect the impact my published changes have on them and update status accordingly

Scenario: Configure Breach thresholds (OTD-773)
  Given media Plan Exists
  When I edit media plan details
  Then I see a field "Breach threshold (percent of Total Plan budget)" and I can specify a numeric amount between 0 and 100. This indicates the change threshold amount as a % of Total Plan budget which cannot be exceeded when publishing new spend with a specific supplier / property / liable entity post plan approval group.
    And by default the "Breach threshold (percent of Total Plan budget)" is set to %20

Scenario: Detect impact of changes to be published / approved on Client Approval Status
  # Start with a Client Approval requested for a plan a line of $ 10,000 on Facebook
  # CLient approves a line of $ 10,000 Facebook
  # Am publishes 5,000 upweight - needs re-apprval internally
  # Client sees 10,000 for Facebook
  # AM internally approves the upweight
  # Client sees 15,000
  # AM publishes 1,000 upweight - needs re-approval internally AND client re-approval
  # Client sees 15,000
  # a) AM Approves upweight to 16,00 - plan is breached and needs Client re-approval
  # a) Client sees 15,000
  # a) AM requests client approval
  # a) Client sees 16,000 and highlight that it's different from:
  #     Last approved: 10,000 (beause otherwise the difference might not be big enough to cause a breach and could be confusing)
  #     Last auto-approved: 15,000
  # b) AM Rejects upweight to 16,00
  # b) Client still sees 15,000
  # ba) AM resets back to 14,000 and publishes - plan changes are checked against last client approved and Client plan status is re-stated to APproved!!!
  # ba) Client sees 14,000
  # bb) AM resets to 15,500 and publishes -
  # bb) Client Sees 15,000
  # bb) AM internally approves the upweight
  # bb) Client sees 15,500

Scenario: Publish Upweight by amount that breaches set thresholds (OTD-1988)
  Given Media Plan has been approved by client
    And Breach thresholds have been configured
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And  there are upweights in totals of group of lines (grouping outlined below) would lead to an increase that exceeds breach thresholds when compared to last client approved version
    # --------------------------------------
    # If platform is not DBM, then group by:
    # * Supplier
    # * Property
    # * Liable (Client or Essence)
    # Otherwise (for DBM - bespoke)
    # * Insertion Order
    #---------------------------------------
  When changes are published
  Then user is presented with a prompt that approval will be breached
    # The changes you are about to publish will invalidate client plan approval due to the following:
    # (list each breach that applies)
    # -- The total upweights of a single property under the same supplier and liability exceeds ({breach threshold}%) of the last approved total plan budget.
    # -- The total plan budget has increased.
    # -- A new supplier or property has been added to the plan.
    # If you continue, you will need to request client approval for this new version of the plan. Do you wish to publish changes?
    # Cancel/Publish
    And on confirming, Media Plan status changes to "Published"
    And "Breach" flag becomes visible as a block icon between "Internally approved" and "Client Approval requested" statuses
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                    |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Amends, Client approval breach |N/A     |        |
    And unchanged Insertion Order status remains unaffected
    And changed Insertion Order status changes to "Amends Published"
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Olive saves an Event in the changed IOs' history:
      # ------------------------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                                     |Document| Notes  |
      # ------------------------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published budget upweight from [] to []                   |N/A     |        |
      # |Datetime |Currently Logged in User | IO status changed  from [] to []                          |N/A     |        |

Scenario: Publish Upweight by amount that doesn't breach thresholds (OTD-1988)
  Given Media Plan has been approved by client
    And Breach thresholds have been configured
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And there are upweights in totals of group of lines (grouping outlined below) but none lead to an increase that exceeds breach thresholds when compared to last client approved version
      # --------------------------------------
      # If platform is not DBM, then group by:
      # * Supplier
      # * Property
      # * Liable (Client or Essence)
      # Otherwise (for DBM - bespoke)
      # * Insertion Order
      #---------------------------------------
  When changes are published
  Then Media Plan status remains unchanged
    And unchanged Insertion Order status remains unaffected
    And changed Insertion Order status changes to "Amends Published"
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Olive saves an Event in the changed IOs' history:
      # ------------------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             |Document | Notes  |
      # ------------------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published budget upweight from [] to []           |N/A      |        |

Scenario: Publish downweight (OTD-1988)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And there are no upweights, but some groups of lines are downweighted
  When changes are published
  Then Media Plan status remains unchanged
    And all Insertion Order status remains unaffected
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Olive saves an Event in the changed IOs' history:
      # ----------------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                           |Document | Notes  |
      # ----------------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published budget downweight from [] to []       |N/A      |        |

Scenario: Publish new property / supplier (OTD-1988)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And a completely new group of lines (grouping outlined below) enters the plan when compared to last client approved version
    # --------------------------------------
    # If platform is not DBM, then gorup by:
    # * Supplier
    # * Property
    # * Liable (Client or Essence)
    # Otherwise (for DBM - bespoke)
    # * Insertion Order
    #---------------------------------------
  When changes are published
  Then user is presented with a prompt that approval will be breached
    # The changes you are about to publish will invalidate client plan approval due to the following:
    # (list each breach that applies)
    # -- The total upweights of a single property under the same supplier and liability exceeds ({breach threshold}%) of the last approved total plan budget.
    # -- The total plan budget has increased.
    # -- A new supplier or property has been added to the plan.
    # If you continue, you will need to request client approval for this new version of the plan. Do you wish to publish changes?
    # Cancel/Publish
    And on confirming, Media Plan status changes to "Published"
    And "Breach" flag becomes visible as a block icon between "Internally approved" and "Client Approval requested" statuses
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                    |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Amends, Client approval breach |N/A     |        |
    And unchanged Insertion Order status remains unaffected
    And changed Insertion Order status changes to "Amends Published"
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Olive saves an Event in the changed IOs' history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                     |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published with budget []                  |N/A     |        |

Scenario: Publish Cancelled property / supplier (OTD-1988)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And there are no upweights, but at least one group of lines is removed completely (or downweighted to 0.00) when compared to last client approved version
  When changes are published
  Then user is presented with a prompt that Clients will be notified
      # "Client approvers will receive an email that {Insertion Order Name(s)} has/have been removed from the plan}"
    And Media Plan status remains unchanged
    And unchanged Insertion Order status remains unaffected
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Olive saves an Event in the changed IOs' history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                   |Document | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Cancelation                   |N/A      |        |

Scenario: Publish Changes in plan line dates (OTD-1988)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And there are no upweights, but some lines have changed flight dates
  When changes are published
  Then Media Plan status remains unchanged
    And all Insertion Order status remains unaffected
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Olive saves an Event in the changed IOs' history:
      # -------------------------------------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                                                |Document | Notes  |
      # -------------------------------------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published date change from [Previous Date Range] to [New Date Range] |N/A      |        |



Scenario: Publish increased Plan budget (OTD-2009)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And Draft media plan total budget has been increased when compared to the last Client approved version
  When changes are published
  Then user is presented with a prompt that approval will be breached
      # The changes you are about to publish will invalidate client plan approval due to the following:
      # (list each breach that applies)
      # -- The total upweights of a single property under the same supplier and liability exceeds ({breach threshold}%) of the last approved total plan budget.
      # -- The total plan budget has increased.
      # -- A new supplier or property has been added to the plan.
      # If you continue, you will need to request client approval for this new version of the plan. Do you wish to publish changes?
      # Cancel/Publish
    And on confirming, Media Plan status changes to "Published"
    And "Breach" flag becomes visible as a block icon between "Internally approved" and "Client Approval requested" statuses
    And Olive saves 2 Events in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Budget Upweight from [] to []           |        |
      # |Datetime |Currently Logged in User | Client approval breach                            |        |

Scenario: Publish decreased plan budget (OTD-2009)
  Given Media Plan has been approved by client
    And Draft media plan total budget has been decreased when compared to the last Client approved version
  When changes are published
  Then user is presented with a promt that Clients will be notified
      # "Client approvers will receive an email that the plan budget has been decreased from {Previous plan budget} to {New plan budget}"
    And on confirming, Media Plan status remains unchanged
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Budget downweight from [] to []         |        |

Scenario: Publish Changed plan dates (OTD-2009)
  Given Media Plan has been approved by client
    And Draft media plan flight dates have been changed when compared to the last Client approved version
  When changes are published
  Then user is presented with a promt that Clients will be notified
      # "Planned dates for the plan "{Media Plan Name}" have changed from
      # {Previous Date Range} to {New Date Range} by {Publisher Name}."
      # e.g. "Planned dates for the plan "Google Chrome EMEA Q2 2015 UK" have changed from "1 Jan 2015 - 2 Jan 2015" to "2 Jan 2015 - 3 Jan 2015" by Zanete Ence."
    And on confirming, Media Plan status remains unchanged
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Date Changes from [] to []              |        |

Scenario: Publish changes to breach thresholds (OTD-2009)
  Given Media Plan has been approved by client
    And Draft media plan breach thresholds dates have been changed when compared to the last Client approved version
  When changes are published
  Then user is presented with a prompt that Clients will be notified
      # @todo - Decide how we roll this up with other notifications when plan is published
      # "You are about to publish changes to the breach thresholds. Client approvers will be notified. Do you wish to continue?
      # Cancel/Publish"
    And on confirming, Media Plan status remains unchanged
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Breach thresholds Changes from [] to [] |        |

# TO DISCUSS
Scenario: Notify Media Plan manager of published change impact (OTD-782)
  Given a media plan has been approved by the client
    And changes are made to either plan meta data or budget allocations within plan
  When changes are published
  Then Media Plan Manager receives notifications with "medium" priority, with dynamic values emphasised as outlined in table below
    And they can dismiss the notification without taking any action
    And if multiple changes are published at the same time, each one is represented in its own notification
  #=================================================================================================================================================================================|
  # Change                          |Notification                                                       | Example                                                                   |
  #=================================================================================================================================================================================|
  # Plan Status change              | The status of the plan "*{Media plan name}*" has changed          | "The status of the plan "Google Chrome EMEA Q2 2015 UK" has changed       |
  #                                 | from *{Old Status value}* to *{New Status value}*                 | from Client Aproved to Published"                                         |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Plan budget changes             | "Total budget for the approved plan "{Media Plan Name}"           |
  #                                 | has changed from {Previous Plan Budget} to {New Plan Budget}      |
  #                                 | by {Publisher Name}, and requires internal and client reapproval."|
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Plan date changes               | "Planned dates for the plan "{Media Plan Name}" have changed      | "Planned dates for the plan "Google Chrome EMEA Q2 2015 UK" have changed  |
  #                                 | from {Previous Date Range} to {New Date Range}                    | from "1 Jan 2015 - 2 Jan 2015" to "2 Jan 2015 - 3 Jan 2015"               |
  #                                 | by {Publisher Name}."                                             |  by Zanete Ence"                                                          |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Plan breach threshold changes   | "Breach Thresholds for the approved plan "*{Media plan name}*"    | "Breach Thresholds for the approved plan "Google Chrome EMEA Q2 2015 UK"  |
  #                                 |  have changed from *{Old Thresholds}* to *{New Thresholds}*"      |  have changed from 20% to 95%"                                            |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # New Suppliers / Properties      | "Planned budget for {Property} ({Insertion Order Name}) in the    | "Planned budget for Google Search ("DS3 - Google Ireland Ltd #128") in    |
  #                                 | plan "{Media Plan Name}" has changed from 0.00 to                 | the plan "Google Chrome EMEA Q2 2015 UK" has changed from USD 0.00 to     |
  #                                 | {New Total for supplier / property / lbe} by {Publisher Name},    | USD 8,000 by Zanete Ence, and requires internal and client reapproval."   |
  #                                 | and requires internal and client reapproval."                     |                                                                           |
  #                                 | @todo - review information in message                             |                                                                           |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Upweights within plan           | "Planned budget for {Property} ({Insertion Order Name}) in the    | "Planned budget for Google Search ("DS3 - Google Ireland Ltd #128") in    |
  #   exceed breach threshold       | plan "{Media Plan Name}" has changed from {Previous IO Total} to  | the plan "Google Chrome EMEA Q2 2015 UK" has changed from USD 5,000 to    |
  #                                 | {New IO Total} by {Publisher Name}, and requires internal and     | USD 8,000 by Zanete Ence, and requires internal and client reapproval."   |
  #                                 | client reapproval."                                               |                                                                           |
  #                                 | @todo - review information in message                             |                                                                           |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Upweights within plan           | "Planned budget for {Property} ({Insertion Order Name}) in the    | "Planned budget for Google Search ("DS3 - Google Ireland Ltd") in the     |
  #   not exceed breach threshold   |  plan "{Media Plan Name}" has changed from {Previous IO Total}    | plan "Google Chrome EMEA Q2 2015 UK" has changed from USD 5,000 to        |
  #                                 | to {New IO Total} by {Publisher Name}, and requires internal      | USD 3,000 by Zanete Ence, and requires internal reapproval"               |
  #                                 | reapproval"                                                       |                                                                           |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Downweights within plan         | "Planned budget for {Property} ({Insertion Order Name}) in the    | "Planned budget for Google Search ("DS3 - Google Ireland Ltd") in the     |
  #                                 |  plan "{Media Plan Name}" has changed from {Previous IO Total}    | plan "Google Chrome EMEA Q2 2015 UK" has changed from USD 5,000 to        |
  #                                 | to {New IO Total} by {Publisher Name}. "                          | USD 3,000 by Zanete Ence"                                                 |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Cancelled properties / suppliers| "Planned budget for {Property} ({Insertion Order Name}) in the    | "Planned budget for Google Search ("DS3 - Google Ireland Ltd") in the     |
  #  (downweights to 0)             |  plan "{Media Plan Name}" has changed from {Previous IO Total}    | plan "Google Chrome EMEA Q2 2015 UK" has changed from USD 5,000 to        |
  #                                 | to 0.00 by {Publisher Name}. "                                    | USD 0.00 by Zanete Ence"                                                  |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  # Changes to individual IO dates  | "Planned dates for {Property} ({Insertion Order Name}) in the     | "Planned dates for Google Search ("DS3 - Google Ireland Ltd") in          |
  #                                 | plan "{Media Plan Name}" have changed from {Previous Date Range}  | Google Chrome EMEA Q2 2015 UK plan have changed from                      |
  #                                 | to {New Date Range} by {Publisher Name}."                         | "1 Jan 2015 - 2 Jan 2015" to "2 Jan 2015 - 3 Jan 2015" by Zanete Ence."   |
  #                                 | (Range is from Min IO date to Max IO date)                        |                                                                           |
  #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|


Scenario: Notify Clients of published changes to approved plan (OTD-783)
  Given media plan has been approved by the client
    And new changes for which the client has to be notified, have been made  (e.g. decrease in total budget, cancellations etc)
    But there are no breaching changes
  When these changes are published
    Then Client approvers receive one email with a summary of these changes as outlined below  # (header, list of changes, footer)
    # Email Subject: Changes to Media Plan: {Media Plan Name} (ID: {Media Plan ID}) (No action required)
    # Body Text:
    # (header)
    # Dear {Client Approver}, this is a notification that changes have been published to the plan, "{Media Plan Name}".
    # (list each notification that applies)
    #=================================================================================================================================================================================|
    # Change                          |Notification                                                       | Example                                                                   |
    #=================================================================================================================================================================================|
    # Plan budget changes             | "Total Plan Budget has changed from                               | "Total Plan Budget has changed from USD 5,000 to USD 4,000."              |
    #  (downweight)                   | {Previous Plan Budget} to {New Plan Budget}."                     |                                                                           |
    #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Plan date changes               | "Planned Dates have changed from                                  | "Planned Dates have changed from "1 Jan 2015 - 2 Jan 2015" to             |
    #                                 | has changed from {Previous Date Range} to {New Date Range}."      | "2 Jan 2015 - 3 Jan 2015"."                                                 |
    #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Plan breach threshold changes   | "The Breach Threshold has changed from                            | "The Breach Threshold has changed from 10% to 20%.                        |
    #                                 | {Previous Trheshold %} to {New Threshold %}.                      |                                                                           |
    #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    # Cancelled properties / suppliers| "Planned Budget for {Property} ({Insertion Order Name})           | "Planned budget for Google Search ("DS3 - Google Ireland Ltd")            |
    #  (downweights to 0)             |  has changed from {Previous IO Total} to {currency} 0.00          | has changed from USD 5,000 to USD 0.00 and has been cancelled.            |
    #                                 |  and has been cancelled."                                         |                                                                           |
    #---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
    #
    # (footer)
    # No action is required from you, but you can view the revised Media Plan [here|link to plan].
    #
    # If clicking the above link does not work, please copy and paste the following into the address bar of your browser:
    # {link to plan as text}
    #
    # Regards,
    # Olive
    # -------------------------------------
    # Essence
    # www.essencedigital.com
    # -------------------------------------
    # This email may be confidential or privileged. If you received this communication by mistake, please don't forward it to anyone else, please erase all copies and attachments and please let me know that it went to the wrong person. Thank you.

  Scenario: Notify IO owners of published changes in their IOs post approval
    Given a media plan has been approved by the client
      And changes are made to budget allocations within plan
      And changes are  one or more of the following:
      #-----------------------------------------------------------
      # Change
      #-----------------------------------------------------------
      # New Properties / suppliers
      # Upweights within plan that exceed breach threshold
      # Upweights within plan that do not exceet breach threshold
      # Downweights within plan
      # Cancelled properties / suppliers (downweights to 0)
      # Changes to individual IO dates
      #-----------------------------------------------------------
    When changes are published
    Then affected existing or new IO Owners receive a notification (s) summarising changes, with dynamic values emphasised


#### STATUS CHANGE TESTS
Scenario: New Property
Given A Media Plan is Client Approved
  And it has two Insertion orders for suppliers "AOL" and "Channel 5", both "Internally Approved" and both "Supplier Confirmed"
  And I have added a new Property "Tech Crunch" into Draft version
  And it is added to an Insertion Order for "AOL"
When I publish these changes
Then the "AOL" Insertion Order Internal Status changes to "Published"
  And "AOL" Insertion Order Supplier Confirmation is revoked
  And the Media Plan Status changes to "Published"
  And "Channel 5" Insertion Order Internal Status remains "Internally Approved"
  And "Channel 5" Insertion Order Supplier Confirmation remains

Scenario: Breaching Upweight
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has two Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Supplier Confirmed  |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |
    And I have upweighted a line in "AOL" Insertion Order by $30
  When I publish these changes
  Then the Media Plan Status changes to "Published"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $60       | TechCrunch  | Published           | Not confirmed       |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Confirmed           |


Scenario: Upweight / Downweight with no effect
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


Scenario: Upweight / Downweight with Internal Re-approval
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has 3 Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Supplier Confirmed  |
    # AOL         | $30       | TechCrunch  | Internally Approved | Supplier Confirmed  |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |
    And I have upweighted a line in 1st "AOL" Insertion Order by $25
    And I have downweighted a line in 2nd "AOL" Insertion Order by $10
    #the total change for supplier / property is only 15$ - not breaching but upweight requires internal re-approval
  When I publish these changes
  Then the Media Plan Status remains to "Client Approved"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $30       | TechCrunch  | Published           | Not confirmed       |
    # AOL         | $30       | TechCrunch  | Internally Approved | Not confirmed       |
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |

Scenario: Breaching Move within IO
  Given A Media Plan of a "$100" is "Client Approved"
    And I have set the breach threshold to be "20%"
    And it has 2 Insertion orders as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $30       | TechCrunch  | Internally Approved | Supplier Confirmed  |
    #             | $30       | Last.Fm     |                     |                     |
    # ----------------------------------------------------------------------------------
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |
    And I have upweighted a "TechCrunch" line by "$25"
    And I have downweighted "LastFM" line by "$25"
    #the total of iO remains unchanged but breaching thresholds for supplier / property
    #- requires internal re-approval and client re-approval
  When I publish these changes
  Then the Media Plan Status changes to "Published"
    And Insertion Order statuses and budgets are as outlined below
    # Supplier    | Total net | Property    | Internal Status     | Supplier Status     |
    # ==================================================================================|
    # AOL         | $55       | TechCrunch  | Published           | Not confirmed       |
    #             | $5        | Last.Fm     |                     |                     |
    # ----------------------------------------------------------------------------------
    # Channel 5   | $10       | Channel 5   | Internally Approved | Supplier Confirmed  |

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
