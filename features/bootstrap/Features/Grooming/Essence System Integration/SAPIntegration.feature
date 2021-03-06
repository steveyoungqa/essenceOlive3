Feature: SAP Integration

In order to integrate with accounting system in use
As Campaign Manager
I want Insertion Orders to be automatically exported to SAP as Purchase Orders and any Invoices processed against them to be visible in Olive 3

###################################################################################################################
# IOs that need to be exported to sap are:                                                                        #
#   ~ Essence Liable                                                                                              #
#   ~ not raised for the following suppliers: Essence Creative, Essence Mobile, Essence Media, Essence Social     #
###################################################################################################################

#reviewd 4th June - in Sprint 32 [22nd June] -
Scenario: Trigger SAP Sync (OTD-2229)
  Given A media plan exists
  When New client approved snapshot
  Then trigger SAP Sync process

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Re-sync plan with SAP button (OTD-2229)
  Given A media Plan has been Client approved
  When I look at the IO and PO tab in the plan
  Then I can see a button "Sync with SAP" (just above the IO or PO list)
    And when I click it Olive triggers the Sync process in scenario below

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Detect if PO should be exported to SAP (OTD-2139)
  Given that an Insertion order is Essence Liable
    And It is not raised for any of the following Suppliers:
     # | Supplier Name    | Master Code |
     # |--------------------------------|
     # | Essence Creative | MC00000     |
     # | Essence Mobile   | MC20000     |
     # | Essence Social   | MC10000     |
     # | Essence Media    | MC30000     |
  When Sync is triggered
  Then prepare a Purchase Order for Export to SAP

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Create POs (OTD-2139)
  Given there are Insertion Orders that need to be exported to SAP
    And that Insertion Order Does not have an associated PO in SAP
  When SAP Sync is triggered
  Then Olive creates Olive 3 Purchase order with fields in "20130816 - Olive 3 - B1IF and Olive Interface Requirements - v.0.3: Purchase Orders" section
    #https://docs.google.com/document/d/1ko-1-TmRZ7UwBfgq_a37l5x_DEEBZnqjlzFu-dnxIu0/edit#heading=h.mku47oviebtt
    And PO ID is the same as IO ID
    # QQ - can this be somehow enforced? where would we get PO ids in case we needed to make multiple POs for IOs
    And the Olive PO is created with a status "OPEN"


#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Alert of discrepancies for Insertion Order (OTD-2139)
  Given an insertion order needs to be exported to SAP
    And the insertion Order is associated with a Purchase Order
    And Olive checks the Purchase Order status in SAP
  When SAP responsed with a "CLOSED" status
  Then Olive displays a against the Insertion Order list view
    And displays a RED coloured sync status ("FAILED") on IO meta data in details view
    And a red warning indicator on the "Export history" tab (as per mapping)
    And Olive displays a warning indicator against the Purchase Order (in list view and details - PO Sync area)
    And Olive updates Olive PO Status to "CLOSED"
    And Olive autosubmits a JIRA ticket (only from Production) for developers to investigate the issue with the following information:
     # ERROR - PO Sync impossible - {SAP Env} - {PO ID}
     # --------------------------------------------------------------------
     # Purchase Order Closed in SAP
     # Not possible to update Total ({Currency} {PO Total}) to match Insertion Order ({Currency} {IO Total})
     # Discrepancy  of {Currency} {difference}
     #
     # Related IO: {Url to Insertion Order}
     # Purchase Order: {Url to Purchase Order}
     # -------------------------------------------------------------------


#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Create PO Lines (OTD-2139)
  Given there are insertion order that need to be exported to SAP
    And the insertion Order has an associated Purchase Order
    And a line in the insertion Order has changed (or has been newly introduced)
    And that associated Purchase Order does not have any uninvoiced lines associated with changed IO line
  When SAP Sync is triggered
  Then Olive creates a Purchase Order line for the change amount with fields in "20130816 - Olive 3 - B1IF and Olive Interface Requirements - v.0.3: Purchase Orders" section

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Update PO Lines (OTD-2139)
  Given there are insertion order that need to be exported to SAP
    And the insertion Order has an associated Purchase Order
    And a line in the insertion Order has changed
    And that IO line is associated with an uninvoiced PO line
  When SAP Sync is triggered
  Then Olive updates uninvoiced PO line by the change amount as per specification in "20130816 - Olive 3 - B1IF and Olive Interface Requirements - v.0.3: Purchase Orders" section


