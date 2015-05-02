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
    # If platform is not DBM, then gorup by:
    # * Supplier
    # * Property
    # * Liable (Client or Essence)
    # Otherwise (for DBM - bespoke)
    # * Insertion Order
    #---------------------------------------
  When changes are published
  Then user is presented with a promt that approval will be breached
    @todo - text with Helen
    # ""
    And on confirming, Media Plan status changes to "Published"
    And "Breach" flag becomes visible
    And Media Plan Manager receives a notification, with dynamic values emphasised
      @todo - review with Helen
      # *{Media plan name}*  plan status has changed from *{Old Status value}* to *{New Status value}*
      # e.g. "Google Chrome EMEA Q2 2015 UK plan status has changed from Client Aproved to Published"
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                    |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Amends, Client approval breach |N/A     |        |
    And unchanged Insertion Order status remains unaffected
    And changed Insertion Order status changes to "Amends Published"
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Media Plan Managers and Owners of changed Insertion Orders receive notificaiton about budget change, with dynamic values emphasised
      @todo - review with Helen
      @todo - decide where the IO status change message belongs
      # "Planned Budget for Olive Insertion Order {Insertion Order Name} in {Media Plan Name} plan has changed from
      # {Previous IO Total} to {New IO Total} by {Publisher Name}"
      # e.g. "Planned budget for Olive Insertion Order 'DBM - Google Ireland Ltd. PMP - Non-Adx '
      # in Google Chrome EMEA Q2 2015 UK plan has changed from USD 5,000 to USD 8, 000 by Zanete Ence."
    And Olive saves an Event in the changed IOs' history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                    |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published upweight from [] to []  |N/A   |        |        |


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
    And Media Plan Manager and affected IO Owners receives a notification, with dynamic values emphasised
      @todo - review with Helen
      @todo - decide where the IO status change message belongs
      # "Planned Budget for Olive Insertion Order {Insertion Order Name} in {Media Plan Name} plan has changed from
      # {Previous IO Total} to {New IO Total} by {Publisher Name}"
      # e.g. "Planned budget for Olive Insertion Order 'DBM - Google Ireland Ltd. PMP - Non-Adx '
      # in Google Chrome EMEA Q2 2015 UK plan has changed from USD 5,000 to USD 8, 000 by Zanete Ence."
    And Olive saves an Event in the changed IOs' history:
      # --------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                             |Document | Notes  |
      # --------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published upweight from [] to []  |N/A      |        |

Scenario: Publish downweight (OTD-1988)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And there are no upweights, but some groups of lines are downweighted
  When changes are published
  Then Media Plan status remains unchanged
    And all Insertion Order status remains unaffected
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Media Plan Manager and affected IO Owners receives a notification, with dynamic values emphasised
      @todo - review with Helen
      # "Planned Budget for Olive Insertion Order {Insertion Order Name} in {Media Plan Name} plan has changed from
      # {Previous IO Total} to {New IO Total} by {Publisher Name}"
      # e.g. "Planned budget for Olive Insertion Order 'DBM - Google Ireland Ltd. PMP - Non-Adx '
      # in Google Chrome EMEA Q2 2015 UK plan has changed from USD 5,000 to USD 8, 000 by Zanete Ence."
    And Olive saves an Event in the changed IOs' history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                   |Document | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published downweight from [] to []      |N/A      |        |


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
  Then user is presented with a promt that approval will be breached
    @todo - text with Helen
    # ""
    And on confirming, Media Plan status changes to "Published"
    And "Breach" flag becomes visible
    And Media Plan Manager receives a notification, with dynamic values emphasised
      @todo - review with Helen
      # *{Media plan name}*  plan status has changed from *{Old Status value}* to *{New Status value}*
      # e.g. "Google Chrome EMEA Q2 2015 UK plan status has changed from Client Aproved to Amends Published"
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                    |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Amends, Client approval breach |N/A     |        |
    And unchanged Insertion Order status remains unaffected
    And changed Insertion Order status changes to "Amends Published"
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Media Plan Managers and Owners of changed Insertion Orders receive notificaiton about budget change, with dynamic values emphasised
      @todo - review with Helen
      @todo - decide where the IO status change message belongs
      # "Planned Budget for Olive Insertion Order {Insertion Order Name} in {Media Plan Name} plan has changed from
      # 0.00 to {New IO Total} by {Publisher Name}"
      # e.g. "Planned budget for Olive Insertion Order 'DBM - Google Ireland Ltd. PMP - Non-Adx '
      # in Google Chrome EMEA Q2 2015 UK plan has changed from USD 0.00 to USD 8, 000 by Zanete Ence."
    And Olive saves an Event in the changed IOs' history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                    |Document| Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published upweight from [] to []  |N/A   |        |        |


