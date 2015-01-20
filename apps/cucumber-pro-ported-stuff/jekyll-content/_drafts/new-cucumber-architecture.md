---
layout: post
author: matt
title:  "New Cucumber Architecture"
date:   2014-08-17 12:00:00
categories: blog
---

As I wrote the first lines of Cucumber on a bus down to my summer house in 2008
I had clear vision of what I wanted to build. I had some [strong](http://jbehave.org/)
[shoulders](http://rspec.info/) to stand on.

What I hadn't expected was the sudden surge of interest and numerous patches to
my originally quite simple code. A lot of stuff happened in the first 2-3 years.
I accepted a lot of patches of dubious technical quality, but of mostly high
end user benefit. On the way I included a few things that I think Cucumber would
have been better without, but I don't regret doing it. It was a learning experiment
for us all, and the end result is pretty good on the surface.

I consciously acquired technical debt because I thought it would reap benefits in
the long run.

We're a strong community now who are mostly happy with the conventions that have emerged.
There are several companies around the Cucumber ecosystem, and an increasing number
of organisations using it to great benefit.

We can afford to pay back the loan now.

I have been thinking about how to do this for a couple of years now. The rest of this
article summarises how I think we should design Cucumber's internals (for all implementations).

My motivation is twofold. First, I want to make Cucumber simpler by design, and easier
to maintain. Second, I want to make it a lot easier for people to integrate with the
Cucumber ecosystem in all sorts of ways.

This means that the way we parse gherkin and how we report results must change.

First off, the Gherkin3 library will not only scan/lex gherkin, it will also parse it and produce an AST. (This is new - until now Gherkin fires events and the AST building happens in Cucumber).

Gherkin3 will also provide a compiler, which will walk the gherkin AST and transform it to a simpler structure that can be fed to Cucumber. This means Cucumber won't have to deal with complicated things like backgrounds and scenario outlines.

The Gherkin3 compiler will expand scenario outlines and examples into regular scenarios. Background steps will be inlined into every scenario.

This structure will be passed to Cucumber in a simple form - a list of test cases, each one consisting of test case steps. Cucumber will typically link hooks into this structure, or transform it further to something that does that.

Cucumber is handed a structure which doesn't reflect the original gherkin source (but on the other hand is very easy to process). During execution, Cucumber will only report on results of the execution of test cases. The results will not include the test gherkin source - it will merely link to it.

This linking will simply be a file path and line number - and information like
status (passed, failed, pending etc), stack trace (in case of a failure), stepdef
(which has info like regexp, location etc) and attachments.

Not combining the Gherkin structure with the result structure is the big difference compared to the current design. I was never happy with the way the JSON formatter did (does) this badly. It's one of the most common sources of bugs in Cucumber. There is something fundamentally wrong with the current model. For example: Where exactly do you attach results of a failed background when it runs once for every scenario?

TODO: Example of bg and 2 sc. And the gherkin events.

The new design will still have a pretty formatter and a JSON formatter. The difference is that the pretty formatter will (in addition to colouring results) report on the *expanded* structure (i.e. backgrounds and scenario outlines are inlined). That's ok - as long as we're still linking back to the correct place in the source in stacktraces, stepdef location comments etc. The JSON formatter will only produce a list of events (small JSON objects) that indicate whether a step passed or failed on a particular line in a file.

TODO: Example

If you want to produce a report from that, you have to read both the source and the results stream and stich it togerher yourself. A little more laborious, but a lot easier to get right (on both sides of the fence). The new Gherkin3 library will be designed with reporting in mind so that 3rd party vendors can take results and create a report of the source using the Gherkin3 lib.

I know Cucumber-Ruby 2.0 has some of this done already (the AST), but we need to do the rest.

At Cucumber Ltd we have a 20% open source policy. Every Friday we spend the entire day (GMT 9-17) working on Cucumber and hanging out on IRC. Even though we are [somehow funded]() to do this, we're a small company who needs your help to make Cucumber the most awesome automation tool for BDD. So come and join us!

With a better architecture we can focus more of our time on more valuable tasks, like documentation, building great extensions etc. Who wants to build a gherkin-lint BTW?

Carry on with Cucumber-Ruby 2, but do take into consideration some of what I said here. I think some of the remaining failing features a will be removed with this design, so I don't think it should hold up a release unless you think it's really cause problems for people.

Aslak

Please let me know what you think.
