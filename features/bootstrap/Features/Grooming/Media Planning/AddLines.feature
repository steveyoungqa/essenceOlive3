Feature: Add Plan lines

In order to outline media buys and budget allocations across channels
As Campaign Manager
I want to add line items to my plan

#to review
Scenario: Specify platform (OTD-2052)
  Given a Media plan is set up
  When I go to add a new or edit existing plan line of type "Media"
  Then I can specify a "Platform"
    And I can choose one of the following options
    #-------------------
    # Platform
    # -----------------
    # DS3
    # DBM
    # YouTube
    # GDN
    # AdMob
    # LinkedIn
    # Twitter
    # Facebook
    # Direct Buy
    And "Platform" is mandatory
#      @todo - confirm if platform is the right label and if we need a tooltip

#to review
Scenario: Publish Plan meta data with individual line publishing
  Given Media Plan has been set up
    And lines have been added to it
    And the whole plan has been published
    And later changes made to a few lines and plan meta data
  When user publish a selection of changed plan lines
  Then User is informed that Plan meta data changes will be published as well
#    @todo - Helen help confirm text
    And all Plan meta data changes are published along with selected lines
