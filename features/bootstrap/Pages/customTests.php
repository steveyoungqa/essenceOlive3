<?php
use Behat\Behat\Exception\BehaviorException;
date_default_timezone_set("Europe/London");
#This will fix the PHP Timezone error warnings that appeared after each step

//use \SensioLabs\Behat\PageObjectExtension\PageObject\Page;

class customTests extends CustomPage
{

    protected $elements = array(

        #essence xpaths - that dont have IDs or Values:

        'Campaign Search' => array('xpath' => "//*[@id='campaign-search-basic']"),
        'Navigation Header' => array('xpath' => "//*[@class='menu-close icon icon--med icon--tables']"), //ID Needed
        'Campaigns' => array('xpath' => "//*[@id='site-navigation-campaigns']"),
        'Campaign Name' => array('xpath' => "//*[@id='campaign-new-name']"),
        'Campaign Save' => array('xpath' => "//*[@id='campaign-new-save']"),
        'Campaign Delete' => array('xpath' => "//*[@id='campaign-delete']"),
        'editExistingCampaign' => array('xpath' => "//*[contains(@id,'actionbuttons')]"),
        'Delete Yes' => array('xpath' => "//*[@class='toast-action'][contains(text(),'Yes')]"),
        'External Platforms Market Level' => array('xpath' => "//*[@class='active--panel tiered__panel ng-scope show--panel']//*[contains(text(),'External platforms')]"),
        'External Platforms Post Create Plan' => array('xpath' => "//*[contains(@class,'active--panel')]//*[contains(text(),'External platforms')]"),
        'Google Sub Product' => array('xpath' => "//a[@id='campaign-google-sub-product-link']"),
        'External System Save' => array('xpath' => "//*[@class='ng-isolate-scope']//*[@class='form-standard ng-pristine ng-valid']//*[@class='tiered__actions']//*[@id='mapping-externalSystem-save']"),
        'Media Plans' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Media Plans')]"),
        'KPI Type' => array('xpath' => "//*[@id='campaign-marketbudgets-new-kpiType']"),
        'Add New Period' => array('xpath' => "//*[@class='form__input']//*[@class='button add--button ng-scope']"),
        'New Period Save' => array('xpath' => "//a[@id='campaign-marketbudgets-new-periods-new-save']"),
        'Close Add Period' => array('xpath' => "//*[@id='campaign-marketbudgets-new-periods-new-panel-close']"),
        'Media Plan Market' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market']"),
        'Campaign New Market' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market']"),
        'Market United Kingdom' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market-united-kingdom']"),
        'Market USA' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market-united-states']"),
        'Start Date Media Plan' => array('xpath' => "//input[@id='campaign-marketbudgets-new-startDate']"),
        'End Date Media Plan' => array('xpath' => "//input[@id='campaign-marketbudgets-new-endDate']"),
        'Start Date Media Plan Line' => array('xpath' => "//input[@id='campaign-marketbudgets-versions-lines-new-startDate']"),
        'End Date Media Plan Line' => array('xpath' => "//input[@id='campaign-marketbudgets-versions-lines-new-endDate']"),
        'Olive 2 MAF Tooltip' => array('xpath' => "//*[@class='flyout_container flyout_onhover highlight_container highlight-none-blue ng-scope']/span[@class='button__icon button__icon--left icon icon--lrg icon--cropped icon--info color--icon']"),
        'Media Plan Save' => array('xpath' => "//*[@id='campaign-marketbudgets-new-save']"),
        'Link Google Initiative' => array('xpath' => "//a[@id='campaign-marketbudgets-google-initiative-link']"),
        'Save Mapped Account' => array('xpath' => "//*[@class='ng-isolate-scope']//*[@class='ng-isolate-scope']//*[@id='mapping-externalSystem-save']"),
        'Previous Breadcrumb' => array('xpath' => "//*[@class='linkContainer breadcrumb-step ng-scope']/a[@id='breadcrumb-1']"),
        'Media Plan Whole Column' => array('xpath' => "//*[@class='ng-scope']/div[@class='ng-scope']/ol-list[@class='ng-isolate-scope']/table[@class='standard-table table__records-editable']/tbody[@class='ng-scope']//*[@class='ol-list-item ol-drag-preview ng-scope']"),

        'Add Media Plan Line' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-line-add']"),
        'Line Cost Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costType']"),
        'Cost Type Media' => array('xpath' => "//*[@class='custom-switcher button-group button-group--standard ng-isolate-scope']//*[contains(text(),'Media')]"),
        'Cost Type Service' => array('xpath' => "//*[@class='custom-switcher button-group button-group--standard ng-isolate-scope']//*[contains(text(),'Service')]"),
        'Buy Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-buyType']"),
        'Line Channel' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel']"),
        'Line Channel Display' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel-display']"),
        'Line Channel Search' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel-search']"),
        'Section' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-vertical']"),
        'Section Edit'=>array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-vertical-default']/span[@class='icon icon--md icon--edit ng-scope']"),
        'Section Edit Input' => array('xpath' => "//input[@id='campaign-marketbudgets-versions-lines-new-vertical-edit']"),
        'Confirm Section Edit' => array('xpath' => "//*[@class='icon icon--md icon--tick']"),
        'Supplier' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-supplier']"),
        'Liable Entity' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-liableEntity']"),
        'Platform' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-externalSystem']"),
        'Property' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-indicativeProperty']"),
        'Media Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-indicativeMediaType']"),
        'Cost Model' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costModel']"),
        'Edit Cost Model' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-costModel']"),
        'Line Currency' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-currency']"),
        'Edit Line Currency' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-currency']"),
        'Unknown Budget' => array('xpath' => "//*[@class='form__input']//*[@class='custom-checkbox__icon icon icon--tick icon--md icon--cropped']"),
        'Plan Line Description' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-description']"),
        'Save Media Plan Line' => array('xpath' => "//a[@id='campaign-marketbudgets-versions-lines-new-save']"),
        'Save Edited Media Plan Line' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-save']"),
        'Publish Media Plan' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-publish']"),
        'External Platforms Insertion Order' => array('xpath' => "//*[@class='md-header-items-container']//*[contains(text(),'External platforms')]"),
        'Insertion Order tab' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Insertion orders')]"),
        'View IO' => array('xpath' => "//*[@class='button button__label-only']//*[contains(text(),'View IO')]"),
        'Link DS3' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-ios-ds3-link']"),
        'Plan Lines' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Plan Lines')]"),
        'Manage mappings' => array('xpath' => "//*[contains(text(),'Manage mappings')]"),
        'Save Managed Entities' => array('xpath' => "//*[@class='page-actions table-actions']/a[@class='button add--button']"),
        'Close Mapped Panel' => array('xpath' => "//*[@class='button__icon button__icon--left icon icon--clear icon--lrg icon--cropped']"),
        'Plan tab' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Plan')]"),
        'Edit Plan Line' => array('xpath' => "//*[@class='table__actions ng-scope']//*[contains(text(),'Edit')]"),
        'Plan Line Delete' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-line-delete']"),

        'Manage Approval' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-manage-approval']"),
        'Add Approver' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add']"),
        'Save Approver' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add-save']"),
        'Publish Dropdown' => array('xpath' => "//*[@class='expandable-dropdown__toggle']"),
        'Published State' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-published']"),
        'Editable Draft State' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-editable']"),
        'Approver Field' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add-person']"),
        'Request Approval' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-request']"),
        'Set Status' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-set-status']"),
        'Feedback Notes' => array('xpath' => "//*[@ng-model='feedback.note']"),
        'Approve' => array('xpath' => "//*[@class='button'][contains(text(),'Approve')]"),
        'Reject' => array('xpath' => "//*[@class='button remove--button']"),
        'Default KPIs' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Default KPIs')]"),
        'Manage Conversion Event Mapping' => array('xpath' => "//*[@id='campaign-conversion-mapping']"),
        'Add KPI' => array('xpath' => "//*[@id='campaign-events-add']"),
        'KPI Event Type' => array('xpath' => "//*[@id='campaign-events-new-kpiType']"),
        'KPI Event Number' => array('xpath' => "//*[@id='campaign-events-new-number']"),
        'KPI Event Name' => array('xpath' => "//*[@id='campaign-events-new-name']"),
        'Conversion Source Field' => array('xpath' => "//*[@id='campaign-events-new-source']"),
        'Google Floodlights' => array('xpath' => "//*[@id='campaign-events-new-source-google-floodlights']"),
        'Event Save' => array('xpath' => "//*[@id='campaign-events-new-save']"),
        'Add Tag' => array('xpath' => "//*[@id='campaign-events-tags-add']"),
        'Conversion Type' => array('xpath' => "//*[@id='campaign-events-tags-new-conversionType']"),
        'Activity Category' => array('xpath' => "//*[@id='campaign-events-tags-new-activityGroup']"),
        'Activity Tag' => array('xpath' => "//*[@id='campaign-events-tags-new-activityTag']"),
        'Weighting' => array('xpath' => "//*[@id='campaign-events-tags-new-weight']"),
        'Tag Save' => array('xpath' => "//*[@id='campaign-events-tags-new-save']"),
        'Tracking Management' => array('xpath' => "//*[@id='site-navigation-campaigns-tracking-management']"),
        'Tracking Code Search Box' => array ('xpath' => "//*[@id='trackingcode-search-basic']"),
        'Advanced Filter' => array('xpath' => "//*[@id='trackingcode-search-advanced']"),
        'DS3 Advertiser Filter' => array('xpath' => "//*[@id='trackingcode-search-advertiser']"),
        'Advanced Search Close' => array('xpath' => "//*[@id='trackingcode-search-close']"),
        'Tracking Details' => array('xpath' => "//*[contains(@id,'actionbuttons')]"),
        'Action Buttons' => array('xpath' => "//*[contains(@id,'actionbuttons')]"),
        'Media Plan Button' => array('xpath' => "//*[@ol-message='marketbudget:action:plan']"),
        'DS3 Account ID' => array('xpath' => "//*[@id='mapping-externalSystem-ds3']"),

        'KPI Brand' => array('xpath' => "//*[@id='campaign-marketbudgets-new-kpiType-brand']/span[@class='ng-binding ng-scope']"),

