Feature: Internal Approval

In order to be sure I've prepare media plan for Client Sign-off
As Campaign Manager
I want to set everything up and get the media plan internally reviewed

#Published - delivered historically
Scenario: Publish Entire Draft

#to review
Scenario: Publishing All changes when no changes are made in the Draft version
  Given There is a published Media Plan
    And there the Darft version isn't different from currently latest Published version
  When I look at the plan in Draft view
  Then I shouldn't see a "Publish All Changes" button
    And in case it's still rendered on my screen while someone else has published the changes, and I click it, instead of "Plan succesffully published", I should see a notification "All changes already published"
    And the button should disappear

# - in sprint 28,29 -
Scenario: Publish Individual Line (OTD-1912)
  
# - in sprint 28,29 -
Scenario: Publish a set of Lines (OTD-1912)

#Published - delivered historically
Scenario: View Last Published Version

#to flesh out - for rework
Scenario: Request Internal Approval for Entire Plan

#Internally Approved - delivered historically
Scenario: Internally Approve entire Plan

#to review
Scenario: Restrict internal Plan approval (OTD-1913)
