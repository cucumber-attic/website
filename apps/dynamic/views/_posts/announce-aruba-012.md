---
layout: post
author: dennis
title:  "Aruba 0.12.0 released"
date:   2016-01-03 22:45
nav: blog
---

We are pleased to announce `aruba` version 0.12.0. For a detailed list of
changes, please have a look at our
[`History.md`](https://github.com/cucumber/aruba/blob/master/History.md) or use
the diffing feature of
[Github](https://github.com/cucumber/aruba/compare/v0.11.2...v0.12.0).

## Notable Changes

* Add matcher to check if a command can be found in PATH (PR #336)
* Fixed issue with environment variables set by external libraries (fix #321,
  issue #320)

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

