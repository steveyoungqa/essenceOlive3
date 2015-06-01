Feature: SAP Integration

In order to integrate with accounting system in use
As Campaign Manager
I want Insertion Orders to be automatically exported to SAP as Purchase Orders and any Invoices processed against them to be visible in Olive 3

#to review
Scenario: Purchase Orders are created, updated and synced on Client Approval
  #activity added during campaign running is exported as new pos on client re-approval
  Given A Media Plan is set up and published
    And there are Essence Liable plan lines
    And Client approval has been requested
  When Client has Approved the plan
  Then Olive exports Essence Liable Purchase Orders to SAP
    And Olive logs the export event in PO Sync history
    And If export is successful, Olive displays the SAP ID as "External ID"
    And If export has not been successful, Olive records reason for failure in PO Sync History

    #for unit tests
    #Essence liable
    Scenario: POs generated and Exported on Client Approval on Publish, not exported
      Given I have set up a "Draft" media plan as outlined below
        # ----------------------------------------------------------------------------------------|
        # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num POs |
        # ----------------------------------------------------------------------------------------|
        # Draft        | $100         | $20       | $80         | 2       | 2           | 0       |
        # Published    | --           | --        | --          | 0       | 0           | 0       |
        # ----------------------------------------------------------------------------------------|
        And it has never been published before
        And I have set up 2 plan line as outlined below my Media Plan
        # ---------------------------------------------------------------------------------------------------------------------------------------|
        # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status              |
        # ---------------------------------------------------------------------------------------------------------------------------------------|
        # Google Ireland Ltd.   | #1 | Client        | $10          |  --          | --                | --                | Draft               |
        # Ebuzzing Inc.         | #2 | Essence LON   | $10          |  --          | --                | --                | Draft               |
        # ---------------------------------------------------------------------------------------------------------------------------------------|
        And there are no Purchase Orders related to any of the Insertion Orders
        And I'm on the plan line edit form
      When I hit Publish all
      Then Then Media Plan status changes to "Published"
        # ----------------------------------------------------------------------------------------|
        # Version      | Total Budget | Allocated | Unallocated | Num IOs | Num M Lines | Num POs |
        # ----------------------------------------------------------------------------------------|
        # Draft        | $100         | $20       | $80         | 2       | 2           | 0       |
        # Published    | $100         | $20       | $80         | 2       | 2           | 2       |
        # ----------------------------------------------------------------------------------------|
        And Plan line Data and IO status changes as outlined below
          # ---------------------------------------------------------------------------------------------------------------------------------------|
          # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status              |
          # ---------------------------------------------------------------------------------------------------------------------------------------|
          # Google Ireland Ltd.   | #1 | Client        | $10          |  $10         | --                | --                | Published           |
          # Ebuzzing Inc.         | #2 | Essence LON   | $10          |  $10         | --                | --                | Published           |
          # ---------------------------------------------------------------------------------------------------------------------------------------|
        And PO lines are generated as outlined below
          # --------------------------------------------------------------------------------------------|
          # Supplier              | PO | IO | Liable Entity | Net Budget | Status     | Exported to SAP |
          # --------------------------------------------------------------------------------------------|
          # Google Ireland Ltd.   | #1 | #1 | Client        | $10        | UNAPPROVED | NO              |
          # Ebuzzing Inc.         | #2 | #2 | Essence LON   | $10        | UNAPPROVED | NO              |
          # --------------------------------------------------------------------------------------------|

    Scenario: PO remains UNAPPROVED and not exported on Internal approval
    Scenario: Essence Liable PO updated to APPROVED and eported on Client approval
    Scenario: Client Liable PO updated to APPROVED and NOT exported on Client approval

Scenario: Syncing POs with lates client approved version of plan
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

#to flesh out
Scenario: Re-sync plan with SAP button

#for unit tests
Scenario: PO never approved
Scenario: PO minor

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
