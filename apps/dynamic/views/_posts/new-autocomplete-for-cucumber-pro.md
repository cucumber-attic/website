---
layout: post
author: aslak
title:  "Brand new Autocomplete for Cucumber Pro"
date:   2014-09-05 00:00:00
nav: blog
---
Cucumber Pro has had autocompletion for a while now. Several of our users have told us that it's a useful feature, but that it [required too much setup](https://cucumber.io/blog/2014/01/25/a-sneak-peek-at-cucumber-pro.html) and wasn't very accurate.

So we redesigned it from scratch. Now there is *no* setup whatsoever[1]. The suggestions you get when you type are much better than before.

<iframe class="wistia_embed" name="wistia_embed" src="//fast.wistia.net/embed/iframe/otyzmtbfqt?canonicalUrl=https%3A%2F%2Fcucumber.wistia.com%2Fmedias%2Fotyzmtbfqt&canonicalTitle=autocomplete%20redesigned%20-%20cucumber" allowtransparency="true" frameborder="0" scrolling="no" width="480" height="318"></iframe>

Just open a Feature file in Cucumber Pro, start typing a step and see the autocomplete show up with suggestions automatically. Use UP/DOWN keys to navigate, press ENTER/RETURN to choose a step or press ESC to dismiss the autocomplete.

Every time you save changes to your features into source control, we’ll automatically refresh the autocomplete with your latest steps.

Because the new autocomplete works with pure Gherkin, it works with all the flavours of Cucumber projects: JVM, Ruby, JavaScript, SpecFlow for C# and Behat for PHP. If you're using JBehave with Gherkin, that should even work too.

[1] If you previously set up `.cucumber/stepdefs.json` you can remove it - it's not used anymore.
