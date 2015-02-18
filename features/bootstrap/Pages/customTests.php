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
        'Save' => array('xpath' => "//*[@id='campaign-new-save']"),
        'Delete' => array('xpath' => "//*[@id='campaign-delete']"),
        'Delete Yes' => array('xpath' => "//*[@class='toast-action'][contains(text(),'Yes')]"),

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
        } else {
            throw new Exception('ERROR!! '.$campaign.' Checkbox not found!!');
        }
    }




}