<?php
use \SensioLabs\Behat\PageObjectExtension\PageObject\Page;
use \Behat\Mink\Exception\ElementTextException;

abstract class CustomPage extends Page {

    /**
     * Sets node value Date.
     *
     * @param string $value
     */
    public function setDate($element, $inputDateValue)
    {
        try {
            $inputDateID = explode('\'',$element->getXpath())[1];

            $script = '
        (function(){
            var inputDateID = \'' . $inputDateID . '\';
            var inputDateValue = \'' . $inputDateValue . '\';

            var element = document.getElementById(inputDateID);
            if(element != null) {
                element.value = inputDateValue;
                if ("createEvent" in document) {
                    var evt = document.createEvent("HTMLEvents");
                    evt.initEvent("change", false, true);
                    element.dispatchEvent(evt);
                }
                else
                    element.fireEvent("onchange");
            }
        })();
    ';

            $element->getSession()->executeScript($script);
        } catch (\Exception $exception) {
            throw new ElementException($element, $exception);
        }
    }


}