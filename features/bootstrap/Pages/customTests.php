<?php
use Behat\Behat\Exception\BehaviorException;
date_default_timezone_set("Europe/London");
#This will fix the PHP Timezone error warnings that appeared after each step

//use \SensioLabs\Behat\PageObjectExtension\PageObject\Page;

class customTests extends CustomPage
{

    protected $elements = array(

        #essence xpaths - that dont have IDs or Values:

        'Olive Header Logo' => array('xpath' => "//*[@class='header__logo']"),
        'Logout' => array('xpath' => "//*[@class='user-logout']"),
        'Campaign Tasks Notification' => array('xpath' => "//*[@class='tasklist_item ng-scope']//*[contains(text(),'Campaign')]"),
        'Campaign Search' => array('xpath' => "//*[@id='campaign-search-basic']"),
        'Navigation Header' => array('xpath' => "//*[@class='menu-close icon icon--med icon--tables']"), //ID Needed
        'Campaigns' => array('xpath' => "//*[@id='site-navigation-campaigns']"),
        'Campaign Name' => array('xpath' => "//*[@id='campaign-new-name']"),
        'Campaign Owner' => array('xpath' => "//*[@id='campaign-new-owner']"),
        'Campaign Save' => array('xpath' => "//*[@id='campaign-new-save']"),
        'Campaign Delete' => array('xpath' => "//*[@id='campaign-delete']"),
        'editExistingCampaign' => array('xpath' => "//*[contains(@id,'actionbuttons')]"),
        'Delete Yes' => array('xpath' => "//*[@class='toast-action'][contains(text(),'Yes')]"),
        'External Platforms Market Level' => array('xpath' => "//*[@class='active--panel tiered__panel ng-scope show--panel']//*[contains(text(),'External platforms')]"),
        'External Platforms Post Create Plan' => array('xpath' => "//*[contains(@class,'active--panel')]//*[contains(text(),'External platforms')]"),
        'DBM Advertiser' => array('xpath' => "//*[@id='campaign-dbm-advertiser-link']"),
        'DS3 Advertiser' => array('xpath' => "//*[@id='campaign-ds3-advertiser-link']"),
        'External System Cancel' => array('xpath' => "//*[@id='mapping-externalSystem-cancel']"),
        'Google Sub Product' => array('xpath' => "//a[@id='campaign-google-sub-product-link']"),
        'External System Save' => array('xpath' => "//*[@class='ng-isolate-scope']//*[@class='form-standard ng-pristine ng-valid']//*[@class='tiered__actions']//*[@id='mapping-externalSystem-save']"),
        'Media Plans' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Media Plans')]"),
        'KPI Type' => array('xpath' => "//*[@id='campaign-marketbudgets-new-kpiType']"),
        'Add New Period' => array('xpath' => "//*[@class='form__input ng-isolate-scope'][3]/span/span[@class='button add--button ng-scope']"),
        'New Period Save' => array('xpath' => "//a[@id='campaign-marketbudgets-new-periods-new-save']"),
        'Close Add Period' => array('xpath' => "//*[@id='campaign-marketbudgets-new-periods-new-panel-close']"),
        'Media Plan Market' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market']"),
        'Campaign New Market' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market']"),
        'Market United Kingdom' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market-united-kingdom']"),
        'Market USA' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market-united-states']"),
        'Market Germany' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market-germany']"),
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
        'Cost Type Media' => array('xpath' => "//*[@class='form__input custom-switcher button-group button-group--standard custom-switcher button-group button-group--standard']//*[contains(text(),'Media')]"),
        'Cost Type Service' => array('xpath' => "//*[@class='custom-switcher button-group button-group--standard ng-isolate-scope']//*[contains(text(),'Service')]"),
        'Buy Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-buyType']"),
        'Line Channel' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel']"),
        'Line Channel Display' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel-display']"),
        'Line Channel Search' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel-search']"),
        'Section' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-vertical']"),
        'Section Default' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-vertical-default']"),
        'Section Edit'=>array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-vertical-default']/span[@class='icon icon--md icon--edit ng-scope']"),
        'Section Edit Input' => array('xpath' => "//input[@id='campaign-marketbudgets-versions-lines-new-vertical-edit']"),
        'Confirm Section Edit' => array('xpath' => "//*[@class='icon icon--md icon--tick']"),
        'Supplier' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-supplier']"),
        'Liable Entity' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-liableEntity']"),
        'Platform' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-externalSystem']"),
        'Platform DS3' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-externalSystem-ds3']"),
        'Platform DBM' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-externalSystem-dbm']"),
        'Property' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-indicativeProperty']"),
        'Property Edit' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-indicativeProperty']"),
        'Media Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-indicativeMediaType']"),
        'Cost Model' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costModel']"),
        'Edit Cost Model' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-costModel']"),
        'Line Currency' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-currency']"),
        'Edit Line Currency' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-currency']"),
        'Unknown Budget' => array('xpath' => "//*[@class='custom-checkbox ng-scope'][1]/span[@class='custom-checkbox__icon icon icon--tick icon--md icon--cropped']"),

        'Discount Applied' => array('xpath' => "//*[@class='custom-checkbox ng-scope'][2]/span[@class='custom-checkbox__icon icon icon--tick icon--md icon--cropped']"),