//       THESE FOUR FOLLOWING IDS - XPATHS ARE NOT RECOGNISED SINCE DEV CHANGES TO MEDIA PLAN - SARAH TO INVESTIGATE:
        'KPI Type Long Path' => array('xpath' => "/html/body/div[4]/div[2]/div/div/div[1]/div/form/fieldset/ul[1]/li[2]"),
        'Market Long Path' => array('xpath' => "/html/body/div[4]/div[2]/div/div/div[1]/div/form/fieldset/ul[1]/li[4]"),
        'Media Plan Long Save' => array('xpath' => "//*[@class='tiered__panel-inner']/div[@class='ng-scope']/div[@class='tiered__panel-details ng-scope']/div[@class='ng-isolate-scope']/div[@class='tiered__actions ng-scope']//*[contains(text(),'Save')]"),
        'Use Olive 2 MAFs' => array('xpath' => "/html/body/div[4]/div[2]/div/div/div[1]/div/form/fieldset/ul[1]/li[11]/label[2]/span[1]"),

        'First Plan Line Edit' => array('xpath' => "//*[@class='ng-scope'][1]/td//*[contains(text(),'Edit')]"),
        'Continue & Publish' => array('xpath' => "//*[@class='toast-message error--message show']//*[contains(text(),'Continue & Publish')]"),
        );


    public function clickPageObject ($xpath)
    {
        $this->getElement($xpath)->click();
        $this->getSession()->wait(2000);
    }

    public function waitForAWhile ($milliseconds)
    {
        $this->getSession()->wait($milliseconds);
    }

    public function clickXpathID ($click)
    {
        $element = $this->find('xpath', '//*[contains(@id,"'.$click.'")]');
        if (isset($element)) {
            $element->click();
        }
        else {
            throw new Exception (".$click. Element not found");
        }
    }

    public function xpathIsVisible ($element)
    {
        $element = $this->getElement($element);
        if (isset($element)) {
        }
        else {
            throw new Exception (".$element. Element not found");
        }
    }

    public function doubleClick ($click)
    {
        $element = $this->getElement($click);
        if (isset($element)) {
            $element->doubleClick();
        }
        else {
            throw new Exception (".$click. Element not found");
        }
    }

    public function clickContainsText ($click)
    {
        $element = $this->find('xpath', '//*[contains(text(),"'.$click.'")]');
        if (isset($element)) {
            $element->click();
        }
        else {
            throw new Exception (".$click. Element not found");
        }
    }

    public function fillInXpathLinkWithValue ($xpath, $value)
    {
        $this->getElement($xpath)->setValue($value);

//        $this->getElement($xpath)->setValue($xpath,$value);

//        $xpath = $this->fixStepArgument($xpath);
//        $value = $this->fixStepArgument($value);
//        $this->getSession()->getPage()->fillField($xpath, $value);

    }

    public function deleteCampaign ($campaign)
    {
        $element = $this->find('xpath', '//ancestor::tbody/tr[td//text()[contains(., "'.$campaign.'")]]//*[@class="custom-checkbox__icon icon icon--tick icon--md icon--cropped"]');
        if (isset($element)) {
            $element->click();
            $this->getElement('Campaign Delete')->click();
            $this->getSession()->wait(2000);
            $this->getElement('Delete Yes')->click();
        } else {
            echo("\033[01;36m '.$campaign.' was not found so doesn't need to be deleted\033[0m");
        }
    }

    public function deleteMediaPlanLine ($description)
    {
        $element = $this->find('xpath', '//ancestor::tbody/tr[td//text()[contains(., "'.$description.'")]]//*[@class="custom-checkbox__icon icon icon--tick icon--md icon--cropped"]');
        if (isset($element)) {
            $element->click();
            $this->getElement('Plan Line Delete')->click();
            $this->getSession()->wait(2000);
//            $this->getElement('Delete Yes')->click();
        } else {
            echo("\033[01;36m '.$description.' was not found so doesn't need to be deleted\033[0m");
        }
    }

    public function mapSearchCampaign ($campaign)
    {
        $element = $this->find('xpath', '//ancestor::tbody/tr[td//text()[contains(., "'.$campaign.'")]]//*[@class="custom-checkbox__icon icon icon--tick icon--md icon--cropped"]');
        if (isset($element)) {
            $element->click();
            $this->getSession()->wait(5000);
        } else {
            throw new Exception('ERROR!! '.$campaign.' Checkbox not found!!');
        }
    }

    public function editExistingCampaign ($campaign)
    {
        $this->getElement('editExistingCampaign')->click();
        $element = $this->find('xpath', '//*[contains(@id,"'.$campaign.'")][contains(@id,"edit")]');

        if (isset($element)) {
            $element->click();
        } else {
            throw new Exception(' '.$campaign.' not found');
        }
        $this->getSession()->wait(3000);
    }

    public function planStartDate ($date)
    {
        $this->setDate($this->getElement('Start Date Media Plan'), $date);
    }

    public function planEndDate ($date)
    {
        $this->setDate($this->getElement('End Date Media Plan'), $date);
    }

    public function lineStartDate ($date)
    {
        $this->setDate($this->getElement('Start Date Media Plan Line'), $date);
    }

    public function lineEndDate ($date)
    {
        $this->setDate($this->getElement('End Date Media Plan Line'), $date);
    }

    public function addMediaPlanLine ($campaign)
    {

        $element = $this->find('xpath', '//*[@class="standard-table-cell ng-scope"]//*[@class="ng-scope"]//*[contains(@id,"'.$campaign.'")]');
        if (isset($element)) {
            $element->click();
        } else {
            throw new Exception('Element not found');
        }
        $this->getSession()->wait(5000);
    }

    public function maximizeWindow ()
    {
        $this->getSession()->resizeWindow(1440,800);
    }

}