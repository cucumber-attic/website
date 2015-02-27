---
title: Reference
slug: reference
renderer: Dynamic::Reference
---
# Gherkin

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```

## Scenarios

Bla bla

### Moar

Hello!

## Steps

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```

## Doc Strings

Doc Strings are handy for specifying a larger piece of text. This is inspired from
Python's [Docstring](http://www.python.org/dev/peps/pep-0257/) syntax.

The text should be offset by delimiters consisting of three double-quote marks on
lines of their own:

```gherkin
Given a blog post named "Random" with Markdown body
  """
  Some Title, Eh?
  ==============
  Here is the first paragraph of my blog post. Lorem ipsum dolor sit amet,
  consectetur adipiscing elit.
  """
```

In your [Step Definition](#step-definitions), there’s no need to find this text and match it in your pattern. It will automatically be passed as the last parameter in the step definition.

Indentation of the opening `"""` is unimportant, although common practice is two
spaces in from the enclosing step. The indentation inside the triple quotes,
however, _is_ significant. Each line of the Doc String will be de-indented according
to the opening `"""`. Indentation beyond the column of the opening `"""` will
therefore be preserved.

## Data Tables

Data Tables are handy for specifying a larger piece of data:

```gherkin
Given the following users exist:
  | name   | email               | twitter        |
  | Aslak  | aslak@cucumber.pro  | aslak_hellesoy |
  | Julien | julien@cucumber.pro | jbpros         |
  | Matt   | matt@cucumber.pro   | mattwynne      |
```

Just like Doc Strings, they will be passed to the Step Definition as the last argument.
The type of this argument will be `DataTable` - see the API docs.

## Background

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```

## Tags

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```

# Cucumber API

Bla bla bla

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

## Hooks

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```

### Tagged Hooks

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```

# Command line

This is some ruby code:

```ruby
def hello
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
  puts "您好"
end
```
