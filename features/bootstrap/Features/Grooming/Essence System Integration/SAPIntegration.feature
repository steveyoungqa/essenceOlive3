Feature: SAP Integration

In order to integrate with accounting system in use
As Campaign Manager
I want Insertion Orders to be automatically exported to SAP as Purchase Orders and any Invoices processed against them to be visible in Olive 3

###################################################################################################################
# IOs that need to be exported to sap are:                                                                        #
#   ~ Essence Liable                                                                                              #
#   ~ not raised for the following suppliers: Essence Creative, Essence Mobile, Essence Media, Essence Social     #
###################################################################################################################

#to flesh out
Scenario: Re-sync plan with SAP button
  Given A media Plan has been Client approved
  When I look at the PO tab in the plan
  Then I can see a button "Sync with SAP"
    And when I click it Olive triggers the Sync process in scenario below

Scenario: Detect if PO should be exported to SAP
  Given that an Insertion order is Essence Liable
    And It is not raised for any of the following Suppliers:
     # Supplier Name | Master Code
  When A new Client snapshot is created
  Then prepare a Purchase Order for Export to SAP

Scenario: Create POs
  Given A Media Plan is set up and published
    And Client has approved the plan
    And there are Insertion Orders that need to be exported to SAP
    And that Insertion Order Does not have an associated PO in SAP
  When SAP Sync is triggered
  Then Olive creates a Purchase order with the following information
    #https://docs.google.com/document/d/1ko-1-TmRZ7UwBfgq_a37l5x_DEEBZnqjlzFu-dnxIu0/edit#heading=h.mku47oviebtt
    And PO ID is the same as IO ID
    # QQ - can this be somehow enforced? where would we get PO ids in case we needed to make multiple POs for IOs

Scenario: Create PO Lines

Scenario: Update PO Lines

Scenario: Alert of discrepancies for Insertion Order

Scenario: Discounts are exported separately with Agency Discount GL account
  #https://docs.google.com/document/d/1ko-1-TmRZ7UwBfgq_a37l5x_DEEBZnqjlzFu-dnxIu0/edit#heading=h.30djt44mgg3
  Given an IO line has a discount applied
    And it has to be exported to SAP
    And a representative Purchase Order line is created for it
  When Olive prepares PO SAP export for the PO
  Then the PO Line is split into two lines as follows:
    # |--------------------------------------------------------------------------------------------------------------|
    # | Olive ID      | GL Account            | Description   | Total Gross         | Discount | Total net           |
    # |--------------------------------------------------------------------------------------------------------------|
    # | {PO Line ID}  | {PO line GL account}  | {po line desc}| PO line Net         | 0        | PO line Net         |
    # | {PO Line ID}c | 350040Media_00000000  | {po line desc}| PO line Disc amount | 0        | PO line Disc amount |
    # |--------------------------------------------------------------------------------------------------------------|

