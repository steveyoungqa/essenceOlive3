Feature: Setting up Input library against a campaign
#as per https://docs.google.com/presentation/d/1HCS2mVni1u7fBhA3j5ujxdKa4xQJNfnqoM6BAzk23Jg/edit#slide=id.p4
In order to specify meta information about where Olive should be looking for performance metric values
As a Campaign Manager
I want to define inputs at Campaign level

#to review
Scenario: Set up an input and choose a type (OTD-2119)
  Given I have set up a Campaign
  When I navigate to Campaign Details "Measurement" Tab, "Inputs" Section
  Then I can create a new "Input"
    And I can specify a Name
    And choose a type which is one of the following:
      # Tracking Tag / SDK
      # Brand Study
      # Incrementality Study
    And "Tracking Tag / SDK" is pre-selected by default

#to review
Scenario: See a list of Inputs by Type
  Given I have set up a Campaign
    And I have created Inputs of different types as outlined below
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
      ## Tracking Tag / SDK
      # ========================================================|
      # Slot | Name          | Unit of Measure | Number of Tags |
      #=========================================================|
      # 1    | Downloads PC  | Quantity        | 2              |
      # 2    | Downloads PI  | Quantity        | 2              |
      # 3    |               |                 |                |
      # 4    |               |                 |                |
      # 5    |               |                 |                |
      # 6    |               |                 |                |
      # 7    |               |                 |                |
      # 8    | Buy Now Click | Quantity        | 1              |
      # ...                                                     |
      # 30   |               |                 |                |
      # --------------------------------------------------------|
  When I am looking at the Campaign Details "Measurement" Tab
  Then I can see a list of all of them by Type # information displayed about each Input depends on type
    And Tracking Tag / SDK list also shows which slots are not populated yet

#to review
Scenario: Set up Tracking/SDK type of Input (OTD-2119)
  Given I have set up a Campaign for "Google"
    And I have created a new "Input"
    And I have chosen type "Tracking Tag / SDK"
  When I look at the edit form of the "Input"
  Then I can Specify a Unit of Measure as outlined below:
    # Category  | Unit                                                              |
    # ===============================================================================
    # Monetary  | pick from a list a list of currencies                             |
    # Time      | [miliseconds, seconds, minutes, hours, days, weeks, months, years]|
    # Amount    | - na -                                                            |


  Scenario: Specify Tracking Tags to use with an Input
    Given I have set up a Campaign
      And I have Created an Input of type "Tracking Tag / SDK"
    When I view Input Details
    Then I can associate Tracking Tags with it
      And I can choose a tracking tag "Source"
       # DCM Floodlights
       # AdWords Pixels
       # Play Mobile Passback (? sean to confirm the name)
      And pick a Tag from a list of integrated tags for the selected source
      And choose a value type of one of the following:
       # Post Click
       # Post Impression
       # Post Click Revenue
       # Post Impression Revenue
       # TO CONFIRM WITH SEAN - can we actually automatically detect what is available and offer that once theyve picked a source?
       # e.g.
       # Conversions
       # Total count
      And an unique Identifier within the source
      And specify a weight in a range from -1 to 1 #-1 would subtract the values from the total of Input
        #todo @Helen - what's the copy for  tooltip here?
      And by default the weight is populated with 1
      And optionally specify a time range

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
        # | 15   | NPU                          | Quantity        | Mobile Passback   | Play Passback - NPU                 | ?? sean        | 1       | - na -
        # ------------------------------------------------------------------------------------------------------------------------------------------------------
        # | ??   | Dwell Time                   | seconds         | ??                | ??

  #to review
  Scenario: Integrate with DCM Floodlights (OTD-2120)

  #to review
  Scenario: Integrate with AdWords Pixels (OTD-2120)

  #to review
  Scenario: Integrate with Play Mobile Passback (OTD-2120)

  #to review
  Scenario: Migrate existing event mappings to new structure (OTD-2121)

############### Beyond Client Sign-off
Scenario: Set up an Incrementality Study type of Input

Scenario: Set up a Scrutineer Brand Study type of Input

Scenario: Integrate with Scrutineer

#to be fleshed tou
Scenario: Set a single target for a set of lines in a plan

#to be fleshed out
Scenario: Copy input setup from another campaign

#to e fleshed out
Scenario: Copy target overried from another line
