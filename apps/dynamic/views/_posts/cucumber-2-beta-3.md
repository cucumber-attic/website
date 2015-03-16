---
layout: post
author: matt
title:  "Cucumber Ruby 2.0.0.beta.3 Released"
date:   2014-09-14 00:00:00
nav: blog
---
I've just released the third beta for Cucumber 2.0. The most significant regressions fixed are:

  * Calling `scenario.failed?` in an After hook
  * The DataTable API (`diff!` and friends)
  * Windows support

These were the only significant bugs we're aware of, so please give it a try and let us know your feedback.

Once again, please ask anyone who writes tools and plugins you use that depend on Cucumber to test out this release. We're trying hard to make 2.0 completely backwards compatible with 1.0, but we need feedback to know what we've missed.

If you'd like to help fix any of those issues, I'd also really appreciate it. Just ping @mattwynne on the GitHub ticket of your choice and I'll be glad to give you some [free BDD coaching](http://blog.mattwynne.net/2012/03/31/free-bdd-coaching/).
