---
layout: post
author: aslak
title:  "View Cucumber Results in Cucumber Pro"
date:   2014-05-23 01:00:00
nav: blog
---

We're very excited to announce a higly anticipated feature to all of our beta testers.

RESULTS!

In [How Cucumber Pro Works]({{ site.url }}/blog/2014/04/15/how-cucumber-pro-works.html),
we outlined that Cucumber will soon be able to publish results to Cucumber Pro.

To make this happen you have to install our new Cucumber Pro plug-in to the project
where you run Cucumber from. The Cucumber Pro plug-in works as a formatter,
so you need to tell Cucumber to use it.

The Cucumber Pro plugin is designed to run with Cucumber *only* on your Continuous Integration
server, but we recommend you try it out locally first to make sure everything is working
correctly. Just make sure you have committed and pushed all your changes before you
run Cucumber with this formatter.

You will need a special token to authenticate agains Cucumber Pro. Just email us at
<a href="mailto:hello@cucumber.pro">hello@cucumber.pro</a> and tell us your GitHub
or Bitbucket user name and we'll send you the token. Later you will be able to get
this token from the webapp.

Start by defining the `CUCUMBER_PRO_TOKEN` environment variable:

    # Linux / OS X
    export CUCUMBER_PRO_TOKEN=the-token-you-got-from-us

    # Windows
    SET CUCUMBER_PRO_TOKEN=the-token-you-got-from-us

Please refer to the documentation for your Continuous Integration server for
details about how to set environment variables for your build.

If you’re using [Travis CI](travis-ci.org) you can use the `travis encrypt`
command to encrypt that security token in your `.travis.yml` file so it isn't publicly available.

If you manage to set everything up correctly and run a build you should see the
results showing up on your project summary page in Cucumber Pro.

Results publishing is currently available for Cucumber JVM and Cucumber Ruby:

## Cucumber JVM

*UPDATE 28. June 2014. Please refer to [Cucumber-JVM Formatter for Cucumber Pro](https://github.com/cucumber-ltd/cucumber-pro-jvm).*

Add the `cucumber-pro` jar to your project.
If you’re using Maven, just add this to your `pom.xml`:

```xml
<dependency>
  <groupId>info.cukes</groupId>
  <artifactId>cucumber-pro</artifactId>
  <version>1.0.6</version>
  <scope>test</scope>
</dependency>
```

You also have to upgrade all your Cucumber-JVM jars to `1.1.7`.

The easiest way to enable the formatter is to define another environment variable:

    CUCUMBER_OPTIONS="--format cucumber.pro.CucumberProFormatter"

Alternatively, you can also enable it with a Java System property:

    -Dcucumber.options="--format cucumber.pro.CucumberProFormatter"

## Cucumber Ruby

Add the `cucumber-pro` gem to your `Gemfile`:

```ruby
gem "cucumber-pro"
```

Then install it:

    bundle install

Finally, enable the formatter in the script that kicks off Cucumber, for example
in your `Rakefile`:

    --format Cucumber::Pro --out ./cucumber-pro.log

## Tell us what you think

We haven't yet started to implement the snazzy reports you all want to see.
Currently you will only see a summary of the latest build.

However, we are storing all the results - including screenshots you send us via the
`embed` method, for all your builds!

As soon as we get some more data from you we'll try to come up with some exciting
ways to display them back to you.

If you have ideas about how you think it would be useful to display historical results,
or even results for a single build, please let us know! We're happy to take napkin drawings,
Excel chart screenshots or anything you can think of.
