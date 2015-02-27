---
layout: post
author: matt
title:  "Cucumber 2.0 RC 1 Released"
date:   2015-01-31
---

On Friday [Tooky](http://tooky.co.uk/) and I pushed the first released candidate for Cucumber 2.0 to RubyGems. Containing a big batch of fixes that have been
building up over the past few weeks.

We quickly did some testing of our own, found a couple of issues, and had an RC3 out by the end of the afternoon.

We're aware of [a few small issues](https://github.com/cucumber/cucumber/issues?q=is%3Aopen+is%3Aissue+milestone%3A2.0), but we believe this release should work for most people, and be almost 100% backwards compatible.

However, as we've said before, there have been huge internal changes for this release, so we need your help to test it. Please update your gemfile like so:

```ruby
gem 'cucumber', '~> 2.0.0.rc.3'
```

...and then run `bundle update cucumber` to upgrade. If you have any problems, we'll be happy to help if you raise an issue on GitHub.

If you have any time to dive in and help solve the remaining issues, that would also be great!
