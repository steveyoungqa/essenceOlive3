<?php

use \SensioLabs\Behat\PageObjectExtension\Context\PageObjectContext;


class pageContext extends PageObjectContext
{
    public function __construct(array $parameters)
    {
        // void
    }


    /**
     * @Given /^I am on the "([^"]*)" page$/
     */
    public function iAmOnTheHomepage($home)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->home($home);

    }

    /**
     * @Given /^I select the "([^"]*)" section$/
     */
    public function iSelectTheSection($section)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->section($section);
    }

    /**
     * @Then /^I select the "([^"]*)" Sport section$/
     */
    public function iSelectTheSportSection($sport)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->sport($sport);
    }

    /**
     * @Given /^I select the Tables section$/
     */
    public function iSelectTheTablesSection()
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->table();
    }

    /**
     * @Then /^I choose my favourite team "([^"]*)"$/
     */
    public function iChooseMyFavouriteTeam($team)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->faveTeam($team);
    }

    /**
     * @Given /^I enter a User Name of "([^"]*)"$/
     */
    public function iEnterAUserNameOf($user)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->username($user);
    }

    /**
     * @Given /^I enter a Password of "([^"]*)"$/
     */
    public function iEnterAPasswordOf($password)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->password($password);
    }

    /**
     * @Given /^I select the Log In button$/
     */
    public function iSelectTheSignInButton()
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->logInButton();
    }

    /**
     * @Then /^I close the pop up box$/
     */
    public function closePopUpBox()
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->popUpBoxClose();
    }



    #CSS Contexts:

    /**
     * @Then /^I click the "([^"]*)" link$/
     */
    public function iClickLink($css)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->clickCssElementLink($css);
    }

    /**
     * @Given /^I fill in the "([^"]*)" field with "([^"]*)"$/
     */
    public function iFillInFieldWith($field, $value)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->fillCSSField($field,$value);

    }

    /**
     * @Then /^I select the "([^"]*)" checkbox$/
     */
    public function iSelectTheCheckbox($check)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
    }

    /**
     * @Then /^I wait for (\d+)$/
     */
    public function iWaitForAWhile($milliseconds)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->waitForAWhile($milliseconds);
    }

    /**
     * @Then /^I click on the Navigation header$/
     */
    public function iClickOnTheNavigationHeader()
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->clickNavHeader();
    }


}