#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Discounts are exported separately with Agency Discount GL account (OTD-1972)
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

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Export PO cancelation to SAP (OTD-1972)
  Given new Client Snapshot has been created
    And PO SAP update has been prepared
    And the PO total is 0.00
  When Olive prepares B1IF request
  Then it sends a "CANCEL" message (see table in next scenario)
    And sets the PO Status to "CANCELLED"

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Export POs to SAP (OTD-1972)
  Given new Client Snapshot has been created
    And PO total > 0
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
    And Olive logs the export event in "PO Sync" history

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: View PO Sync history for each IO and PO (OTD-2230)
  Given An Insertion Order has to be exported to SAP
    And it has been approved by Client
  When I view Insertion Order Details
  Then I can see a tab "Export history"
    And for each export event it displays the following:
    # Date Time, SAP instance, Export Content, Reponse Content, Success/Failure flag, reason for failure

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Update Olive DB after a successful SAP export (OTD-1972)
  Given Olive has sent a PO request to SAP
  When PO Export to SAP is successful
  Then Olive records PO SAP ID as "External ID" for Purchase Order
    And Updates Olive database with information that's just been exported to SAP
    And users can find the Purchase Order in a list of "Purchase Orders" for related Plan as well as the global "/finance/pos" page

#reviewed 4th June - in Sprint 32 [22nd June] -
Scenario: Update Olive DB after an unsuccessful SAP export (OTD-1972)
  Given Olive has sent a PO request to SAP
  When PO Export to SAP is not successful
  Then Olive records the reason for failure in Sync history
    And Indicates on Insertion Order that there has been a problem
    And Olive autosubmits a JIRA ticket (from Production only) for developers to investigate the issue with the following information:
     # ERROR - PO Export failed - {SAP Env} - {PO ID}
     # --------------------------------------------------------------------
     # {Reason for failure}
     # Related IO: {Url to Insertion Order}
     # Purchase Order: {Url to Purchase Order} # if available
     # -------------------------------------------------------------------

#to review - in Sprint 31 [8th June] -
Scenario: Do not allow changing Supplier/Currency/Liable Entity after Approval
  Given A Media Plan is set up and Client Approved
    And Essence Liable Purchase Orders have been exported to SAP
  When I edit these lines in Media Plan
  Then I cannot change their Supplier, Currency or Liable Entity or Delete (forced to downweight to 0 and raise a new line)

