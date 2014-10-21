# Oh Hai

bla bla

## One

```gherkin
# Doesn't get pushed to the right!
Given I have 42 cukes in my belly
```

Let's look at an example step definition:

TODO: Add some JS that will toggle them when we press the language tabs.

```ruby
Given(/I have (\d+) cukes in my belly/) do |cukes|
  # Do something with the cukes
end
```

```java
@Given("I have (\\d+) cukes in my belly")
public void I_have_cukes_in_my_belly(int cukes) {
    // Do something with the cukes
}
```

```javascript
Given(/^I have (\d+) cukes in my belly$/, function (cukes) {
    // Do something with the cukes
});
```

```csharp
[Given(@"^I have (\d+) cukes in my belly$")]
public void CukesInTheBelly(int cukes)
{
    // Do something with the cukes
}
```

## Two

Let's look at another Ruby example:

```ruby
def foo
  puts "Second"
end
```

## Three

Let's look at another Ruby example:

```ruby
def foo
  puts "Third"
end
```
