<?php

use Symfony\Component\Finder\Finder;
use \SensioLabs\Behat\PageObjectExtension\Context\PageObjectContext;


//class FeatureContext extends PageObjectContext implements  \Behat\MinkExtension\Context\MinkAwareInterface
class FeatureContext extends Behat\MinkExtension\Context\MinkContext
{
    protected $browserName;

    public function __construct(array $parameters)
    {
        $this->useContext('pageContext', new pageContext($parameters));

    }


    public function spin ($lambda, $wait = 60)
    {
        for ($i = 0; $i < $wait; $i++)
        {
            try {
                if ($lambda($this)) {
                    return true;
                }
            } catch (Exception $e) {
                // do nothing
            }

            sleep(1);
        }

        $backtrace = debug_backtrace();

        throw new Exception(
            "Timeout thrown by " . $backtrace[1]['class'] . "::" . $backtrace[1]['function'] . "()\n" .
            $backtrace[1]['file'] . ", line " . $backtrace[1]['line']
        );
    }

    /**
     * Take screenshot when step fails.
     * Works only with Selenium2Driver.
     *
     * @AfterStep
     */
//    public function takeScreenshotAfterFailedStep($event)
//    {
//        if (4 === $event->getResult()) {
//            $driver = $this->getSession()->getDriver();
//            if (!($driver instanceof Selenium2Driver)) {
////                throw new UnsupportedDriverActionException('Taking screenshots is not supported by %s, use Selenium2Driver instead.', $driver);
//            }
//            $directory = 'build/behat/' . $event->getLogicalParent()->getFeature()->getTitle();
//            if (!is_dir($directory)) {
//                mkdir($directory, 0777, true);
//            }
//            $filename = sprintf('%s_%s_%s_%s.%s', $event->getLogicalParent()->getTitle(), $this->browserName, date('YmdHis'), uniqid('', true), 'png');
//            file_put_contents($directory . '/' . $filename, $driver->getScreenshot());
//        }
//    }




}
