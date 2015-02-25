<?php
use Behat\Behat\Exception\BehaviorException;
date_default_timezone_set("Europe/London");
#This will fix the PHP Timezone error warnings that appeared after each step

//use \SensioLabs\Behat\PageObjectExtension\PageObject\Page;

class customTests extends CustomPage
{

    protected $elements = array(

        #essence xpaths - that dont have IDs or Values:

        'Navigation Header' => array('xpath' => "//*[@class='menu-close icon icon--med icon--tables']"), //ID Needed
        'Campaign Save' => array('xpath' => "//*[@id='campaign-new-save']"),
        'Campaign Delete' => array('xpath' => "//*[@id='campaign-delete']"),
        'Delete Yes' => array('xpath' => "//*[@class='toast-action'][contains(text(),'Yes')]"),
        'External Platforms' => array('xpath' => "//*[@class='header--tabs']//*[contains(text(),'External platforms')]"),
        'Google Sub Product' => array('xpath' => "//a[@id='campaign-google-sub-product-link']"),
        'External System Save' => array('xpath' => "//*[@class='ng-isolate-scope']//*[@class='form-standard ng-pristine ng-valid']//*[@class='tiered__actions']//*[@id='mapping-externalSystem-save']"),
        'Media Plans' => array('xpath' => "//*[@class='header--tabs']//*[contains(text(),'Media Plans')]"),
        'Add New Period' => array('xpath' => "//*[@class='form__input']//*[@class='button add--button ng-scope']"),
        'New Period Save' => array('xpath' => "//a[@id='campaign-marketbudgets-new-periods-new-save']"),
        'Close Add Period' => array('xpath' => "//*[@id='campaign-marketbudgets-new-periods-new-panel-close']"),
        'Media Plan Market' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market']"),
        'Campaign New Market' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market']"),
        'Market United Kingdom' => array('xpath' => "//*[@id='campaign-marketbudgets-new-market-united-kingdom']"),
        'Start Date Media Plan' => array('xpath' => "//input[@id='campaign-marketbudgets-new-startDate']"),
        'End Date Media Plan' => array('xpath' => "//input[@id='campaign-marketbudgets-new-endDate']"),
        'Start Date Media Plan Line' => array('xpath' => "//input[@id='campaign-marketbudgets-versions-lines-new-startDate']"),
        'End Date Media Plan Line' => array('xpath' => "//input[@id='campaign-marketbudgets-versions-lines-new-endDate']"),
        'Media Plan Save' => array('xpath' => "//a[@id='campaign-marketbudgets-new-save']"),
        'Link Google Initiative' => array('xpath' => "//a[@id='campaign-marketbudgets-google-initiative-link']"),
        'Save Mapped Account' => array('xpath' => "//*[@class='ng-isolate-scope']//*[@class='ng-isolate-scope']//*[@id='mapping-externalSystem-save']"),
        'Previous Breadcrumb' => array('xpath' => "//*[@class='linkContainer ng-scope']/a[@id='breadcrumb-1']"),
        'Media Plan Whole Column' => array('xpath' => "//*[@class='ng-scope']/div[@class='ng-scope']/ol-list[@class='ng-isolate-scope']/table[@class='standard-table table__records-editable']/tbody[@class='ng-scope']//*[@class='ol-list-item ol-drag-preview ng-scope']"),

        'Add Media Plan Line' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-line-add']"),
        'Line Cost Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costType']"),
        'Cost Type Media' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costType-media']"),
        'Cost Type Service' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costType-service']"),
        'Line Channel' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel']"),
        'Line Channel Display' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel-display']"),
        'Line Channel Search' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-channel-search']"),
        'Section' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-vertical']"),
        'Supplier' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-supplier']"),
        'Platform' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-externalSystem']"),
        'Property' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-indicativeProperty']"),
        'Media Type' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-indicativeMediaType']"),
        'Cost Model' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-costModel']"),
        'Line Currency' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-lines-new-currency']"),
        'Save Media Plan Line' => array('xpath' => "//a[@id='campaign-marketbudgets-versions-lines-new-save']"),
        'Publish Media Plan' => array('xpath' => "//*[@id='campaign-marketbudgets-mediaplan-publish']"),
        'External Platforms tab' => array('xpath' => "//*[@class='navigation-tabs']//*[contains(text(),'External platforms')]"),
        'Insertion Order tab' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-ios-tab']"),
        'Map Lines' => array('xpath' => "//*[@class='button button__label-only']//*[contains(text(),'Map lines')]"),
        'Link DS3' => array('xpath' => "//*[@id='campaign-marketbudgets-versions-ios-ds3-link']"),
        'Plan Lines tab' => array('xpath' => "//*[@class='navigation-tabs']//*[contains(text(),'Plan Lines')]"),
        'Manage Mapped Entities' => array('xpath' => "//*[contains(text(),'Manage mapped campaigns')]"),
        'Save Managed Entities' => array('xpath' => "//*[@class='page-actions table-actions']/a[@class='button add--button']"),

    );

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

    public function waitForAWhile ($milliseconds)
    {
        $this->getSession()->wait($milliseconds);
    }

    public function clickPageObject ($xpath)
    {
        $this->getElement($xpath)->click();
        $this->getSession()->wait(2000);

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

}