Scenario: Publish Cancelled property / supplier (OTD-1988)
  Given Media Plan has been approved by client
    And Campaign hasn't ended yet (Media Plan End date is in the future)
    And there are no upweights, but at least one group of lines is removed completely (or downweighted to 0.00) when compared to last client approved version
  When changes are published
  Then user is presented with a promt that Clients will be notified
      @todo - text with Helen
      # ""
    And Media Plan status remains unchanged
    And Client approvers receive a notification
      @todo - tet with Helen
      # ""
    And uncahgend Insertion Order status remains unaffected
    And changed Insertion Order supplier sign-off confirmation is reset (if supplier works with IOs)
    And Media Plan Manager and affected IO Owners receives a notification, with dynamic values emphasised
      @todo - review with Helen
      # "Planned Budget for Olive Insertion Order {Insertion Order Name} in {Media Plan Name} plan has changed from
      # {Previous IO Total} to 0.00 by {Publisher Name}"
      # e.g. "Planned budget for Olive Insertion Order 'DBM - Google Ireland Ltd. PMP - Non-Adx '
      # in Google Chrome EMEA Q2 2015 UK plan has changed from USD 5,000 to USD 0.00 by Zanete Ence."
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
    And Media Plan Manager and affected IO Owners receives a notification, with dynamic values emphasised
      @todo - review with Helen
      # "Planned Dates for Olive Insertion Order {Insertion Order Name} in {Media Plan Name} plan has changed from
      # {Previous Date Range} to {New Date Range} by {Publisher Name}" (Range is from Min IO date to Max IO date)
      # e.g. "Planned Dates for Olive Insertion Order 'DBM - Google Ireland Ltd. PMP - Non-Adx '
      # in Google Chrome EMEA Q2 2015 UK plan has changed from USD 5,000 to USD 8, 000 by Zanete Ence."
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
  Then user is presented with a promt that approval will be breached
    @todo - text with Helen
    # ""
    And on confirming, Media Plan status changes to "Published"
    And "Breach" flag becomes visible
    And Media Plan Manager receives a notification about Media Plan Status change, with dynamic values emphasised
      @todo - review with Helen
      # ""*{Media plan name}*  plan status has changed from *{Old Status value}* to *{New Status value}*"
      # e.g. "Google Chrome EMEA Q2 2015 UK plan status has changed from Client Aproved to Published"
      @todo - decide where the Budget change message belongs
      # "Total budget for the approved *{Media plan name}*  plan has changed from *{Old Budget value}* to *{New Budget value}*"
      # e.g. "Total budget for the approved Google Chrome EMEA Q2 2015 UK plan has changed from GBP 80,000 to GBP 100, 000"
    And Olive saves 2 Events in the Plan history:
      @todo - decide if it should be just one
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
      @todo - text with Helen
      # ""
    And on confirming, Media Plan status remains unchanged
    And Client approvers receive a notification
      @todo - text with Helen
      # ""
    And Media Plan Manager receives a notification about Media Plan budget change, with dynamic values emphasised
      @todo - review with Helen
      # "Total budget for the approved *{Media plan name}*  plan has changed from *{Old Budget value}* to *{New Budget value}*"
      # e.g. "Total budget for the approved Google Chrome EMEA Q2 2015 UK plan has changed from GBP 80,000 to GBP 100, 000"
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
      @todo - text with Helen
      # ""
    And on confirming, Media Plan status remains unchanged
    And Client approvers receive a notification
      @todo - text with Helen
      # ""
    And Media Plan Manager receives a notification about Media Plan date changes, with dynamic values emphasised
      @todo - review with Helen
      # "Dates for the approved *{Media plan name}*  plan have changed from *{Old date range}* to *{New date range}*"
      # e.g. "Dates for the approved Google Chrome EMEA Q2 2015 UK plan have changed from 1 Jan 2015 - 31 Mar 2015 to 1 Jan 2015 - 14 Apr 2015"
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Date Changes from [] to []              |        |

Scenario: Publish changes to breach thresholds (OTD-2009)
  Given Media Plan has been approved by client
    And Draft media plan breach thresholds dates have been changed when compared to the last Client approved version
  When changes are published
  Then user is presented with a promt that Clients will be notified
      @todo - text with Helen
      # ""
    And on confirming, Media Plan status remains unchanged
    And Client approvers receive a notification
      @todo - text with Helen
      # ""
    And Media Plan Manager receives a notification about Media Plan breach threshold changes, with dynamic values emphasised
      @todo - review with Helen
      # "Breach Thresholds for the approved *{Media plan name}*  plan have changed from *{Old Thresholds}* to *{New Thresholds}*"
      # e.g. "Breach Thresholds for the approved Google Chrome EMEA Q2 2015 UK plan have changed from USD 100,000.00 or 20% to USD 100,000.00 or 95%"
    And Olive saves an Event in the Plan history:
      # --------------------------------------------------------------------------------------------------
      # |Time     |User                     |Action                                             | Notes  |
      # --------------------------------------------------------------------------------------------------
      # |Datetime |Currently Logged in User | Published Breach thresholds Changes from [] to [] |        |
