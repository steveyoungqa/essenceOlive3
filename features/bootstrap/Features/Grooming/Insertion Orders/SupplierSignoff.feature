Feature: Supplier Sign-off

#TO FLESH OUT
Scenario: Indicate Supplier works with IOs
  Given
  When
  Then Checkbox is labelled "Works with IO?" instead of "Requires IO?"

#(reviewed 23th April)
Scenario: Disallow changing Supplier post approval (OTD-2008)
  Given the supplier has been set on the IO
  When  the IO is published
  Then  disalow the Supplier to be changed

#(reviewed 23th April)
Scenario: Indicate Supplier Media buy confirmation (OTD-1916)
  Given the Media Plan has been internally or client approved
    And the IO has been generated
    And I am on the IO details view
  When confirming onbehalf of the supplier
  Then allow the user to upload a copy of the supplier IO
    And allow the user to capture a note
    And allow them to save the confirmation
    And display the following text:
    |I [planner name], confirm that supplier has counter signed this IO - TBC with Helen|
    And save an action in the history:
#    ------------------------------------------------------------------------
#    |Time     |User                     |Action                  |Details  |
#    ------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | Supplier Buy Confirmed | N/A     |

#(reviewed 23th April)
Scenario: If the IO is Breached or Changed due to the Plan changing (OTD-2014)
  Given the IO was Supplier IO approvaed
    And changes are being made to the entire plan
    And the changes affect this IO
  When the changes to the IO are published
    And the IO supplier counter signature is invalidated
  Then remove the Supplier approval against the IO
    And A new event is added to the history
#    ------------------------------------------------------------------------------
#    |Time     |User                     |Action                 |Document| Notes  |
#    ------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | IO [upweight, downwegith] leading to invalidated Supplier confirmation | N/A    |        |

#(reviewed 23th April)
Scenario: If the IO is Breached or Changed due to a plan line changing (OTD-2014)
  Given the IO was Supplier IO approvaed
    And changes are being made to an individual plan line (changed Budget or Dates, also consider currency as budget meaning changes if combined with different currency)
    And the changes affect this IO
  When the changes to the IO are published
    And the IO  supplier counter signature is invalidated
  Then remove the Supplier approval against the IO
    And A new event is added to the history
#    ------------------------------------------------------------------------------
#    |Time     |User                     |Action                 |Document| Notes  |
#    ------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | IO [upweight, downwegith] leading to invalidated Supplier confirmation | N/A    |        |

#(reviewed 23th April)
Scenario: If the IO is cancelled post Supplier approval (OTD-2014)
  Given the IO was supplier approved
    And I've made changes to the plan that cancels the activity completely (0.00)
  When I publish these changes
  Then the IO status changes to "Published"
    And Supplier approval is removed
    And A new event is added to the history
#    ------------------------------------------------------------------------------
#    |Time     |User                     |Action                 |Document| Notes  |
#    ------------------------------------------------------------------------------
#    |Datetime |Currently Logged in User | IO Down weighted to 0 | N/A    |        |

#(reviewed 24th April)
Scenario: Warn about spending without confirmed Supplier sign-off (OTD-1973)
  Given I have set up a plan line for a supplier that requires countersigning an IO (e.g. Yahoo! Inc)
    And I have mapped DS3 search campaigns that are spending during the plan line flight
    And Supplier Sign-off has not been confirmed (OTD-1916)
    When I look at the plan in Olive 3
  Then I can see a warning icon against the spending lines on the left side (as indicated in attached screenshot)
    And On hover over the warning I see a message saying: "This plan line is spending without confirmed supplier sign-off. Please confirm supplier has countersigned IO or stop spend"
    And IO Owner and Media Plan manager receives a persistent (until issue fixed) notification on the homepage saying: "Spend against Lines in IO [IO Label] without confirmed Supplier Sign-off. Please confirm Supplier has countersigned IO or stop spend" with a link to the problem IO

#(reviewed 24th April)
Scenario: Ignore overspend (OTD-1973)
  Given I have set up a plan line for a supplier that requires countersigning an IO (e.g. Yahoo! Inc)
    And I have mapped DS3 search campaigns that are spending during the plan line flight
    And Supplier Sign-off has been confirmed (OTD-1916)
    And the Actual spend is greater than planned net budget for that line
  Then I do not see a warning about spending over planned budget (Scenario 2 in OTD-575)

#(reviewed 24th April)
Scenario: Spend against supplier confirmed cancelled IOs (OTD-1973)
  Given I have downweighted a Supplier IO to 0 (e.g. Yahoo! Inc)
    And have published the changes
    And have confirmed Supplier Sign-off on the 0.00 amount
    And I have mapped DS3 search campaigns that are spending during the plan line flight
  When I look at the plan in Olive 3
  Then I can see a warning icon against the spending lines on the left side (as indicated in attached screenshot)
    And On hover over the warning I see a message saying: "This plan line is spending against cancelled IO. Please resolve"
    And IO Owner and Media Plan manager receives a persistent (until issue fixed) notification on the homepage saying: "Spend against Lines in IO [IO Label] that have been confirmed as cancelled by Supplier. Please resolve" with a link to the problem IO
