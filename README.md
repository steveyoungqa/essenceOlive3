
#Olive 3 Regression Tests using MinkContext and Custom Context

Frontend Automaation regression tests using the Behat framework

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

 eg. Olive 3 Regression tests on Test
 ```sh
 bin/behat --tags=regression --expand --profile=test
 ```

 ```

 eg. Domains
 ```sh
 --profile=localhost #runs on http://localhost:7000/
 --profile=staging   #runs on http://ess-lon-olive-web-001s.essence.internal.com:7000/
 --profile=test      #runs on http://ess-lon-olive-web-001s.essence.internal.com:7002/
 ```
 
 eg. Other Test Packs Tags:
 ```sh
 @regression
 @campaign
 @kpi
 @login
 @mediaPlans

  
 eg:
 bin/behat --tags=regression --expand --profile=uat
 ```
 
 To supress Depreceated PHP messages:
 ```sh 
 Add this line to autoload.php
 
 error_reporting(E_ERROR | E_WARNING | E_PARSE);
 

##Using PHP Storm to Create new Automation Feature files:

 1. Download the latest version of PHP Storm (v8.03 has extended Behat support)
 
 2. The Feature files use predefined statements using the Mink Context, detailed here
 http://blog.lepine.pro/images/2012-03-behat-cheat-sheet-en.pdf
 
 3. Due to the design of the current site there are many page elements that cannot be interacted with
 using the standard Mink context, due to missing IDs, Names etc. So there is an additonal Context file
 called **pageContext.php** that has been created for other functions as follows:


 ***Then I click the "Navigation Header" link***
  ```
 Used to Click elements that do not have an ID, Title, Alt or Text matches in the code
 The text in the quotes, i.e. "Navigation Header" is an x-path defined in an array in 
 the customTests.php file
  ```
  ***Then I fill in the "Campaign Search" with "Defined Name"***
  ```
 Used to fill in elements that do not have an ID, Title, Alt or Text matches in the code
 x-path defined in an array in the customTests.php file
 
  ```
  ***Then I click the "Navigation Header" link***
  ```
 Used to Click elements that do not have an ID, Title, Alt or Text matches in the code
 The text in the quotes, i.e. "Navigation Header" is an x-path defined in an array in 
 the customTests.php file
 
  ```
  ***Then I wait for "5000"***
  ```
 Used to pause the tests and wait for the numerous API's to load in the background,
 measured in milliseconds, 1000 = 1 second
  
  ```
  ***Then I click the link containing ID "unique"***
  ```
 There will be occasions that the tests will need to interact with elements that have and ID
 that is unique or user-generated
 Example ID: [@id='campaignmarketbudget-donotdelete-q42015-united-kingdom-~-test-edit']
 Due to the many facets of creating a Campaign the ID above can be different each time,
 so this feature will click the link that contains for instance "donotdelete" which is the
 campagin name
 
  ```
  ***Then I click the link containing Text "Google Floodlights"***
  ```
 Similar to the previuous statement but this time selecting the actual text option,
 used mainly in dropdowns
 
 ```
  ***Then I select the Delete "campaign" checkbox"***
  ```
 Checkboxes throughtout the site do not have and IDs or Names, so this statement uses
 an ancestor xpath to locate a checkbox related to it, in this instance the Campaign name
 
 ```
  ***Given I select Edit for the existing Campaign "campaign"***
  
  ***Then I Map Search Campaign "searchCampaign"***
  
  ***Then I select a Media Plan Start Date of "2015-01-01"***
  
  ***Then I select a Media Plan End Date of "2015-01-01"***
  
  ***Then I select a Media Plan Line Start Date of "2015-01-01"***
  
  ***Then I select a Media Plan Line End Date of "2015-01-01"***
  
  ***And I select the Media Plan linked to Campaign of "campaign"***
 
  ```
 Full descriptions of each of these statements and their usage can be found in the
 the customTests.php file

 
 
 
 
 