Scenario: All Unit Tests Pass

  Scenario: Creation of POs
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

  Scenario: Minor upweight (on internal approval)
    Given A Media Plan is set up and Client Approved
      And changes have been published to create an situation as outlined below
      # ---------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status        |
      # ---------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | $12          | $12          | $10               | $10               | Published     |
      # ---------------------------------------------------------------------------------------------------------------------------------|
    When IO changes are internally approved
    Then IO line changes as outlined
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status           |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | $12          | $12          | $12               | $12               | Client Approved  |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      And POs and PO lines are updated as outlined below
        # --------------------------------------------------------------------------------------------|
        # Supplier              | PO | IO | Liable Entity | Net Budget | Status     | Exported to SAP |
        # --------------------------------------------------------------------------------------------|
        # Ebuzzing Inc.         | #2 | #2 | Essence LON   | $12        | APPROVED   | YES             |
        # --------------------------------------------------------------------------------------------|

  Scenario: Major upweight (on client approval)
    Given A Media Plan is set up and Client Approved
      And changes have been internally approved to create an situation as outlined below
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status              |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | $50          | $50          | $50               | $10               | Internally Approved |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
    When Client reapproves the plan
    Then IO line changes as outlined
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status           |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | $50          | $50          | $50               | $50               | Client Approved  |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      And POs and PO lines are updated as outlined below
        # --------------------------------------------------------------------------------------------|
        # Supplier              | PO | IO | Liable Entity | Net Budget | Status     | Exported to SAP |
        # --------------------------------------------------------------------------------------------|
        # Ebuzzing Inc.         | #2 | #2 | Essence LON   | $50        | APPROVED   | YES             |
        # --------------------------------------------------------------------------------------------|

  Scenario: Simple downweight (on publish)
    Given A Media Plan is set up and Client Approved
      And changes have been made to draft as outlined below
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status              |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | $6           | $10          | $10               | $10               | Client Approved     |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
    When Changes are published
    Then IO line changes as outlined
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status           |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | $6           | $6           | $6                | $6                | Client Approved  |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      And POs and PO lines are updated as outlined below
        # --------------------------------------------------------------------------------------------|
        # Supplier              | PO | IO | Liable Entity | Net Budget | Status     | Exported to SAP |
        # --------------------------------------------------------------------------------------------|
        # Ebuzzing Inc.         | #2 | #2 | Essence LON   | $6         | APPROVED   | YES             |
        # --------------------------------------------------------------------------------------------|

  Scenario: Complete cancel
    Given A Media Plan is set up and Client Approved
      And changes have been made to draft as outlined below (deleted line)
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status              |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | --           | $10          | $10               | $10               | Client Approved     |
      # ---------------------------------------------------------------------------------------------------------------------------------------|
    When Changes are published
    Then IO line changes as outlined
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Supplier              | IO | Liable Entity | Draft Budget | Publ. Budget | Int. appr. Budget | Clt. appr. Budget | Status           |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      # Ebuzzing Inc.         | #2 | Essence LON   | --           | --           | --                | --                | Client Approved  |
      # ------------------------------------------------------------------------------------------------------------------------------------|
      And POs and PO lines are updated as outlined below
        # --------------------------------------------------------------------------------------------|
        # Supplier              | PO | IO | Liable Entity | Net Budget | Status     | Exported to SAP |
        # --------------------------------------------------------------------------------------------|
        # Ebuzzing Inc.         | #2 | #2 | Essence LON   | --         | CANCELLED  | YES             |
        # --------------------------------------------------------------------------------------------|

  #invoiced lines
  Scenario: Upweight against invoiced line
    #create a new PO line for remainder - the sum of BOTH POs = the total net of IO
  Scenario: Downweight against invoiced line
  Scenario: Compelte cancel on invoiced - abort

  #closed pos
  Scenario: Upweight against closed PO
  Scenario: Downweight against closed PO
  Scenario: Complete cancel against closed PO

  #discounts
  #discount percent
  Scenario: Create with Discount Percent
  Scenario: Upweight with Discount Percent
  Scenario: Downweight with discount Percent
  Scenario: Upweight with discount against invoiced line
  Scenario: Downweight with discount against invoiced discount line

  #discount amount
  Scenario: Create with Discount Percent
  Scenario: Upweight with Discount Percent
  Scenario: Downweight with discount Percent
  Scenario: Upweight with discount against invoiced line
  Scenario: Downweight with discount against invoiced discount line