//        'Discount Amount Tab' => array('xpath' => "//*[@class=' button__label-only']//*[contains(text(),'Amount')]"),
        'Discount Value' => array('xpath' => "//*[@class=' button__label-only']//*[contains(text(),'Value')]"),
        'Discount Percentage' => array('xpath' => "//*[@class=' button__label-only']//*[contains(text(),'%')]"),
        'Discount Amount' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-discount']"),

        'Plan Line Description' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-description']"),
        'Plan Line Description Update' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-medialines-description']"),
        'Add Another' => array('xpath' => "//*[@class='custom-checkbox optional-nextstep']/span[@class='custom-checkbox__icon icon icon--tick icon--md icon--cropped']"),
        'Save Media Plan Line' => array('xpath' => "//*[@id='save']"),
        'Save Media Plan Line And Publish' => array('xpath' => "//*[@id='save-and-publish']"),
        'Publish Selected' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-line-move'][2]"),
        'Publish Media Plan' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-publish']"),
        'External Platforms Insertion Order' => array('xpath' => "//*[@class='md-header-items-container']//*[contains(text(),'External platforms')]"),
        'Insertion Order tab' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Insertion orders')]"),
        'View IO' => array('xpath' => "//*[@class='button button__label-only']//*[contains(text(),'View IO')]"),
        'Link DS3' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-ios-ds3-link']"),
        'Plan Lines' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Plan Lines')]"),
        'Manage mappings' => array('xpath' => "//*[contains(text(),'Manage mappings')]"),
        'Mapping Search' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-ios-medialines-trackingcodes-search-basic']"),
        'Save Managed Entities' => array('xpath' => "//*[@class='page-actions table-actions']/a[@class='button add--button']"),
        'Close Manage Mapping Panel' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-ios-medialines-trackingcodes-panel-close']"),
        'Close Mapped Panel' => array('xpath' => "//*[@class='button__icon button__icon--left icon icon--clear icon--lrg icon--cropped']"),

        'Plan tab' => array('xpath' => "//*[@class='md-header-items']//*[contains(text(),'Plan')]"),
        'Edit Plan Line' => array('xpath' => "//*[@class='table__actions ng-scope']//*[contains(text(),'Edit')]"),
        'Plan Line Delete' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-line-delete']"),

        'Request Approval' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-manage-approval']"),
        'Add Approver' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add']"),
        'Save Approver' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add-save']"),
        'Publish Dropdown' => array('xpath' => "//*[@class='expandable-dropdown__toggle']"),
        'Published State' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-published']"),
        'Editable Draft State' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-editable']"),
        'Approver Field' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add-person']"),
        'Internal Approver' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add-type-internal']"),
        'Steve Automation' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-add-person-steve-automation']"),
        'Request Approval Confirm' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-approvers-request']"),
        'Approve or Reject' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-set-status']"),
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
        'Tracking Management DS3' => array('xpath' => "//*[@class='ng-scope'][1]/a[@id='site-navigation-campaigns-tracking-management-ds3']"),
        'Tracking Code Search Box' => array ('xpath' => "//*[@id='tracking-code-search-basic']"),
        'Advanced Filter' => array('xpath' => "//*[@id='tracking-code-search-advanced']"),
        'DS3 Advertiser Filter' => array('xpath' => "//*[@id='tracking-code-search-advertiser']"),
        'Campaign Filter' => array('xpath' => "//*[@id='tracking-code-search-campaign']"),
        'Advanced Search Close' => array('xpath' => "//*[@id='tracking-code-search-close']"),
        'Tracking Details' => array('xpath' => "//*[contains(@id,'actionbuttons')]"),
        'Action Buttons' => array('xpath' => "//*[contains(@id,'actionbuttons')]"),
        'Media Plan Button' => array('xpath' => "//*[@ol-message='marketbudget:action:plan']"),
        'DS3 Account ID' => array('xpath' => "//*[@id='mapping-externalSystem-ds3']"),

        'KPI Brand' => array('xpath' => "//*[@id='campaign-marketbudgets-new-kpiType-brand']/span[@class='ng-binding ng-scope']"),
        'KPI DR' => array('xpath' => "//*[@id='campaign-marketbudgets-new-kpiType-dr']/span[@class='ng-binding ng-scope']"),

