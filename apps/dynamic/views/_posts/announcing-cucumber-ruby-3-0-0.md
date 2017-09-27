---
layout: post
nav: blog
date: "2017-09-27 00:00:00"
title: "Announcing Cucumber-Ruby v3.0.0"
author: matt
---

After [over a year in the making](https://github.com/cucumber/cucumber-ruby/commit/f719115c2a52165711425508cccbce82d9eefa73), it's time to release Cucumber-Ruby 3.0.0.

This post will talk you through the main changes in this release, and give you a sense of where we're headed with version 4.0 and beyond. The full change log is available [here](https://github.com/cucumber/cucumber-ruby/blob/master/CHANGELOG.md).

Notable changes
---------------

#### Cucumber expressions

When I first started using Cucumber and Ruby I found regular expressions extremely intimidating. Although I've learned you only need [a handful of syntax](http://agileforall.com/just-enough-regular-expressions-for-cucumber/) to use them with Cucumber, they've always been something that's made Cucumber less friendly to newcomers. So we wanted to fix that.

With this release you can say goodbye to regular expressions. Read Aslak's [blog post](https://cucumber.io/blog/2017/07/26/announcing-cucumber-expressions) for more detail.

#### Tag expressions

Similarly, Cucumber has, for a long time, had an obtuse syntax for using tags to express which scenarios to run. That's now been replaced with a shiny new syntax that actually makes sense to most humans.

For example, this old expression:

    --tags ~@slow --tags @smoke,@this-iteration

becomes

    --tags 'not @slow and (@smoke or @this-iteration)'

You can also use this new syntax in [tagged hooks](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/writing_support_code/tagged_hooks.feature).

Got a giant hairy `cucumber.yml` file full of these things? Don't worry. Cucumber will warn you to update them but we won't be removing them until version 4.0.

#### Retry (and the new flakey status)

Sometimes, despite your best intentions, you have a scenario that you know might not pass every single time you run it.

I believe the best option with these scenarios is to bite the bullet and investigate them until you either understand the root of the problem and fix it, or remove it from your test suite for good.

Cucumber-Ruby now gives you a third way to live with flickering scenarios for a time. Using the new `--retry` flag, Cucumber will retry any scenario that fails a given number of times. Scenarios that pass on a subsequent attempt will be given a `flakey` status.

Read more in the [living documentation for this feature](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/cli/retry_failing_tests.feature).

#### Strict mode

Like a victorian dad, previous versions of Cucumber were opinionated and inflexible about what it meant to be strict. As of 3.0.0, you now have more options:

    -S, --[no-]strict                Fail if there are any strict affected results
                                     (that is undefined, pending or flaky results).
        --[no-]strict-undefined      Fail if there are any undefined results.
        --[no-]strict-pending        Fail if there are any pending results.
        --[no-]strict-flaky          Fail if there are any flaky results.

Enjoy the power.

#### Events API

For people who want to go beyond Cucumber's out-of-the-box features, we've got a [fresh API](http://www.rubydoc.info/github/cucumber/cucumber-ruby/Cucumber/Events) for you to use.

The lifecyle of compiling and running your features is now modelled as a series of events. Events are designed to be read-only, appropriate for writing formatters and other output tools. If you need to be able to influence the result of a scenario, use a hook instead.

Here's how events fire as your features are run:

1. As your `step_definitions` folder is read, Cucumber fires a [StepDefinitionRegistered](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/step_definition_registered_event.feature) event.
2. Cucumber reads a `feature` file, and emits a [GherkinSourceRead](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/gherkin_source_read_event.feature) event.
3. As your feature file is compiled into test cases, [StepActivated](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/step_activated_event.feature) events are fired as each test step is "activated" with its matching step definition block.
4. Now it has a set of compiled test cases, Cucumber fires a [TestRunStarted](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/test_run_started_event.feature) event describing what's about to be run.
5. For each test case (Gherkin Scenario or Scenario Outline Example), Cucumber fires a [TestCaseStarted](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/test_case_started_event.feature) event before any steps are run.
6. Now for each test step (including hooks) it fires a [TestStepStarted](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/test_step_started_event.feature) event
7. ...and a [TestStepFinished]() event. This contains the result and duration of that step.
8. One all the steps have run, Cucumber fires a [TestCaseFinished](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/test_case_finished_event.feature) event. This contains the overall result of running the test case.
9. Finally, once all test cases are done, Cucumber fires at [TestRunFinished](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/events/test_run_finished_event.feature) event.

Cucumber's own formatters have largely been rewritten to use this new API, though some of them do still remain using the old formatter API for now. More on that below.

Breaking changes
----------------

We've dropped support for Ruby 1.9 and 2.0.

Transforms have been removed in favour of the new [ParameterTypes](https://app.cucumber.pro/projects/cucumber-ruby/documents/branch/master/features/docs/writing_support_code/parameter_types.feature) that play nicely with Cucumber Expressions.

And we have plans to start breaking more things...

Vision for 4.0 and beyond
-------------------------

Cucumber's codebase will be [ten years old next year](https://github.com/cucumber/cucumber-ruby/commit/f3292f4023a707099d02602b2bd6c4ca3cec6820). As maintainers, we're still living with some decisions that were made years ago. We want to be more welcoming and inclusive to new contributors, and that means cleaning up the codebase to make it easy to pick up and understand.

In general, this means slimming down the codebase and simplifying it. The old formatter API will be removed in 4.0, so please if you're maintaining plugins that use that old API, re-write them to use the new events API described above. If you need something that isn't there, let us know and we'll fix it.

We'll be catching up with cucumber-js and adding support for the [new JSON events output](https://github.com/cucumber/cucumber/pull/172).

What else would you like to see us prioritise? Let us know in the comments!

Full change log
---------------

See [CHANGELOG.md](https://github.com/cucumber/cucumber-ruby/blob/master/CHANGELOG.md).
