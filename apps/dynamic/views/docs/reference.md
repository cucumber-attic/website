---
title: Reference
nav: docs
renderer: Dynamic::Reference
---
# Gherkin

Cucumber executes your `.feature` files, and those files contain executable specifications
written in a language called Gherkin.

Gherkin is plain-text English (or one of 60+ other languages) with a little extra structure.
Gherkin is designed to be easy to learn by non-programmers, yet structured enough to
allow concise description of examples to illustrate business rules in most real-world
domains.

Here is a sample Gherkin document:

```gherkin
Feature: Refund item

  Scenario: Jeff returns a faulty microwave
    Given Jeff has bought a microwave for $100
    And he has a receipt
    When he returns the microwave
    Then Jeff should be refunded $100
```

In Gherkin, each line that isn't blank has start with a Gherkin *keyword*,
followed by any text you like. The main keywords are:

* `Feature`
* `Scenario`
* `Given `, `When `, `Then ` (Steps)
* `Background`
* `Scenario Outline`
* `Examples`

There are a few extra keywords as well:

* `"""` (Doc Strings)
* `|` (Data Tables)
* `@` (Tags)
* `#` (Comments)

## Descriptions

Some parts of Gherkin documents do not have to start with a keywords.

On the lines following a `Feature`, `Scenario`, `Scenario Outline` or `Examples`
you can write anything you like, as long as it isn't a keyword.

## Feature

A `.feature` file is supposed to describe a single feature of the system, or a
particular aspect of a feature. It's just a way to provide a high-level description
of a software feature, and to group related scenarios.

A feature has three basic elements---the `Feature:` keyword, a *name* (on the same line)
and an optional (but highly recommended) *description* that can span multiple lines.

Cucumber does not care about the name or the description---the purpose is simply
to provide a place where you can document important aspects of the feature, such
as a brief explanation and a list of business rules (general acceptance criteria).

Here is an example:

```gherkin
Feature: Refund item

  Sales assistants should be able to refund customers' purchases.
  This is required by the law, and is also essential in order to
  keep customers happy.

  Rules:
  - Customer must present proof of purchase
  - Purchase must be less than 30 days ago
```

