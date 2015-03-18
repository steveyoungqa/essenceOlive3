@regression
Feature: End to End Regression Test Pack
  All using consistent test data in a single user Chrome browser session

  Scenario Outline: Create new campaign, Add Media Plan, Add Media Plan Line & Service, Publish Media Plan
  Insertion Order, Map to DS3, Map to Search Campaign, Approval Process,
#  In Progress: Conversion Events, Tagging, Tracking Management - Mapping Status

     Given I am on "/login"
     Then I press "Sign in with Google"
     And I fill in "Email" with "<user>"
     And I fill in "Passwd" with "<pass>"
     Then I press "signIn"
     Then I wait for 3000
     Then I should see "Notifications"

     Then I click the "Navigation Header" link
     Then I follow "Campaigns"

     Then I fill in "campaign-search-basic" with "<campaign>"
     Then I wait for 3000
     Then I select the Delete "<campaign>" check
     Then I wait for 5000

     Then I click the "Navigation Header" link
     Then I follow "Campaigns"
     Then I wait for 3000
     Then I follow "campaign-add"
     Then I wait for 3000

     And I fill in "campaign-new-name" with "<campaign>"
     And I fill in "campaign-new-client" with "<client>"
     Then I wait for 5000
     And I fill in "campaign-new-owner" with "<owner>"
     Then I wait for 7000
     And I fill in "campaign-new-memo" with "Test Notes"
     Then I wait for 5000
     Then I click the "Campaign Save" link
     Then I wait for 5000

     Then I click the "External Platforms" link
     And I click the "Google Sub Product" link
     Then I fill in "mapping-externalSystem-googleSubProduct" with "AdWords - A01 (Acquisition)"
     Then I wait for 5000
     Then I click the "External System Save" link
     # The above link doesnt click External Save - it takes focus off the form dropdown in the previous step
     Then I click the "External System Save" link
     Then I wait for 5000

     Then I click the "Media Plans" link
     Then I follow "campaign-marketbudgets-add"
     Then I wait for 3000
     And I fill in "campaign-marketbudgets-new-label" with "Test Label"
     Then I click the "Add New Period" link
     And I fill in "campaign-marketbudgets-new-periods-new-name" with "<period>"
     Then I click the "New Period Save" link
     And I click the "Close Add Period" link

     Then I fill in "campaign-marketbudgets-new-period" with "<period>"

     Then I click the link containing ID "<period>"
     Then I wait for 2000

     Then I click the "Campaign New Market" link
     Then I wait for 2000
     Then I click the "Market United Kingdom" link

     Then I select a Media Plan Start Date of "2015-01-01"
     Then I wait for 2000
     Then I Select a Media Plan End Date of "2015-01-31"
     Then I wait for 2000

     Then I fill in "campaign-marketbudgets-new-liableEntity" with "<clientLiable>"
     Then I wait for 2000
     Then I click the link containing ID "<clientLiable>"

     And I fill in "campaign-marketbudgets-new-currency" with "GBP"
     Then I wait for 2000
     Then I fill in "campaign-marketbudgets-new-budget" with "<budget>"
     Then I wait for 2000

     And I fill in "campaign-marketbudgets-new-owner" with "<owner>"
     Then I wait for 2000
     Then I click the link containing ID "<owner>"

     Then I click the "Media Plan Save" link
     Then I wait for 5000

     Then I click the "Link Google Initiative" link
     Then I fill in "mapping-externalSystem-googleInitiative" with "<initiative>"
     Then I wait for 2000
     Then I click the link containing ID "<initiative>"
     Then I click the "Save Mapped Account" link
     Then I wait for 10000
     Then I click the "Previous Breadcrumb" link

     Then I click the "Media Plan Whole Column" link
     Then I wait for 5000
     And I select the Media Plan linked to Campaign of "<campaign>"
     Then I wait for 5000

     Then I click the "Add Media Plan Line" link
     Then I wait for 2000
     Then I click the "Line Cost Type" link
     And I click the "Cost Type Media" link
     Then I click the "Line Channel" link
     And I click the "Line Channel Display" link
     Then I click the "Section" link
     And I click the link containing Text "Default"
     Then I click the "Supplier" link
     And I click the link containing Text "<supplier>"
     Then I click the "Platform" link
     And I click the link containing Text "DS3"
     Then I click the "Property" link
     And I click the link containing Text "Yandex"
     Then I click the "Media Type" link
     And I click the link containing Text "Lightbox"
     Then I click the "Cost Model" link
     Then I fill in "campaign-marketbudgets-versions-lines-new-costModel" with "Biddable CPC"
#     And I click the link containing Text "Biddable CPC"

     Then I select a Plan Line Start Date of "2015-01-01"
     Then I wait for 2000
     Then I Select a Plan Line End Date of "2015-01-31"
     Then I wait for 2000

     Then I click the "Line Currency" link
     And I click the link containing Text "British Pound"
     Then I fill in "campaign-marketbudgets-versions-lines-new-totalNet" with "100000"
     And I fill in "campaign-marketbudgets-versions-lines-new-description" with "Test Description"

     Then I click the "Save Media Plan Line" link
     Then I wait for 5000

     When I click the "Publish Media Plan" link
     Then I wait for 1000
     Then I should see "Media Plan published successfully"
     Then I wait for 2000

     Then I click the "Insertion Order tab" link
     Then I wait for 4000
     And I click the "Map Lines" link
     Then I click the "External Platforms tab" link
     And I click the "Link DS3" link
     And I fill in "mapping-externalSystem-ds3" with "<ds3>"
     Then I wait for 4000
     And I click the link containing Text "<ds3>"
     Then I click the "External System Save" link

     Then I click the "Plan Lines tab" link
     And I click the "Manage Mapped Entities" link
     Then I wait for 10000

     Then I Map Search Campaign "<searchCampaign>"
     And I click the "Save Managed Entities" link
     Then I wait for 10000

     Then I click the "Close Mapped Panel" link
     Then I click the "Plan tab" link

     Then I click the "Publish Dropdown" link
     And I click the "Published State" link

     Then I click the "Manage Approval" link
     And I click the "Add Approver" link
     Then I wait for 2000
     And I fill in "campaign-marketbudgets-versions-approvers-add-type" with "Internal"
     Then I wait for 2000
     Then I click the "Approver Field" link
     Then I wait for 2000
     And I fill in "campaign-marketbudgets-versions-approvers-add-person" with "<approver>"
     Then I wait for 2000
     Then I click the link containing Text "<approver>"
     Then I wait for 2000
     Then I click the "Save Approver" link

     Then I wait for 10000


#     Then I click the "Navigation Header" link
#     Then I follow "Campaigns"
#
#     Then I fill in "campaign-search-basic" with "<campaign>"
#     Then I wait for 3000
#     Then I select the Delete "<campaign>" check
#     Then I wait for 5000

  Examples:
    |user                      |pass        |campaign       |client|owner      |period |budget|clientLiable|initiative|supplier      |ds3            |searchCampaign|approver|
    |steve.automation@gmail.com|Warlock99   |regressiontests|google|automation |q4-2015|100000|america     |nexlab    |Google Ireland|700000001004851|Madrid        |Steve Young|




