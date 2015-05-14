Feature: SAP Integration

In order to integrate with accounting system in use
As Campaign Manager
I want Insertion Orders to be automatically exported to SAP as Purchase Orders and any Invoices processed against them to be visible in Olive 3

#to review
Scenario: Create a PO in SAP
  Given A Media Plan is set up and published
    And there are Essence Liable plan lines
    And Purchase Orders have been generated at the time of plan publishing
  When Client has Approved the plan
  Then Olive exports related Purchase Orders to SAP
    And Olive logs the export event in PO Sync history
    And If export is successful, Olive displays the SAP ID as "External ID"
    And If export has not been successful, Olive records reason for failure in PO Sync History

#to review
Scenario: Update POs in SAP
  # when re-approval is required - wait for it
  # when it's minor publish - export on publish

Scenario: Cancel POs in SAP
 Given a Purchase Order has been Exported to SAP
  And changes to plan have since been published
  And these changes have resulted in Purchase Order total being 0.00
  And Purchase Order has not been invoiced yet

Scenario: Do not allow changing Supplier/Currency/Liable Entity after Approval

#to flesh out
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
    And Cofirm they're happy to proceed: "This will update the Supplier for related Insertion Order {Insertion Order Name},
      cancel Existing PO in Olive 3 and {Liable Entity} SAP, generate a new one in Olive 3 and export it to {Liable Entity} SAP.
      This cannot be undone. Are you sure you want to proceed? Yes / Cancel "
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
