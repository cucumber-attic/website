---
layout: post
nav: blog
date: 2017-09-21T09:00:00
title: "Upgrading to Cucumber-Ruby 3.0.0"
author: aslak
---

We hope to release Cucumber-Ruby 3.0.0 in the next few weeks. This major release
has some exciting new features, but also some breaking changes.

I know upgrading to a version with breaking changes can be a hassle. My goal with
this blog post is to convince you that an upgrade is worthwhile, and to make it
as easy as possible.

Let's see what's changed.

## `Transform`

Thanks for 7 or so dutiful years of service. Enjoy the retirement. Sorry, `Transform`
is no longer with Cucumber. Welcome its replacement - `ParameterType`.

On the surface, `ParameterType` is similar to `Transform` - it lets you transform
an argument from a string to another type before it's passed to the step definition.

Prior to 3.0.0 you might have defined a `Transform` for integers:

```ruby
Transform /^(-?\d+)$/ do |number|
  number.to_i
end

Then /^a user, named '([^']+)', should have (\d+) followers$/ do |name, count|
  # Without the transform your count object would be a string and not a number
  assert(count.is_a?(Numeric))
  # ...  
end
```

In 3.0.0, `int` conversion is built-in, so there is no need for that transform.

But what if we want to define our own, for a `Person` type?

Before we'd just define a `Transform`, and change the block parameter from
`name` to `person` for good measure:

```ruby
Transform /^([A-Z][a-z]+)$/ do |name|
  Person.new(name)
end

Then /^a user, named '([^']+)', should have (\d+) followers$/ do |person, count|
  assert(person.is_a?(Person))
end
```

In Cucumber-Ruby 3.0.0 we'd replace that `Transform` with the following
`ParameterType`:

```ruby
ParameterType(
  name: 'person'
  regexp: /[A-Z][a-z]+/,
  transformer: -> (name) { Person.new(name) }
end
```

We also have to make the step definition use the same regexp as the `ParameterType`.
So you'd have to change this:

```ruby
Then /^a user, named '([^']+)', should have (\d+) followers$/ do |person, count|
  assert(person.is_a?(Person))
end
```

to this:

```ruby
#                      <---------> same as parameter type's regexp
Then /^a user, named '([A-Z][a-z]+)', should have (\d+) followers$/ do |person, count|
  assert(person.is_a?(Person))
end
```

Let's recap. A `Transform` is replaced by a `ParameterType` in two steps:

1. Define a `ParameterType` with the same regexp as the `Transform`
1. Make sure all step definitions using the transform have the same regexp in the
   corresponding capture group.

## Nested capture groups

If you have regular expressions with nested capture groups, the behaviour is slightly
different. Pre-3.0.0 the number of capture groups had to be equal to the number of
block parameters:

```ruby
Given(/^I have a( trial)? subscription( with (\d+) days left)?$/) do |trial, with_days_left, days_left|
end
```

Cucumber 3.0.0 and beyond will expect only 2 parameters for the example above. It
only considers the top level capture groups to be parameters, and not the nested
ones.

So how would we get access to the `days_left` value? With a `ParameterType` of
course!

```ruby
ParameterType(
  name: 'subscription',
  regexp: /(trial )?subscription(?: with (\d+) days left)?/,
  transformer: -> (trial, days_left) { Subscription.new(!!trial, days_left.nil? ? nil : days_left.to_i) }
)
```

The neat thing is that you can have capture groups in your parameter type's
`regexp`. Each capture group is passed to the `transformer`. If you don't
have any capture groups, the entire match of the `regexp` is passed to the
`transformer`.

And now our step definition is simply:

```ruby
Given('I have a {subscription}') do |subscription|
end
```

There is a bonus feature as well. If you now write an undefined step like this:

```gherkin
When I cancel my trial subscription with 2 days left
```

Cucumber knows you're talking about a subscription, and will suggest this snippet:

```ruby
When('I cancel my {subscription}') do |subscription|
end
```

I think that is *p* *r* *e* *t* *t* *y* cool!

Sometimes your parameter types might have an overly general `regexp`. In this case
you might want to instruct Cucumber *not to* suggest it in snippets. You can do this
by setting `use_for_snippets` to `false`:

```ruby
ParameterType(
  name: 'person',
  regexp: /[\w]+/,
  transformer: -> (name) { Person.new(name) },
  use_for_snippets: false
)
```

## Regular Expressions to Cucumber Expressions

As shown above, you can keep using regular expressions and you can leave them
untouched *unless* you've been using them with transforms, or you've got nested capture groups.

Here are some tips about how to translate Regular Expressions to Cucumber Expressions:

### Anchors

The gorgeous `^` and `$` you love so much are no longer needed. Just get rid of them.

### Capture Groups

All capture groups become Cucumber Expression *output parameters*. There are
4 built-in ones to choose from:

* `(\d+)` becomes `{int}`
* Whatever funky pattern you've been using for floats becomes `{float}`
* `(\w+)` becomes `{word}` (a word without quotes)
* `"([^"]+)"` becomes `{string}` (anything between single or double quotes)

As we've seen above you can also define your own parameter types and use them as output parameters in your expressions.

### Optional text

Optional text is just a way to make our language a little more flexible.
We want to be able to say both `3 cucumbers` and `1 cucumber`, so we make the
`s` optional:

```ruby
Given(/^I have (\d+) cucumbers? in my belly$/) do |count|
end
```

In Cucumber Expressions, this becomes:

```ruby
Given('I have {int} cucumber(s) in my belly') do |count|
end
```

This use of [parenthesis](http://www.thepunctuationguide.com/parentheses.html) is
closer to how people actually write.

> The president (and his assistant) traveled by private jet

### Alternation

Just like optional text, alternation is a way to make the language more flexible.
We want to be able to say both `2 people` and `1 person`, so we use alternation:

```ruby
Given(/^there (?:was|were) (\d+) (?:person|people) at the inauguration$/) do |count|
end
```

In Cucumber Expressions, this becomes:

```ruby
Given('there was/were {int} person/people at the inauguration') do |count|
end
```

This use of a [slash](http://www.thepunctuationguide.com/parentheses.html) is
closer to how people actually write.

> Each guest must present his/her ticket prior to entry

## Closing remarks

I hope you're curious to try out the new features in Cucumber-Ruby 3.0.0, and that
this blog post will make it easier for you to upgrade.

If you need help upgrading, there are always many people ready to help in the
[support](https://cucumber.io/support) channels.