Scenario: Export POs to SAP
  Given new Client Snapshot has been created
  When PO SAP update has been prepared
  Then Olive sends Purchase Order requests to relevant SAP db (depending on Liable Entity as follows:
    # Olive Env  | SAP Server | Liable Entity | ID     | SAP DB           |
    # --------------------------------------------------------------------|
    # Production | SAP LON    | Essence LON   | UK     | Essence_Ltd_Live |
    # Production | SAP LON    | Essence NA    | US     | Essence_Inc_Live |
    # Production | SAP LON    | Essence SG    | SG     | Essence_Sin_Live |
    # Production | SAP LON    | Essence JP    | JP     | ??               |
    # Production | SAP LON    | Essence AU    | AU     | TBC              |
    # --------------------------------------------------------------------|
    # UAT        | SAP LON    | Essence LON   | TESTUK | Essence_Ltd_Test |
    # UAT        | SAP LON    | Essence NA    | TESTUS | Essence_Inc_Test |
    # UAT        | SAP LON    | Essence SG    | TESTSG | Essence_Sin_Test |
    # UAT        | SAP LON    | Essence JP    | TESTJP | ???              |
    # UAT        | SAP LON    | Essence AU    | TESTAU | TBC              |


    And Olive logs the export event in PO Sync history
    # QQ - where would we look at sync log for POs that don't get recorded in Olive becuase the export failed?

Scenario: Update Olive DB after a successful SAP export
  Given Olive has sent a PO request to SAP
  When PO Export to SAP is successful
  Then Olive records PO SAP ID as "External ID" for Purchase Order
    And Updates Olive database with information that's just been exported to SAP
    And users can find the Purchase Order in a list of "Purchase Orders" for related Plan as well as the global "/finance/pos" page

Scenario: Update Olive DB after an unsuccessful SAP export
  Given Olive has sent a PO request to SAP
  When PO Export to SAP is not successful
  Then Olive records the reason for failure in Sync history
    And Indicates on Insertion Order that there has been a problem
    And Olive autosubmits a JIRA ticket for developers to investigate the issue with the following information:
     # ERROR - PO Export failed - {SAP Env} - {PO ID} ({Olive Env})
     # --------------------------------------------------------------------
     # {Reason for failure}
     # Related IO: {Url to Insertion Order}
     # Purchase Order: {Url to Purchase Order} # if available
     # -------------------------------------------------------------------



  # for unit tests
  Scenario: 1st time creation
    Given A Media Plan is set up and Client Approved
      And I it contains 2 plan lines as outlined below my Media Plan
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status              |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Google Ireland Ltd.   | #1 | Client        | $10          | $10          | $10               | $10               | Client Approved     |
      # Ebuzzing Inc.         | #2 | Essence LON   | $10          | $10          | $10               | $10               | Client Approved     |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
    When Sync is triggered (on client approval or manually)
    Then POs and PO lines are generated as outlined below
        # --------------------------------------------------------------------------------------------|
        # Supplier              | PO | IO | Liable Entity | Net Budget | Status     | Exported to SAP |
        # --------------------------------------------------------------------------------------------|
        # Ebuzzing Inc.         | #2 | #2 | Essence LON   | $10        | APPROVED   | YES             |
        # --------------------------------------------------------------------------------------------|

  Scenario: Simple upweight
  Scenario: Simple downweight
  Scenario: Upweight against invoiced line
    #create a new PO line for remainder - the sum of BOTH POs = the total net of IO
  Scenario: Upweight against closed PO
    #create a new PO
  Scenario: Downweight against invoiced line
  Scenario: Downweight against closed PO
  Scenario: Compelte cancel
  Scenario: Compelte cancel on invoiced - abort
  Scenario: Complete cancel on closed - abort


  Given IO line budget change in client approved snapshot
    And it has an uninvoiced PO line linked to it
  Then the PO line can be


#to review
Scenario: PO downweights are exported on Publish after approval
  Given A Media Plan is set up and Client Approved
    And Essence Liable Purchase Orders have been exported to SAP
    And changes are made to plan that would cause a PO total to be less than what was originally exported (no internal approval needed)
  When changes are "Published"
  Then PO totals are updated in Olive 3
    And Olive exports new amount to SAP
    And Olive logs the export event in PO Sync history
    And If export is successful, Olive displays the SAP ID as "External ID"
    And If export has not been successful, Olive records reason for failure in PO Sync History

    #for unit tests
    Scenario: Essence Liable PO Updated on publishing downweight
    Scenario: Client Liable PO updated on publishing downweight
    Scenario: Essence Liable PO Exported on publishing downweight
    Scenario: Client Liable PO NOT exported on publishing downweight

    #handle part invoiced - add a negative PO line item
    #handle invoiced (closed) - @todo - verify

#to review
Scenario: Minor PO Upweights are exported on IO internal approval
  Given A Media Plan is set up and Client Approved
    And Essence Liable Purchase Orders have been exported to SAP
    And changes are made to plan that would cause a PO total to be greater than what was originally exported
    And Client approval isn't breached (however internal approval needed)
  When changes are "Internally approved"
  Then PO totals are updated in Olive 3
    And Olive exports new amount to SAP
    And Olive logs the export event in PO Sync history
    And If export is successful, Olive displays the SAP ID as "External ID"
    And If export has not been successful, Olive records reason for failure in PO Sync History

    #for unit tests
    Scenario: Essence Liable PO not updated on publishing upweight
    Scenario: Essence Liable PO updated on internally approving minor upweight
    Scenario: Essence Liable PO Exported on publishing downweight
    Scenario: Client Liable PO not updated on publishing upweight
    Scenario: Client Liable PO updated on internally approving minor upweight
    Scenario: Client Liable PO NOT exported on internally approving minor upweight



    #handle part invoiced - add a new PO line item for remainder - worth updating only just before export as SAP might have processed a new invoice by then
    #handle invoiced (closed) - @todo - verify

#to reivew
Scenario: Major PO upweights are exported to SAP on Client  re-approval
  Given A Media Plan is set up and Client Approved
    And Essence Liable Purchase Orders have been exported to SAP
    And changes are made to plan that would cause a PO total to be greater than what was originally exported
    And Client approval is breached (re-approval needed)
  When changes are "Re-approved by Client"
  Then PO totals are updated in Olive 3
    And Olive exports new amount to SAP
    And Olive logs the export event in PO Sync history
    And If export is successful, Olive displays the SAP ID as "External ID"
    And If export has not been successful, Olive records reason for failure in PO Sync History

#to review
Scenario: Do not allow changing Supplier/Currency/Liable Entity after Approval
  Given A Media Plan is set up and Client Approved
    And Essence Liable Purchase Orders have been exported to SAP
  When I edit these lines in Media Plan
  Then I cannot change their Supplier, Currency or Liable Entity or Delete (forced to downweight to 0 and raise a new line)

#to review
Scenario: Cancel POs in SAP
 Given a Purchase Order has been Exported to SAP
  And changes to plan have since been published
  And these changes would resulted in Purchase Order total being 0.00
  And Purchase Order has not been invoiced yet
  When changes are "Published"
  Then PO totals are updated in Olive 3
    And Olive exports "CANCEL" messageg to SAP
    And Olive logs the export event in PO Sync history
    And If export is successful, Olive displays the SAP ID as "External ID"
    And If export has not been successful, Olive records reason for failure in PO Sync History




#to review
Scenario: Handle incorrect PO Supplier after Plan Approval
  Given Media Plan has been approved
    And a Insertion Order for e.g. "Yahoo! UK Ltd." has been raised
    And as a result a Purchase Order for "Yahoo! UK Ltd." has been exported to SAP
    And no Invoices have been processed against this PO yet
    And Invoice has come in from "Yahoo! Inc."
    And Finance require the Purchase order to be re-raised for "Yahoo! Inc."
    But downweighting said line to 0.00 and adding new line would result in "Breached" Client Approval
  When Account Manager submits a an issue for service desk about wrong supplier selected for PO
  Then Olive admin can access restricted Interface "SAP Integration Management" #(enough to be just a hidden url for now )
    And Locate Purchase Order by supplying the "Olive 3 PO ID"
    And Choose a new "Supplier" for it
    And Cofirm they're happy to proceed:
    # "This will update the Supplier for related Insertion Order {Insertion Order Name},
    #  cancel Existing PO in Olive 3 and {Liable Entity} SAP, generate a new one in Olive 3 and export it to {Liable Entity} SAP.
    #  This cannot be undone. Are you sure you want to proceed? Yes / Cancel "
    And on confirm, Related Insertion Order Supplier is updated to new selection
    And "CANCEL" request is posted to B1I
    And if B1IF has responded with success, new Purchase order is generated for the new supplier
    And all PO lines from old Purchase Order are moved to the new one
    And old Purchase Order and has a status "Cancelled" (and contains no lines - the same should be in SAP)
    And new Purchase Order is
    And user is displayed success feedback containing the new "Olive 3 PO ID" and new "SAP PO ID" (so that can be communicated back to whoever raised service desk issue)
    And in Insertion Order history an event is logged
    # ----------------------------------------------------------------------------------------------------------------------------------------------------|
    # Time     |User                     |Action                                          |Document| Notes                                                |
    # ----------------------------------------------------------------------------------------------------------------------------------------------------|
    # Datetime |Currently Logged in User | Supplier changed through SAP Integration Admin | N/A    |{Old Supplier} changed to {New Supplier}              |
    #          |                         |                                                |        | Purchase Order #{Old PO ID} reraised as #{new PO ID} |



#to flesh out
Scenario: Handle incorrect PO Currency after Plan Approval

#to flesh out
Scenario: Handle incorrect Liable Entity
