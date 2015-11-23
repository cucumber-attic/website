---
layout: post
author: dennis
title:  "Aruba 0.10.0 released"
date:   2015-10-30 10:53:00
nav: blog
---

We are pleased to announce `aruba` version 0.10.0. For a detailed list of
changes, please have a look at our
[`History.md`](https://github.com/cucumber/aruba/blob/master/History.md) or use
the diffing feature of
[Github](https://github.com/cucumber/aruba/compare/v0.9.0...v0.10.0).

## Notable Changes

* Fix '"#exit_timeout" is deprecated' error (issue [#314](https://github.com/cucumber/aruba/pull/314))
* Add some new steps to make writing documentation easier using "cucumber",
  "rspec", "minitest" together with "aruba" - see [Feature](https://github.com/cucumber/aruba/blob/master/features/getting_started/supported_testing_frameworks.feature)
  for some examples
* Write output of commands directly to disk if SpawnProcess is used
* Refactored API of cucumber steps to reduce the need for more methods and make
  it easier for users to write their own steps (issue [#306](https://github.com/cucumber/aruba/pull/306))
* Added `aruba init` to the cli command to setup environment for aruba (issue
  [#308](https://github.com/cucumber/aruba/pull/308))
* Added new method `delete_environment_variable` to remove environment variable
* Added work around because of method name conflict between Capybara and RSpec

## Known issues

### Windows

There are still failing tests of our test suite on Windows. We're working on
that.

## Upcoming changes

### Better documentation

We're going to improve our documentation. Starting with `0.11.0` or `0.12.0`
you can expect to find our documentation on
[relish](http://www.relishapp.com/). So please stay tuned.

### Improved support for windows

Fix the windows issues

### New event based notification framework for hooks

We're going to take over some code from cucumber to make our hooks a little bit
easier and also improve the user experience of our announcers.

