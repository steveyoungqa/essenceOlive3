Feature: Post approval breaches
In order to ensure that media plans continusouly comply with agreements I've made with the Client and Suppliers
As Campaign Manager
I want Olive to detect the impact my published changes have on them and update status accordingly

Scenario: Configure Breach thresholds (OTD-773)
  Given media Plan Exists
  When I edit media plan details
  Then I see a field "Breach threshold (as absolute amount in Plan currency)" and I can specify a numeric amount. This amount indicates the change threshold which cannot be exceeded when publishing new spend with a specific supplier / property / liable entity post plan approval group.
    And by default the "Breach threshold (as absolute amount in Plan currency)" is set to 10,000.00
    And I see a field "Breach threshold (percent of Total Plan budget)" and I can specify a numeric amount between 0 and 100. This indicates the change threshold amount as a % of Total Plan budget which cannot be exceeded when publishing new spend with a specific supplier / property / liable entity post plan approval group.
    And by default the "Breach threshold (percent of Total Plan budget)" is set to %20

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
#    @todo - Helen to tidy up text
    # "The changes you are about to publish exceed the breach thresholds set for this plan ({breach threshold percent}% of total media or {breach absolute value}] {currency})*, or you have increased the plan budget or added a new supplier/property.
    # If you continue, you will need to request client approval for this new plan version. Do you wish to publish changes?
    # Cancel/Publish"
    # *Plans require client reapproval if the plan budget is increased; a supplier or property is added to the plan; or the total upweights of a single property with the same supplier and liability exceeds the agreed % of the last approved total media plan budget, or the agreed fixed threshold amount, whichever is reached first."
    # (The above description of what constitutes a breach is a footnote in the prompt)
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
    # If platform is not DBM, then gorup by:
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
    # "The changes you are about to publish exceed the breach thresholds set for this plan ({breach threshold percent}% of total media or {breach absolute value}] {currency})*.
    # If you continue, you will need to request client approval for this new plan version. Do you wish to publish changes?
    # Cancel/Publish"
    # *Plans require client reapproval if a supplier or property is added to the plan, or the total upweights of a single property with the same supplier and liability exceeds the agreed % of the last approved total media plan budget, or the agreed fixed threshold amount, whichever is reached first."
    # (The above description of what constitutes a breach is a footnote in the prompt)
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
    # "The changes you are about to publish exceed the breach thresholds set for this plan ({breach threshold percent}% of total media or {breach absolute value}] {currency})*, or you have increased the plan budget or added a new supplier/property.
    # If you continue, you will need to request client approval for this new plan version. Do you wish to publish changes?
    # Cancel/Publish"
    # *Plans require client reapproval if the plan budget is increased; a supplier or property is added to the plan; or the total upweights of a single property with the same supplier and liability exceeds the agreed % of the last approved total media plan budget, or the agreed fixed threshold amount, whichever is reached first."
    # (The above description of what constitutes a breach is a footnote in the prompt)
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
#      @todo - Decide how we roll this up with other notifications when plan is published
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
  Then Media Plan Manager receives a notification (s) summarising changes, with dynamic values emphasised as outlined in table below
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
    Then Client approvers receive one email with a summary of these changes as outlined in table below

#      @todo - Need a new scenario for when a published plan has changes that require both just notification as well as reapproval
      # "Dear {Client Approver}, this is a notification that changes have been published to the plan, "{Media Plan Name}"
      # "Planned budget for {Property} ({Insertion Order Name}) has changed from {Previous IO Total} to {New IO Total}. No action is required from you."
    And Client approvers receive a notification (multiple changes that require notification are listed in the same email)
        # "Dear {Client Approver}, this is a notification that changes have been published to the plan, "{Media Plan Name}"
        # "The plan budget for the plan "{Plan Name}" has changed from {Previous Plan Budget} to {New Plan budget}. No action is required from you."
    And Client approvers receive a notification
      # "Dear {Client Approver}, this is a notification that changes have been published to the plan, "{Media Plan Name}"
      # "The dates for the plan "{Plan Name}" have changed from {Previous Plan Date Range} to {New Plan Date Range}. No action is required from you."
    And Client approvers receive a notification
      # "Dear {Client Approver}, this is a notification that changes have been published to the plan, "{Media Plan Name}
      # The breach thresholds have been changed from {previous breach thresholds} to {new breach thresholds}. No action is required from you."
      # e.g. "Dear {Client Approver}, this is a notification that changes have been published to the plan, "Google Chrome EMEA Q2 2015 UK"
      # The breach thresholds have been changed from USD 100,000.00 or 20% to USD 100,000.00 or 95%. No action is required from you."

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