#reviewed 17th June
Scenario: Handle incorrect PO Supplier after Plan Approval (OTD-2312)
  Given Media Plan has been approved by Client
    And a Insertion Order for e.g. "Yahoo! UK Ltd." has been raised
    And as a result a Purchase Order for "Yahoo! UK Ltd." has been exported to SAP
    And Invoice has come in from "Yahoo! Inc."
    And Finance require the Purchase order to be re-raised for "Yahoo! Inc."
  When Account Manager submits a an issue for service desk about wrong supplier selected for PO
  Then Olive admin can access restricted Interface "SAP Integration Management" #(enough to be just a hidden url for now )
    And Locate Purchase Order by supplying the "Olive 3 PO ID"
    And Choose a new "Supplier" for it
    And Cofirm they're happy to proceed:
      # "This will create a new Insertion Order for the new Supplier with other information the same as {Insertion Order Name},
      #  The Existing PO will be downweighted to 0 or Cancelled in Olive 3 and {Liable Entity} SAP, instead a new Purchase Order will be generated and exported to {Liable Entity} SAP.
      #  As this cannot be undone, please make sure there are no invoices processed against this IO in SAP.
      #  Are you sure you want to proceed? Yes / Cancel "
    And on confirm, new IO for new Supplier is created, and it contains all the lines that were included in the prev IO
    And add a negative PO line item to existing PO to downweight to 0.00, export that to SAP
    And "CANCEL" request is posted to B1I against the old Purchase Order (ignore failure)
    And if B1IF has responded with success, Olive 3 Purchase order is update to match SAP PO
    And new Purchase Order is generated from the new Insertion Order and exported to SAP / saved
    And user is displayed success feedback containing the new "Olive 3 IO ID" and new "SAP PO ID" (so that can be communicated back to whoever raised service desk issue)
    And the following events are recorded in Insertion Order history
    # ----------------------------------------------------------------------------------------------------------|
    # IO     | User           | Action                    | Notes                                               |
    # ----------------------------------------------------------------------------------------------------------|
    # Prev   | Currently      | Supplier updated through  | {Old Supplier} changed to {New Supplier}            |
    #        | Logged in User | SAP Integration Admin     | New IO #{new PO ID}[link to new io] generated as a  |
    #        |                |                           | result                                              |
    # -------|----------------|---------------------------|-----------------------------------------------------|
    # New    | Currently      | Raised as a result of     | {Old Supplier} changed to {New Supplier}            |
    #        | Logged in User | Supplier update through   | Prev IO #{Prev PO ID}[link to new io] cancelled as  |
    #        |                | SAP Integration Admin     | a result                                            |
    # ----------------------------------------------------------------------------------------------------------|
    # * note - for suppliers - use the name that's imported from Olive 2 sup_legal_entity field

