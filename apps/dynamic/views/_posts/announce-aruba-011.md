---
layout: post
author: dennis
title:  "Aruba 0.11.1 released"
date:   2015-11-27 12:45
nav: blog
---

We are pleased to announce `aruba` version 0.11.1. For a detailed list of
changes, please have a look at our
[`History.md`](https://github.com/cucumber/aruba/blob/master/History.md) or use
the diffing feature of
[Github](https://github.com/cucumber/aruba/compare/v0.10.0...v0.11.1).

## Notable Changes

* Refactored and improved documentation (feature tests) in PR #309
* Reorder rubies in .travis.yml
* Integrate `EventBus` to decouple announcers from starting, stopping commands
  etc. This uses nearly the same implementation like `cucumber`. (PR #309)
* Starting/Stopping a command directly (`command.start`, `command.stop`) is now
  reported to the command monitor and `last_command_stopped` is updated
  correctly
* Added `#restart` to `Command` to make it possible to restart a command
* Added check to prevent a command which has already been started, to be
  started again. Otherwise you've got hidden commands which are not stopped
  after a cucumber/rspec/minitest run.
* Adding a lot of documentation to `aruba`
* Refactored `#run`: Now it wants you to pass a `Hash` containing the options.
  The old syntax is still supported, but is deprecated.
* Added `#find_command` as experimental feature. It searches the started
  commands from last to first.
* Added `be_an_executable` matcher
* Set stop signal which should be used to stop a process after a timeout or
  used to terminate a process. This can be used to stop processes running
  docker + "systemd". If you send a systemd-enable container SIGINT it will be
  stopped.
* Added a configurable amount of time after a command was started -
  startup_wait_time. Otherwise you get problems when a process takes to long to
  startup when you run in background and want to sent it a signal.
* Replace `<variable>` in commandline, e.g. `<pid-last-command-started>`
  [experimental]
* Added announce formatter for time spans, e.g. `startup_wait_time`
* All `*Process`-classes e.g. `BasicProcess`, `SpawnProcess` etc. are marked as
  private. Users should use `#run('cmd')` and don't use the classes directly.
* `rvm`-methods are deprecated. They too ruby specific.

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

