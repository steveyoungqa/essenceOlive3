Feature: Setting up Input library against a campaign
# per mockup at http://mnnl4s.axshare.com/#p=1_2c_campaign_view_-_measurments
# db schema https://drive.draw.io/?#G0B4BKOfQsSznVT19lMEhQMlc2U2M
# per presentation https://docs.google.com/presentation/d/1HCS2mVni1u7fBhA3j5ujxdKa4xQJNfnqoM6BAzk23Jg/edit#slide=id.p4
In order to specify meta information about where Olive should be looking for performance metric values
As a Campaign Manager
I want to define inputs at Campaign level


Scenario: Setup Campaign Metrics (OTD-2307)
  Given I have set up a Campaign
  When I navigate to Campaign Details "Measurement" Tab
    # i.e. rename the tab Default KPI to Meaurement
  Then I see a list of already defined metrics
    #============================================================|
    # Metric name          | Value type    | Associated input    |
    #============================================================|
    # Downloads            | Amount        | Event Name          |
    # CPA                  | Ratio         | Cost / Event Name   |
  When I add a new metric or edit an existing one
  Then I can specify a name
    And a Value of Ratio or Amount
    And a for the Inputs I can pick Clicks, Cost, or any existing event like this:
      # Associated Input                    |
      #=====================================|
      # Event 1 - Downloads PC              |
      # Event 2 - Downloads PCR             |
      # Cost                                |
      # Clicks                              |
      # Impressions                         |
      # Ranking                             |

Scenario: Tracking Tag/SDK Input edit page
- combine event input + activities tags into single page
- clien specific

Scenario: No custom Inputs on media Plan level
- remove custom KPIs on media plan


#to review
Scenario: Set up Tracking Tag / SDK inputs (OTD-2119)
  Given I have set up a Campaign
  When I navigate to Campaign Details "Measurement" Tab
    And I click "Manage Inputs"
  Then I see a list of 1-35 events, some of which have been configured
    # ========================================================|
    # Slot | Name          | Unit of Measure | Number of Tags |
    #=========================================================|
    # 1    | Downloads PC  | Quantity        | 2              |
    # 2    | Downloads PI  | Quantity        | 2              |
    # 3    |               |                 |                |
    # 4    |               |                 |                |
    # 5    |               |                 |                |
    # 6    | Buy Now Click | Quantity        | 1              |
    # ...                                                     |
    # 35   |               |                 |                |
    # --------------------------------------------------------|
  When I edit a slot
  Then I can select a Unit of Measure as outlined below:
    # Category  | Unit                                                              |
    # ===============================================================================
    # Monetary  | pick from a list a list of currencies                             |
    # Time      | [miliseconds, seconds, minutes, hours, days, weeks, months, years]|
    # Amount    | - na -                                                            |
    And I can associate Tracking Tags with it
      And I can choose a tracking tag "Source"
       # ALL (option if we do not get the sources identified in time)
       # DCM Floodlights
       # AdWords Pixels
       # Celtra
       # Play Passback
       # ....
      And pick a Tag from a list of integrated tags for the selected source
       # Play Passback - NPU - free conversion
       # Play passback - NPU - paid conversion
       # {a specific floodlight }
       # ....  
       # (moved filtering by client to OTD-2306)
      And if and only if entering a DCM Floodlight, see a Value type dropdown
      And from that dropdown choose one of the following:
       # Post Click
       # Post Impression
       # Post Click Revenue
       # Post Impression Revenue
      And specify a weight in a range from -1 to 1 
        # -1 would subtract the values from the total of Input
        # todo @Helen - what's the copy for  tooltip here?
      And by default the weight is populated with 1
      And optionally specify a start and stop time range

  # | Slot | Input Name                   | Unit of Measure | Tag Source        | Tag                                 | Tag Value Type |  Weight | Time Range
  # ======================================================================================================================================================
  # | 1    | Chrome: Download Thank You   | Quantity        | DCM Floodlights   | Chrome Awareness Search IT          | PC             | 1       |  - na -
  # ------------------------------------------------------------------------------------------------------------------------------------------------------
  # | 2    | Nexus Purchases              | Quantity        | DCM Floodlights   | Android->Play - Store - Asbury      | PI             | 1       |  - na -
  # |      |                              |                 |                   | - Nexus5 - Purchase - 16GB new      |                | 1       |
  # |      |                              |                 | DCM Floodlights   | Android->Play - Store - Asbury      | PI             | 1       |  - na -
  # |      |                              |                 |                   | - Nexus5 - Purchase - 32GB new      |                |         |
  # ------------------------------------------------------------------------------------------------------------------------------------------------------
  # | 9    | Purchase Installs            | USD             | DCM Floodlights   | Android_Sale->Android - Market      | PC Revenue     | 1       | - na -
  # |      |                              |                 |                   | - Music- Purchase Install - Success |                |         |
  # ------------------------------------------------------------------------------------------------------------------------------------------------------
  # | 15   | NPU                          | Quantity        | Mobile Passback   | Play Passback - NPU                 |                | 1       | - na -
  # ------------------------------------------------------------------------------------------------------------------------------------------------------
  # | ??   | Dwell Time                   | seconds         | ??                | ??

############### Beyond Client Sign-off
Scenario: Set up an Incrementality Study type of Input
   ## Brand Studies
   #===================================|
   # Name                | Source      |
   #===================================|
   # Feature Awareness   | Scrutineer  |
   # ----------------------------------|
   #
   ## Incrementality Studies
   #===================================================================|
   # Name                       | Input                      | P-Value |
   #===================================================================|
   # Chrome: Download Thank You | Chrome: Download Thank You | 0.9     |
   #-------------------------------------------------------------------|
   #

Scenario: Set up a Scrutineer Brand Study type of Input

Scenario: Integrate with Scrutineer

#to be fleshed out
Scenario: Set a single target for a set of lines in a plan

#to be fleshed out
Scenario: Copy input setup from another campaign

#to e fleshed out
Scenario: Copy target overried from another line