#reviewed 17th June
Scenario: Handle incorrect PO Currency after Plan Approval (OTD-2312)
  Given Media Plan has been approved by Client
    And a Insertion Order for in "USD" has been raised
    And as a result a Purchase Order in "USD." has been exported to SAP
    And Invoiced total for this PO is 0.00 (or no invoices have been processed/imported)
    And Invoice has come in "GBP"
    And Finance require the Purchase order to be re-raised in "GBP"
  When Account Manager submits a an issue for service desk about wrong Currency selected for PO
  Then Olive admin can access restricted Interface "SAP Integration Management" #(enough to be just a hidden url for now )
    And Locate Purchase Order by supplying the "Olive 3 IO ID" with or without SAP prefix (assuming they're the same as PO id)
    And Choose a new "Currency" for it
    And Cofirm they're happy to proceed:
      # "This will create a new Insertion Order with new Currency with other information the same as {Insertion Order Name},
      #  The Existing PO will be downweighted to 0 or Cancelled in Olive 3 and {Liable Entity} SAP, instead a new Purchase Order will be generated and exported to {Liable Entity} SAP.
      #  As this cannot be undone, please make sure there are no invoices processed against this IO in SAP.
      #  Are you sure you want to proceed? Yes / Cancel "
    And on confirm, new IO for new Currency is created, and it contains all the lines that were included in the prev IO
    And the line amounts are converted from USD to GBP using one of the following exchange rates:
      # use Essence internal Trading exchange rate if is defined for Old IO Currency (IN) to New IO Currency (OUT) currencies is defined (using the start date of the plan)
      # use daily spot rate otherwise (date as per current conversion logic)
    And add a negative PO line item to existing PO to downweight to 0.00, export that to SAP
    And "CANCEL" request is posted to B1I against the old Purchase Order (ignore failure)
    And if B1IF has responded with success, Olive 3 Purchase order is update to match SAP PO
    And new Purchase Order is generated from the new Insertion Order
    And user is displayed success feedback containing the new "Olive 3 IO ID" and new "SAP PO ID" (so that can be communicated back to whoever raised service desk issue)
    And the following events are recorded in Insertion Order history
    # ----------------------------------------------------------------------------------------------------------|
    # IO     | User           | Action                    | Notes                                               |
    # ----------------------------------------------------------------------------------------------------------|
    # Prev   | Currently      | Currency updated through  | {Old Currency} changed to {New Currency}            |
    #        | Logged in User | SAP Integration Admin     | New IO #{new PO ID}[link to new io] generated as a  |
    #        |                |                           | result                                              |
    # -------|----------------|---------------------------|-----------------------------------------------------|
    # New    | Currently      | Raised as a result of     | {Old Currency} changed to {New Currency}            |
    #        | Logged in User | Currency update through   | Prev IO #{Prev PO ID}[link to new io] cancelled as  |
    #        |                | SAP Integration Admin     | a result                                            |
    # ----------------------------------------------------------------------------------------------------------|
    # * note - for suppliers - use the name that's imported from Olive 2 sup_legal_entity field



#reviewed 17th June
Scenario: Handle incorrect Liable Entity (OTD-2312)
  Given Media Plan has been approved by Client
    And a Insertion Order for e.g. "Essence LON" has been raised
    And as a result a Purchase Order for "Essence LON" has been exported to SAP
    And Invoiced total for this PO is 0.00 (or no invoices have been processed/imported)
    And Invoice has come in but needs to be processed in  "Essence NA"
    And Finance require the Purchase order to be re-raised for "Essence NA"
  When Account Manager submits a an issue for service desk about wrong supplier selected for PO
  Then Olive admin can access restricted Interface "SAP Integration Management" #(enough to be just a hidden url for now )
    And Locate Purchase Order by supplying the "Olive 3 PO ID"
    And Choose a new "Liable Entity" for it
    And Cofirm they're happy to proceed:
      # "This will create a new Insertion Order for the new Liable Entity with other information the same as {Insertion Order Name},
      #  The Existing PO will be downweighted to 0 or Cancelled in Olive 3 and {Liable Entity} SAP, instead a new Purchase Order will be generated and exported to {Liable Entity} SAP.
      #  As this cannot be undone, please make sure there are no invoices processed against this IO in SAP.
      #  Are you sure you want to proceed? Yes / Cancel "
    And on confirm, new IO for new Liable Entity is created, and it contains all the lines that were included in the prev IO
    And add a negative PO line item to existing PO to downweight to 0.00, export that to SAP
    And "CANCEL" request is posted to B1I against the old Purchase Order (ignore failure)
    And if B1IF has responded with success, Olive 3 Purchase order is update to match SAP PO
    And new Purchase Order is generated from the new Insertion Order and exported to SAP / saved
    And user is displayed success feedback containing the new "Olive 3 IO ID" and new "SAP PO ID" (so that can be communicated back to whoever raised service desk issue)
    And the following events are recorded in Insertion Order history
    # ----------------------------------------------------------------------------------------------------------|
    # IO     | User           | Action                    | Notes                                               |
    # ----------------------------------------------------------------------------------------------------------|
    # Prev   | Currently      | Liable Entity updated     | {Old Supplier} changed to {New Supplier}            |
    #        | Logged in User | through SAP Integration   | New IO #{new PO ID}[link to new io] generated as a  |
    #        |                | Admin                     | result                                              |
    # -------|----------------|---------------------------|-----------------------------------------------------|
    # New    | Currently      | Raised as a result of     | {Old Supplier} changed to {New Supplier}            |
    #        | Logged in User | Liable Entity update      | Prev IO #{Prev PO ID}[link to new io] cancelled as  |
    #        |                | through SAP Integration   | a result                                            |
    #        |                | Admin                     |                                                     |
    # ----------------------------------------------------------------------------------------------------------|
    # * note - for suppliers - use the name that's imported from Olive 2 sup_legal_entity field

#to flesh out
Scenario: Close Purchase Orders for Reconciled Insertion Orders


# INVOICES
Scenario: Import invoice against discount line
