<?php
use Behat\Behat\Exception\BehaviorException;
date_default_timezone_set("Europe/London");
#This will fix the PHP Timezone error warnings that appeared after each step

//use \SensioLabs\Behat\PageObjectExtension\PageObject\Page;

class customTests extends CustomPage
{

    protected $elements = array(
        'homePage' => array('xpath' => "http://www.bbc.co.uk/"),
        'sport' => array ('xpath' => "//*[@id='orb-nav-links']//*[@class='orb-nav-sport']"),
        'football' => array('xpath' => "//*[@class='primary-nav__link-text'][contains(text(),'Football')]"),
        'tables' => array('xpath' => "//*[@class='secondary-nav__link']//*[@class='secondary-nav__link-text'][contains(text(),'Tables')]"),
        'crystalPalace' => array('xpath' => "//*[@id='table-data']//*[@class='league-table full-table-wide']//*[@id='team-crystal-palace']//*[@class='team-name']"),

        #orange branding xpaths:

        'user' =>array('xpath' =>"//*[@id='name']"),
        'password' =>array('xpath' =>"//*[@id='pass']"),
        'login' =>array('xpath' => "//*[@id='login-submit']"),
        'popUpBoxClose' => array('xpath' => "//*[@id='fancybox-close']"),

        #essence xpaths:
        'navigationHeader' => array('xpath' => "//*[@class='menu-close icon icon--med icon--tables']"), //ID Needed



    );

    #x-path arrays (BBC tests):

    public function username ($user)
    {
        $this->getElement('user')->setValue($user);
    }

    public function password ($password)
    {
        $this->getElement('password')->setValue($password);
    }

    public function logInButton ()
    {
        $this->getElement('login')->click();
    }

    public function popUpBoxClose ()
    {
        $this->getElement('popUpBoxClose')->click();
    }


    public function home ($home)
    {
        $this->getSession()->visit($home);

    }

    public function section ($section)
    {
        if ($section==="Sport")
        {
            $this->getElement('sport')->click();
            $this->getSession()->wait(2000);
        }

        else {
            throw new Exception ('Section not found or defined');
        }
    }

    public function sport ($sport)
    {
        if ($sport==="Football")
        {
            $this->getElement('football')->click();
            $this->getSession()->wait(2000);
        }

        else {
            throw new Exception ('Sport not found or defined');
        }
    }

    public function table ()
    {
        $this->getElement('tables')->click();
        $this->getSession()->wait(2000);
    }

    public function faveTeam ($team)
    {
        $this->getElement('crystalPalace')->click();
    }

    #CSS Elements Code:

    public function clickCssElementLink ($css)
    {
        $element = $this->getSession()->getPage()->find("css", $css);

        if (empty($element)) {
            throw new Exception (".$css. Element not found");
        }
        $element->click();
        $this->getSession()->wait(500);

    }

    public function fillCSSField ($field, $value)
    {
        $element = $this->getSession()->getPage()->find("css", $field);

        if (empty($element)) {
            throw new Exception (".$field. Element not found");
        }

        $element->setValue($value);

    }

    public function waitForAWhile ($milliseconds)
    {
        $this->getSession()->wait($milliseconds);
    }

    public function clickNavHeader ()
    {
        $this->getElement('navigationHeader')->click();
        $this->getSession()->wait(2000);

    }




}