////       THESE FOUR FOLLOWING IDS - XPATHS ARE NOT RECOGNISED SINCE DEV CHANGES TO MEDIA PLAN - SARAH TO INVESTIGATE:
        'KPI Type Long Path' => array('xpath' => "/html/body/div[4]/div[2]/div/div/div[1]/div/form/fieldset/ul[1]/li[2]"),
        'Market Long Path' => array('xpath' => "/html/body/div[4]/div[2]/div/div/div[1]/div/form/fieldset/ul[1]/li[4]"),
        'Media Plan Long Save' => array('xpath' => "//*[@class='tiered__panel-details ng-scope']/div[@class='ng-isolate-scope']//*[contains(text(),'Save')]"),
        'Use Olive 2 MAFs' => array('xpath' => "/html/body/div[4]/div[2]/div/div/div[1]/div/form/fieldset/ul[1]/li[12]/label[2]/span[1]"),

        'First Plan Line Edit' => array('xpath' => "//*[@class='ng-scope'][1]/td//*[contains(text(),'Edit')]"),
        'Second Plan Line Edit' => array('xpath' => "//*[@class='ng-scope'][2]/td//*[contains(text(),'Edit')]"),
        'Third Plan Line Edit' => array('xpath' => "//*[@class='ng-scope'][3]/td//*[contains(text(),'Edit')]"),
        'Continue & Publish' => array('xpath' => "//*[@class='toast-message error--message show']//*[contains(text(),'Continue & Publish')]"),
        );


    public function textOutput ($output)
    {
//        echo("\033[01;33m '.$output.'\033[0m");
        echo "\033[33m $output \033\n";
    }

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

    public function selectMediaPlanLineCheckbox ($description)
    {
        $element = $this->find('xpath', '//ancestor::tbody/tr[td//text()[contains(., "'.$description.'")]]//*[@class="custom-checkbox__icon icon icon--tick icon--md icon--cropped"]');
        if (isset($element)) {
            $element->click();
        } else {
            echo("\033[01;36m '.$description.' checkbox was not found\033[0m");
        }
    }

    public function mapSearchCampaign ($campaign)
    {
        $element = $this->find('xpath', '//ancestor::tbody/tr[td//text()[contains(., "'.$campaign.'")]]//*[@class="custom-checkbox__icon icon icon--tick icon--md icon--cropped"]');
        if (isset($element)) {
            $element->check();
            $this->getSession()->wait(5000);
        } else {
            throw new Exception('ERROR!! '.$campaign.' Checkbox not found!!');
        }
    }

    public function editExistingCampaign ($campaign)
    {
        $this->getElement('editExistingCampaign')->click();
        $element = $this->find('xpath', '//*[contains(@id,"'.$campaign.'")][contains(@id,"edit")]//*[@class="button button__icon-only"]');

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

    public function waitForXpathAppear ($xpath, $appear)
    {
        $this->waitForXpathNode($xpath, $appear == 'appear');
        $this->getSession()->wait(2000);
    }

    public function waitForCssAppear ($element, $appear)
    {
        $xpath = $this->getSession()->getSelectorsHandler()->selectorToXpath('css', $element);
        $this->waitForXpathNode($xpath, $appear == 'appear');
    }

    public function waitForTextAppear ($text, $appear)
    {
        $this->waitForXpathNode(".//*[contains(normalize-space(string(text())), \"$text\")]", $appear == 'appear');
    }

    private function waitPeriod($fn, $timeout = 50000)
    {
        $start = microtime(true);
        $end = $start + $timeout / 1000.0;
        while (microtime(true) < $end) {
            if ($fn($this)) {
                return;
            }
        }
        throw new \Exception("Waited for Element but it timed out after 50 seconds");
    }

    private function waitForXpathNode($xpath, $appear)
    {
        $this->waitPeriod(function($context) use ($xpath, $appear) {
            try {
                $nodes = $context->getSession()->getDriver()->find($xpath);
                if (count($nodes) > 0) {
//                    assertEquals(1, count($nodes), "more than one element matched '$xpath'");
                    $visible = $nodes[0]->isVisible();
                    return $appear ? $visible : !$visible;
                } else {
                    return !$appear;
                }
            } catch (WebDriver\Exception $e) {
                if ($e->getCode() == WebDriver\Exception::NO_SUCH_ELEMENT) {
                    return !$appear;
                }
                throw $e;
            }
        });
    }


}