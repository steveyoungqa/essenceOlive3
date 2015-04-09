<?php

use Symfony\Component\Finder\Finder;
use \SensioLabs\Behat\PageObjectExtension\Context\PageObjectContext;
use Behat\Behat\Event\StepEvent;

define('SCREENSHOT_PATH', 'screenshots');
define('SCREENSHOT_URL', 'http://screenshots');
define('HTML_DUMP_PATH', 'screenshots');
define('HTML_DUMP_URL', 'http:/screenshots');


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
     * @AfterStep
     */
    public function dumpInfoAfterFailedStep(StepEvent $event)
    {

        if ($event->getResult() === StepEvent::FAILED)
        {
            $session = $this->getSession();
            $page = $session->getPage();
            $driver = $session->getDriver();
            $message = '';

            $fileName = date('D-j-M-H-i-s-A');

            if (defined('HTML_DUMP_PATH'))
            {
                if (!file_exists(HTML_DUMP_PATH))
                {
                    mkdir(HTML_DUMP_PATH);
                }

                $date = date('Y-m-d H:i:');
                $url = $session->getCurrentUrl();
                $html = $page->getContent();

                $html = "<!-- HTML dump from behat  \nDate: $date  \nUrl:  $url  -->\n " . $html;

                $htmlCapturePath = HTML_DUMP_PATH . '/' . $fileName . '.html';
                file_put_contents($htmlCapturePath, $html);

//                $message .= "\nHTML saved to: " . HTML_DUMP_PATH . "/". $fileName . ".html";
//                $message .= "\nHTML available at: " . HTML_DUMP_URL . "/". $fileName . ".html";
            }

            if ($driver instanceof \Behat\Mink\Driver\Selenium2Driver && defined('SCREENSHOT_PATH'))
            {
                if (!file_exists(SCREENSHOT_PATH))
                {
                    mkdir(SCREENSHOT_PATH);
                }

                $screenshot = $driver->getScreenshot();
                $screenshotFilePath = SCREENSHOT_PATH . '/' . $fileName . '.png';
                file_put_contents($screenshotFilePath, $screenshot);

                $message .= "\nScreenshot saved to: " . SCREENSHOT_PATH . "/". $fileName . ".png";
//                $message .= "\nScreenshot available at: " . SCREENSHOT_URL . "/". $fileName . ".png";
            }

            $exception = $event->getException();

            $reflectionObject = new ReflectionObject($exception);
            $reflectionObjectProp = $reflectionObject->getProperty('message');
            $reflectionObjectProp->setAccessible(true);
            $reflectionObjectProp->setValue($exception, $exception->getMessage() . $message);
        }
    }






}