In addition to a *name* and a *description*, features contain a list of [Scenarios](#scenario)
or [Scenario Outlines](#scenario-outline), and an optional [Background](#background).

## Scenario

A scenario is a *concrete example* that *illustrates* a business rule. It consists of
a list of [steps](#steps).

You can have as many steps as you like, but we recommend you keep the number at 3-5 per scenario.
If they become longer than that they lose their expressive power as specification and documentation.

In addition to being a specification and documentasion, a scenario is also a *test*.
As a whole, your scenarios are an *executable specification* of the system.

Scenarios follow the same pattern:

* Describe an initial context
* Describe an event
* Describe an expected outcome

This is done with steps.

## Steps

A step typically starts with `Given `, `When ` or `Then `. If there are multiple `Given ` or `When `
steps underneath each other, you can use `And ` or `But `. Cucumber does not differentiate between
the keywords, but choosing the right one is important for the readability of the scenario as a whole.

### Given

`Given ` steps are used to describe the initial context of the system---the *scene* of the scenario.
It is typically something that happened in the *past*.

When Cucumber executes a `Given ` step it will configure the system to be in a well-defined state,
such as creating and configuring objects or adding data to the test database.

It's ok to have several `Given ` steps (just use `And ` or `But ` for number 2 and upwards to make it more readable).

### When

`When ` steps are used to describe an event, or an *action*. This can be a person interacting with the
system, or it can be an event triggered by another system.

It's strongly recommended you only have a single `When ` step per scenario. If you feel compelled to add more
it's usually a sign that you should split the scenario up in multiple scenarios.

### Then

`Then ` steps are used to describe an *expected* outcome, or result.

The [step definition](#step-definitons) of a `When ` step should use an *assertion* to
compare the *actual* outcome (what the system actually does) to the *expected* outcome
(what the step says the system is supposed to do).

## Background

Occasionally you'll find yourself repeating the same `Given ` steps in all of the scenarios
in a feature file. Since it is repeated in every scenario it is an indication that those steps
are not *essential* to describe the scenarios, they are *incidental details*.

You can literally move such `Given ` steps to the background by grouping them under a
`Background` section before the first scenario:

```gherkin
Background:
  Given a $100 microwave was sold on 2015-11-03
  And today is 2015-11-18
```

## Scenario Outline

When you have a complex business rule with severable variable inputs or outputs
you might end up creating several scenarios that only differ by their values.

Let's take an example from [feed planning for cattle and sheep](http://www.nutrientmanagement.org/assets/12028):

```gherkin
Scenario: feeding a small suckler cow
  Given the cow weighs 450 kg
  When we calculate the feeding requirements
  Then the energy should be 26500 MJ
  And the protein should be 215 kg  

Scenario: feeding a small suckler cow
  Given the cow weighs 500 kg
  When we calculate the feeding requirements
  Then the energy should be 29500 MJ
  And the protein should be 245 kg

# There are 2 more examples - I'm already bored
```

If there are many examples, this becomes tedious. We can simplify it with a Scenario Outline:

```gherkin
Scenario Outline: feeding a suckler cow
  Given the cow weighs <weight> kg
  When we calculate the feeding requirements
  Then the energy should be <energy> MJ
  And the protein should be <protein> kg  

  Examples:
    | weight | energy | protein |
    |    450 |  26500 |     215 |
    |    500 |  29500 |     245 |
    |    575 |  31500 |     255 |
    |    600 |  37000 |     305 |
```

This is much easier to read.

Variables in the Scenario Outline steps are marked up with `<` and `>`.

### Examples

A `Scenario Outline` section is always followed by one or more `Examples` sections, which
are a container for a table.

The table must have a header row corresponding to the variables in the Scenario
Outline steps.

Each of the rows below will create a new Scenario, filling in the variable values.

### Scenario Outlines and UI

Automating Scenario Outlines using UI automation such as Selenium WebDriver is
considered a bad practice.

The only good reason to use Scenario Outlines is to validate the implementation of
business rule that behaves differently based on several input parameters.

Validating a business rule through a UI is slow, and when there is a failure it is
difficult to pinpoint where the error is.

The automation code for Scenario Outlines should communicate directly with the business
rule implementation, going through as few layers as possible. This is fast, and
errors become easy to diagnose fix.

## Step Arguments

In some cases you might want to pass a larger chunk of text or a table of data to
a step---something that doesn't fit on a single line.

For this purpose Gherkin has [Doc Strings](#doc-strings) and [Data Tables](#data-tables).

### Doc Strings

Doc Strings are handy for specifying a larger piece of text. This is inspired from
Python's [Docstring](http://www.python.org/dev/peps/pep-0257/) syntax.

The text should be offset by delimiters consisting of three double-quote marks on
lines of their own:

```gherkin
Given a blog post named "Random" with Markdown body
  """
  Some Title, Eh?
  ===============
  Here is the first paragraph of my blog post. Lorem ipsum dolor sit amet,
  consectetur adipiscing elit.
  """
```

In your [Step Definition](#step-definitions), there’s no need to find this text
and match it in your pattern. It will automatically be passed as the last parameter
in the step definition.

Indentation of the opening `"""` is unimportant, although common practice is two
spaces in from the enclosing step. The indentation inside the triple quotes,
however, _is_ significant. Each line of the Doc String will be de-indented according
to the opening `"""`. Indentation beyond the column of the opening `"""` will
therefore be preserved.

## Data Tables

Data Tables are handy for specifying a larger piece of data:

```gherkin
Given the following users exist:
  | name   | email               | twitter         |
  | Aslak  | aslak@cucumber.pro  | @aslak_hellesoy |
  | Julien | julien@cucumber.pro | @jbpros         |
  | Matt   | matt@cucumber.pro   | @mattwynne      |
```

Just like [Doc Strings](#doc-strings), Data Tables will be passed to the
[Step Definition](#step-definitions) as the last argument.

The type of this argument will be `DataTable`. See the API docs for more details
about how to access the rows and cells.

## Tags

Tags is a way to group Scenarios. You can place as many tags above `Feature`,
`Scenario`, `Scenario Outline` or `Examples` keywords.

Tags are inherited from parent elements. For example, if you place a tag above
a `Feature`, all scenarios in that feature will get that tag.

Similarly, if you place a tag above a `Scenario Outline` or `Examples` keyword,
all scenarios derived from examples rows will inherit the tags.

You can tell Cucumber to only run scenarios with certain tags, or to exclude
scenarios with certain tags.

See [configuration](#) for more details.

Cucumber can perform different operations before and after each scenario based
on what tags are present on a scenario.

See [tagged hooks](#tagged-hooks) for more details.

## Comments

Gherkin provides lots of places to document your features and scenarios.
The preferred place is [descriptions](#descriptions). Choosing good names
is also useful.

If none of these places suit you, you can start a line with a `#` to tell Cucumber
that the remainder of the line is a comment, and shouldn't be executed.

# Cucumber API

Cucumber doesn't know how to execute your scenarios. It needs [step-definitions](#step-definitions)
to execute Gherkin steps, and optionally [hooks](#hooks) to start and stop the system
before and after each scenario.

## Step Definitions

When Cucumber executes a [Step](#steps) in a [Scenario](/#scenario) it will look for a matching _Step Definition_ to execute.

A Step Definition is a small piece of _code_ with a _pattern_ attached to it.
The pattern is used to link the step definition to all the matching [Steps](#steps),
and the _code_ is what Cucumber will execute when it sees a Gherkin Step.

To understand how Step Definitions work, consider the following Scenario:

```gherkin
Scenario: Some cukes
  Given I have 48 cukes in my belly
```

The `I have 48 cukes in my belly` part of the step (the text following the `Given` keyword) will match the Step Definition below:

[carousel]

```ruby
Given(/I have (\d+) cukes in my belly/) do |cukes|
  puts "Cukes: #{cukes}"
end
```

```java
@Given("I have (\\d+) cukes in my belly")
public void I_have_cukes_in_my_belly(int cukes) {
  System.out.format("Cukes: %n\n", cukes);
}
```

```groovy
Given(~'^I have (\\d+) cukes in my belly') { int cukes ->
  println "Cukes: " + cukes
}
```

```javascript
Given(/^I have (\d+) cukes in my belly$/, function (cukes) {
  console.log("Cukes: " + cukes);
});
```

```clojure
(Given #"^I have (\d+) cukes in my belly$" [cukes]
  (println (str "Cukes: " cukes)))
```

```cpp
GIVEN("^I have (\\d+) cukes in my belly$") {
  REGEX_PARAM(int, cukes);
  USING_CONTEXT(MyAppCtx, context);
  std::cout << "Cukes: " << cukes;
}
```

```csharp
[Given(@"^I have (\d+) cukes in my belly$")]
public void iHaveCukesInTheBelly(int cukes)
{
    Console.WriteLine(string.Format("Cukes: {0}, world!"));
}
```

```fsharp
let [<Given>] ``^I have (\d+) cukes in my belly$``(cukes:int) =
  printfn String.Format("Cukes: {0}", cukes)
```

```lua
Given("^I have (%d+) cukes in my belly$", function (cukes)
    print("Cukes: " .. cukes)
end)
```

```python
@Given('^I have (\d+) cukes in my belly$')
def i_have_cukes_in_my_belly(self, cukes):
  print "Cukes: " + cukes
```

```scala
Given("""^I have (\d+) cukes in my belly$"""){ (cukes:Int) =>
  println(s"Cukes: $cukes")
}
```

```tcl
Given {^I have (\d+) cukes in my belly$} {cukes} {
  puts "Cukes: $quantity"
}
```

[/carousel]

When Cucumber matches a Step against a pattern in a Step Definition, it passes the value of all the capture groups to the Step Definition's arguments.

Capture groups are strings (even when they match digits like `\d+`). For statically
typed languages, Cucumber will automatically transform those strings into the
appropriate type. For dynamically typed languages, no transformation happens by
default, as there is no type information.

Cucumber does not differentiate between the five step keywords `Given`, `When`, `Then`, `And` and `But`.

### Simple Arguments

TODO

### Argument Transformations

TODO

### Doc String Argument

TODO

### Data Table Argument

TODO

#### Diff comparison

TODO

#### Data Table Transformation

TODO

## Hooks

TODO

### Tagged Hooks

TODO

# Command line

TODO
