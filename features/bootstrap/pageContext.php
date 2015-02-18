<?php

use \SensioLabs\Behat\PageObjectExtension\Context\PageObjectContext;


class pageContext extends PageObjectContext
{
    public function __construct(array $parameters)
    {
        // void
    }


    /**
     * For elements that don't have IDs,CSS,Values etc - so use page object arrays instead
     *
     * @Then /^I click the "([^"]*)" link$/
     */
    public function usePageObjectArray($xpath)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->clickPageObject($xpath);
    }


    /**
     * Pause for user defined time for slow loading tests/api's
     *
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
     * Clicks link that contains the x-path
     *
     * @Then /^I click "([^"]*)" xpath contains link$/
     */
    public function iClickAlternateLink($click)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->clickXpathID($click);
    }

    /**
     * Locate a checkbox based on ancestor xpath (Pain in the arse)
     *
     * @Then /^I select the "([^"]*)" checkbox$/
     */
    public function ancestorCheckbox($campaign)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->deleteCampaign($campaign);
    }




}