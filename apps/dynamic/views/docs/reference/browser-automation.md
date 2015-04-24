---
title: Browser Automation
nav: docs
renderer: Cucumber::Website::Reference
---

# Browser Automation

Cucumber is not a Browser Automation tool, but it works well with Browser
Automation tools such as:

* [Selenium Webdriver](http://docs.seleniumhq.org/projects/webdriver/).
* [Watir](http://watir.com/)

## Selenium WebDriver

Let's convert the [Selenium-Webdriver by Example tutorial](http://docs.seleniumhq.org/docs/03_webdriver.jsp#introducing-the-selenium-webdriver-api-by-example) to use Cucumber.

We can express the example as the following Scenario:

```gherkin
Scenario: Finding some cheese
	Given I am on the Google search page
	When I search for "Cheese!"
	Then the page title should start with "cheese"
```

Here are the accompanying Step Definitions:

[carousel]

```ruby
# TODO! See the Java example for now.
```

```java
package com.example;

public class ExampleSteps {
    private final WebDriver driver = new FirefoxDriver();

    @Given("^I am on the Google search page$")
    public void I_visit_google() {
      driver.get("https://www.google.com");
    }

    @When("^I search for \"(.*)\"$")
    public void search_for(String query) {
        WebElement element = browser.findElement(By.name("q"));
        // Enter something to search for
        element.sendKeys(query);
        // Now submit the form. WebDriver will find the form for us from the element
        element.submit();
    }

    @Then("^the page title should start with \"(.*)\"$")
    public void checkTitle() {
        // Google's search is rendered dynamically with JavaScript.
        // Wait for the page to load, timeout after 10 seconds
        (new WebDriverWait(driver, 10)).until(new ExpectedCondition<Boolean>() {
            public Boolean apply(WebDriver d) {
                return d.getTitle().toLowerCase().startsWith("cheese");
            }
        });
        assertThat(driver.getTitle(), startsWith("cheese"));
        // Should see: "cheese! - Google Search"
    }

    @After()
    public void closeBrowser() {
        driver.quit();
    }
}
```

```groovy
// TODO! See the Java example for now.
```

```javascript
// TODO! See the Java example for now.
```

```clojure
; TODO! See the Java example for now.
```

```cpp
// TODO! See the Java example for now.
```

```csharp
// TODO! See the Java example for now.
```

```fsharp
// TODO! See the Java example for now.
```

```lua
-- TODO! See the Java example for now.
```

```python
# TODO! See the Java example for now.
```

```scala
// TODO! See the Java example for now.
```

```tcl
# TODO! See the Java example for now.
```

[/carousel]

## Watir

TODO

## Tips and Tricks

### Re-using the browser window

Closing and re-opening the browser window between your scenarios will slow them down.

To re-use them you can use the [SharedDriver](https://github.com/cucumber/cucumber-jvm/blob/master/examples/java-webbit-websockets-selenium/src/test/java/cucumber/examples/java/websockets/SharedDriver.java) wrapper rather than calling WebDriver directly.

### Embedding Screenshots

See the [Report Attachments / Screenshots](/docs/reference#screenshots).

### Example Projects

* [java-webbit-websockets-selenium](https://github.com/cucumber/cucumber-jvm/tree/master/examples/java-webbit-websockets-selenium)
