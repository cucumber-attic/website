---
layout: post
author: dennis
title:  "Aruba 0.14.0 released"
date:   2016-03-08 22:05
nav: blog
---

We are pleased to announce `aruba` version 0.14.0. For a detailed list of
changes, please have a look at our
[`History.md`](https://github.com/cucumber/aruba/blob/master/History.md) or use
the diffing feature of
[Github](https://github.com/cucumber/aruba/compare/v0.13.0...v0.14.0)

## Notable Changes

* Add `<project_root>/exe` to search path for commands: This is the new default
  if you setup a project with bundler.
* Add some more steps to modify environment, e.g. append/prepend a string to
  environment variable

## Known issues

### Windows

There are still failing tests of our test suite on Windows. We're going to work
on that. Any help is highly appreciated.

## Upcoming changes

### Improved support for windows

Fix the windows issues.

### Improve documentation

We work on improving the documentation. With one of the upcoming versions we
plan to release a new `aruba`-website with all our documentation.

## Other stuff

### Starting work on 1.0.0 release

We're going to release 1.0.0 in the next couple of months. Before that, we want
to release our improved documentation and fixed the windows issues. If you're
interested in helping us with that, join our chat at
https://gitter.im/cucumber/aruba.

