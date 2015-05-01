Feature: Post approval breaches
In order to ensure that media plans continusouly comply with agreements I've made with the Client and Suppliers
As Campaign Manager
I want Olive to detect the impact my published changes have on them and update status accordingly

Scenario: Configure Breach thresholds (OTD-773)
  Given
  When
  Then

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
  Then user is presented with a promt
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
  Then user is presented with a promt
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

Scenario: Publish decreased plan budget (OTD-2009)

Scenario: Publish Changed plan dates (OTD-2009)

Scenario: Pubish changes to breach thresholds (OTD-2009)
