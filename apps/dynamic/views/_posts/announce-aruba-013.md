---
layout: post
author: dennis
title:  "Aruba 0.13.0 released"
date:   2016-01-26 10:05
nav: blog
---

We are pleased to announce `aruba` version 0.13.0. For a detailed list of
changes, please have a look at our
[`History.md`](https://github.com/cucumber/aruba/blob/master/History.md) or use
the diffing feature of
[Github](https://github.com/cucumber/aruba/compare/v0.12.0...v0.13.0)

## Notable Changes

* Added generator and cucumber steps to create ad hoc script files (PR [#323](https://github.com/cucumber/aruba/issues/323), https://github.com/AdrieanKhisbe)
* Made it possible to announce information on command error, using a new option 
  called `activate_announcer_on_command_failure` (PR [#335](https://github.com/cucumber/aruba/pull/335), https://github.com/njam)
* Added two new hooks for rspec and cucumber to make troubleshooting feature
  files easier (PR [#338](https://github.com/cucumber/aruba/pull/338):
  * command_content: Outputs command content - helpful for scripts
  * command_filesystem_status: Outputs information like group, owner, mode,
    atime, mtime
* Added colored announcer output similar to the color of `cucumber` tags. The color of the output is "cyan".
* Re-integrated `event-bus`-library into `aruba`-core (PR [#342](https://github.com/cucumber/aruba/pull/342))
* Fixed circular require warnings (issue [#339](https://github.com/cucumber/aruba/issues/339))
* Fixed use of old instances variable "@io_wait" (issue [#341](https://github.com/cucumber/aruba/issues/341)). Now the
  default value for io_wait_timeout can be set correctly.
* Fixed bug in announcer. It announces infomation several times due to
  duplicate announce-calls. 
* Refactored internal `#simple_table`-method (internal)
* Refactored announcer: Now it supports blocks for `#announce` as well (internal)

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

