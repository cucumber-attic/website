---
layout:   post
author:   aslak
title:    "Announcing Cucumber Expressions"
date:     2017-07-26 20:00:00
nav:      blog
---

Today I want to share with you a very interesting new feature we've been working on in the past year. Cucumber Expressions!

Last year about 15 Cucumber contributors spent a weekend together in a big house in Copenhagen. Some of use started designing a new expression language. We wanted to replace Regular Expressions with something more user-friendly, but also more powerful.

Cucumber Expressions were born. It's a simple expression language for matching text (just like Regular Expressions), but the syntax is optimised for legibility rather than flexibility and control. In the context of Cucumber this tradeoff makes a lot of sense. We don't need all the power of Regular Expressions, and legibility is more important.

Regular Expressions use capture groups to extract pieces of text, and Cucumber Expressions use *output parameters* to do the same thing. An output parameter is simply a name between curly braces, for example:

```ruby
Given "{flight} on {time} had {int} passengers" do |flight, time, passenger_count|
end
```

This Cucumber Expression matches the following text (from a Given step in a Gherkin document):

```gherkin
Given LHR-OSL on 22 June 2017 at 13:40 had 48 passengers
```

The first time this is matched, the user will see an error saying:

    The parameter type "flight" is not defined.

So we define a *parameter type* for *flight*:

```ruby
ParameterType(
  name: 'flight',
  regexp: /([A-Z]{3})-([A-Z]{3})/,
  transformer: -> (from, to) { Flight.new(from, to) }
)
```

We also define the `time` parameter type. When we match now, the step definition will be passed three arguments: A `Flight` object, a `Time` object and an integer (Cucumber Expressions have built-in support for `int`, `float`, `string` and `word`). Cucumber Expressions has transformed the matches for us, using our own supplied parameter types.

This is similar to Cucumber's old Transform feature, but with some significant improvements.

With Cucumber Expressions, the type name is explicit and visible in the expression itself. Furthermore, snippets for undefined steps take advantage of registered parameter types. If you have an undefined step with a piece of text that looks like a flight, Cucumber will suggest that you use `{flight}` in the step definition snippet. You'll be constantly reminded to use existing parameter types or encouraged to define new ones that are specific to your domain. This helps the team evolve a more consistent domain language. After all, Cucumber is about [communication](/blog/2014/03/03/the-worlds-most-misunderstood-collaboration-tool).

Regular Expression support isn't going away. In fact, it 's been improved. If you use a regular expression with a capture group for integer - `(\d+)` - the captured string will be transformed to an integer before it's passed to the step definition. This is possible because of the built-in `{int}` parameter type.

Cucumber will no longer suggest Regular Expressions in snippets - that's going to be Cucumber Expressions from now on.

Cucumber.js has had Cucumber Expressions for a few months already, and we've really enjoyed using them ourselves in Cucumber Pro. Cucumber-Ruby 3.0.0.pre.2 was released today, and it has Cucumber Expressions built-in as well. The Cucumber Expressions library has been implemented in Java, but Cucumber-JVM hasn't been updated to use it yet. Please do get in touch if you want to help us make that happen. The source code for Cucumber Expressions is [here](https://github.com/cucumber/cucumber/tree/master/cucumber-expressions).

Try them out and let us know how you get on and how we can improve them!
