
#Olive 3 Regression Tests using better MinkContext method

Frontend regression tests using the Behat framework

Behat is an open source behavior-driven development framework for PHP 5.3+ using Gherkin language feature files to interact with web browsers via the Mink library.

###Dependencies

* PHP 5.3 or later

##Setup

1. Git clone this repository and cd/dir into it's root directory
 ```sh
 git clone https://github.com/essence-tech/essence-olive-3-qa-mink-context
 cd essence-olive-3-qa-mink-context
 ```

2. Download the composer package manager and run install to get all the vendors (behat, selenium, etc)
 ```sh
 curl http://getcomposer.org/installer | php
 php composer.phar install --prefer-source
 ```

3. Download the lastest version of chromedriver for your system and copy to bin/ dir:
 http://chromedriver.storage.googleapis.com/index.html
 
 For Mac systems you can use Brew to add chromedriver to /user/local/bin. Install Brew if you don't already have it:
 ```sh
 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
 ```

 Then install Chromedriver:
 ```sh
 brew install chromedriver
 ```

4. Screenshots will be saved on failed steps when using Selenium2driver ONLY and copy to 
 behatFramework/build/behat/ dir:
 http://chromedriver.storage.googleapis.com/index.html

##Run the tests

1. Run selenium
 ```sh
 bin/selenium-server-standalone
 ```

2. Run behat

 eg. Olive 3 Regression tests on UAT
 ```sh
 bin/behat --tags=regression --expand --profile=test
 ```

 ```
 

