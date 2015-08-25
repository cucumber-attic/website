---
layout: post
author: dennis
title:  [ANN] Aruba 0.9.0 released
date:   2015-08-25 19:26:00
nav: blog
---

We are pleased to announce `aruba` version 0.9.0. For a detailed list of
changes, please have a look at our
[`History.md`](https://github.com/cucumber/aruba/blob/master/History.md) or use
the diffing feature of
[Github](https://github.com/cucumber/aruba/compare/v0.8.0...v0.9.0).

## Notable Changes

### Add console

Now `aruba` includes a console to play around with it's API. You can start the
console by running `aruba console` in your commandline.

### Add documentation

Starting with `0.8.0` we added more and more documentation to `aruba` - and
more is about to come. We also decided to use our very own `cucumber`-steps to
document how to use `aruba`.

### Replace all "assert_*"- and "check_*"-methods by "RSpec"-matchers

With `0.9.0` all `assert_*`- and `check_*`-methods are replaced by
"RSpec"-matchers internally and the old methods are labeled as deprecated. It's
recommended to use our new matchers.

### New "cucumber"-hooks

We added a new `@announce-output`-hook which outputs both, `STDERR` and
`STDOUT`.

### New matchers

There are new `RSpec`-matchers to check the output &ndash; `STDOUT`, `STDERR` or
both &ndash; of a command.

### Access to commands

Now you've got access to the last command started by using
`#last_command_started`. Additionally there's a `#last_command_stopped`-method
as well.

### Logging with aruba

We added a logger to our API. It's available via `#aruba.logger`.

### Report file size and disk usage

Using `#file_size` you can gather information about the size of a file. This
works more or less similar to `ls -al` on UNIX/Linux-operating systems. `#disk_usage`
reports the amount space allocated on the disk. Be aware, that the value of
both methods is different for sparse files. The `#disk_usage` is a
UNIX-/Linux-only method. The methods used internally are not implemented by
Ruby Core on Windows.


### Split Up of "unescape"-methods

We decided to split up `#unescape` into `#extract_text` and `#unescape_text`.
The first method removes all ANSI escape sequences and the latter converts
newlines and the like given as escaped strings into valid strings &ndash; '\n'
&#8594; "\n".

### Working around a Bug in JRuby

In JRuby <= 1.7.21 and 9.0.0 there's a
[bug](https://github.com/jruby/jruby/issues/3162) which cause problems when we
cleaned up the `ENV`. We added a workaround for that.

### Running commands

Now we make the process started via `SpawnProcess` the leader of the group to
kill all sub-processes more reliably.

### Changes to options handling ANSI escape sequences

Please use `aruba.config.remove_ansi_escape_sequences` or `Aruba.configure {
|config| config.remove_ansi_escape_sequences = <true|false> }` instead of
`...keep_ansi`.

## Known issues

### Windows

There are still failing tests of our test suite on Windows. We're working on
that.

## Upcoming changes

### Better documentation

We're going to improve our documentation. Starting with `0.10.0` or `0.11.0`
you can expect to find our documentation on
[relish](http://www.relishapp.com/). So please stay tuned.

### Extend "aruba" command

We're going to add some kind of initializer to the `aruba`-command. `aruba
init` can be used to create all files needed to use `aruba` within your
project.
