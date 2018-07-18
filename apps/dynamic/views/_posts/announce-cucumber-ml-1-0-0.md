---
layout: post
nav: blog
date: "2018-07-17 11:58:00"
title: "Announcing Cucumber.ml 1.0.0"
author: cyocum
---

Today I would like to announce the 1.0.0 release of
[Cucumber.ml](https://github.com/cucumber/cucumber.ml), which brings
Behaviour Driven Development to the [OCaml programming
language](http://www.ocaml.org/).  Before I start though, I would like
to thank [Thegaram](https://github.com/Thegaram) for his contributions
and feedback to this.

OCaml
=====

For those of you who are not familiar with the OCaml language, it is a
multi-paradigm,
[strongly](https://en.wikipedia.org/wiki/Strong_and_weak_typing),
[structural](https://en.wikipedia.org/wiki/Structural_type_system) and,
[inferred](https://en.wikipedia.org/wiki/Type_inference) typed
language of the [ML family of
languages](https://en.wikipedia.org/wiki/ML_(programming_language))
which is generally used for its functional properties and strong
module system.  Companies which use it include Facebook, who created
the [ReasonML language](https://reasonml.github.io/), which is a thin
wrapper around OCaml, and [Jane Street
Capital](https://www.janestreet.com/), who use it for market making in
the financial markets.  I would highly recommend having a look.

Why?
====

While many of OCaml's language features tend to reduce the need for
testing in general, I still feel that communicating between
stakeholders and programmers is important and Cucumber is well-placed
to help in that.  Additionally, I felt that this was a good way for me
to contribute to the OCaml ecosystem in a positive way.

Installing
==========

There are a few complications when working with Cucumber.ml.  The
first and the most important is that Cucumber.ml delegates its Gherkin
parsing to the
[gherkin-c](https://github.com/cucumber/cucumber/tree/master/gherkin/c)
implementation using OCaml's foreign function interface.  This means
that, before you can use Cucumber.ml, you will need to compile and
install the gherkin-c as a shared library on your system.  On Linux,
this means you will need to install libgherkin.so in `/usr/lib` and copy
the gherkin-c header files into `/usr/include/gherkin`.

Cucumber.ml uses the [Dune build
system](https://github.com/ocaml/dune) for OCaml.  You will need to
have this installed before you can build Cucumber.ml.  Unfortunately,
I have not yet added Cucumber.ml to the [Opam package
manager](https://opam.ocaml.org/).  If anyone would like to help me do
that, I would be very grateful.

Once you have checked out the code and have the above prerequisites
installed, all you need to do is:

```
dune build && dune install
```

which will install the cucumber package into your local Opam
repository.  From there you can write your step definitions in OCaml
and run your feature files against them.  For more information on how
to use Cucumber.ml, please see the Cucumber.ml
[README](https://github.com/cucumber/cucumber.ml/blob/v1.0.0/README.md)
file on the repository.

One of the more unusual aspects of Cucumber.ml is that it assumes that
once you start executing your step definitions that it will control
the command line arguments.  This can be surprising so please be aware
of it.  Basically, the executable created by the compilation process
is the cucumber runner and it is that executable which will run your
step definitions.

Features
========

There are many features that come with Cucumber.ml.

* Gherkin 5.0 is supported (Feature, Background, Given, When, Then, etc.)
* Datatable transforms (the user can define transformations for
  datatables but this is not done automatically and must be applied by
  the user)
* Before and After steps
* State passing is handled by the runner and is passed to Step
  definitions automatically

The state passing feature is, I believe, a first for a Cucumber
implementation.

Roadmap
========

Cucumber.ml will work today and please let me know if you would like
any more features.  However, here are a few things that I (and anyone
else) will be working on.

* Update to Gherkin 6.0 using
  [gherkin-go](https://github.com/cucumber/cucumber/issues/425)
* [Lwt](https://ocsigen.org/lwt/manual/) cooperative threading
* Bring Cucumber.ml fully within the Opam package manager

My main focus will be the first thing on the list so I am looking
forward to moving to the gherkin-go universal runner.

I hope you enjoy using it as much as I have had making it. If you have
any questions, you can ask on the Cucumber Slack or you can drop an
issue on the Github issue tracker.
