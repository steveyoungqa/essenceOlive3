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
     * @Then /^I click the "([^"]*)" checkbox$/
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
     * Double Click Element - Also used for a Hover/MouseOver event
     *
     * @Then /^I double click the "([^"]*)" link$/
     */
    public function doubleClick($click)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->doubleClick($click);
    }

    /**
     * Fill in xpath array with values
     *
     * @Then /^I fill in the "([^"]*)" with "([^"]*)"$/
     */
    public function fillInXpathWithValue($xpath, $value)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->fillInXpathLinkWithValue($xpath, $value);
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
     * Clicks link that contains the x-path ID
     *
     * @Then /^I click the link containing ID "([^"]*)"$/
     */
    public function iClickContainsXpath($click)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->clickXpathID($click);
    }

    /**
     * Checks that element with specified XPATH exists on page.
     *
     * @Then /^(?:|I )should see an? "(?P<element>[^"]*)" X-Path element$/
     */
    public function xpathIsVisible($element)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->xpathIsVisible($element);
    }

    /**
     * Clicks link that contains the text
     *
     * @Then /^I click the link containing Text "([^"]*)"$/
     */
    public function iClickContainsText($click)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->clickContainsText($click);
    }

    /**
     * Locate a checkbox based on ancestor xpath (Pain in the arse) and Deletes an existing campaign if there is one
     *
     * @Then /^I select the Delete "([^"]*)" checkbox$/
     */
    public function deleteCampaignCheckbox($campaign)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->deleteCampaign($campaign);
    }

    /**
     * Locate a checkbox based on ancestor xpath and Deletes Media Plan Line with $description
     *
     * @Then /^I delete Media Plan Line with a description of"([^"]*)"$/
     */
    public function deleteMediaPlanLine($description)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->deleteMediaPlanLine($description);
    }

    /**
     * Edit Existing Campaign
     *
     * @Given /^I select Edit for the existing Campaign "([^"]*)"$/
     */
    public function editExistingCampaign($campaign)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->editExistingCampaign($campaign);
    }

    /**
     * Locate a checkbox based on ancestor xpath (Pain in the arse) and selects for Mapping
     *
     * @Then /^I Map Search Campaign "([^"]*)"$/
     */
    public function campaignCheckbox($campaign)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->mapSearchCampaign($campaign);
    }

    /**
     * @Then /^I select a Media Plan Start Date of "([^"]*)"$/
     */
    public function iSelectAMediaPLanStartDateOf($date)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->planStartDate($date);
    }

    /**
     * @Then /^I Select a Media Plan End Date of "([^"]*)"$/
     */
    public function iSelectAMediaPlanEndDateOf($date)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->planEndDate($date);
    }

    /**
     * @Then /^I select a Plan Line Start Date of "([^"]*)"$/
     */
    public function iSelectAStartDateOf($date)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->lineStartDate($date);
    }

    /**
     * @Then /^I Select a Plan Line End Date of "([^"]*)"$/
     */
    public function iSelectAEndDateOf($date)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->lineEndDate($date);
    }

    /**
     * @Then /^I select the Media Plan linked to Campaign of "([^"]*)"$/
     */
    public function iSelectToAddAMediaPlanLineToCampaignOf($campaign)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->addMediaPlanLine($campaign);

    }

    /**
     * @Then /^I Maximize the Browser Window$/
     */
    public function maximizeWindow()
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->maximizeWindow();
    }

    /**
     * @Given /^I wait for xpath "([^"]+)" to (appear|disappear)$/
     */
    public function iWaitForXpath($text, $appear)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->waitForXpathAppear($text, $appear);
    }

    /**
     * @Given /^I wait for css element "([^"]+)" to (appear|disappear)$/
     */
    public function iWaitForCssElement($element, $appear)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->waitForCssAppear($element, $appear);
    }

    /**
     * @Given /^I wait for text "([^"]+)" to (appear|disappear)$/
     */
    public function iWaitForText($text, $appear)
    {
        /**
         * @var customTests $custom
         */
        $custom = $this->getPage('customTests');
        $custom->waitForTextAppear($text, $appear);

    }

}