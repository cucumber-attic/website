---
layout: post
nav: blog
date: "2015-08-07 12:00:00"
title: Introducing Example Mapping
author: matt
---

Before you pull a user story into development, you need to have a [conversation
to clarify and
confirm](<http://ronjeffries.com/xprog/articles/expcardconversationconfirmation/>)
the acceptance criteria. So many agile teams struggle with this conversation:
it’s unstructured, takes too long, it gets boring, and so they don’t do it
regularly or consistently, or at all. This post outlines a simple, low-tech
method I've discovered for making the conversation short and powerfully
productive. With this one weird trick.

I call it [Example Mapping](<https://twitter.com/search?q=%23ExampleMapping>).

The conversation itself has many names: for some people it happens during their
[backlog grooming](<http://scrummethodology.com/scrum-backlog-grooming/>) or
[planning poker](<https://www.mountaingoatsoftware.com/agile/planning-poker>)
sessions. Many teams have a specific [three
amgios](<http://www.velocitypartners.net/blog/2014/02/11/the-3-amigos-in-agile-teams/>)
meeting, or [specification
workshop](<http://gojko.net/2008/11/12/specification-workshops-an-agile-way-to-get-better-requirements/>).
I prefer Dan North’s term, [discovery
workshop](<http://dannorth.net/2010/08/30/introducing-deliberate-discovery/>),
which explicitly calls out its main purpose: to discover all the stuff you
didn’t know you didn’t know.

Anyway.

Example Mapping is a tool you can use in any of these forums to give structure
to this important conversation and efficiently capture its outputs.

I've been facilitating discovery workshops since I first started using BDD back
in 2008 at [Songkick]. Since then, I've [gone on to
teach](<http://cucumber.io/training>) hundreds of people about these practices,
yet for a long time my skill at running a discovery workshop was at the
*unconcious competence* stage: I knew how to do it, but I couldn't seem to
explain it very effectively to anyone else.

A couple of years ago I stumbled across this technique, and have been teaching
it to people ever since. It seems popular and useful, so I want to share it with
you.

What is Example Mapping?
------------------------

Concrete examples are a tremenous way to help us explore the problem domain, and
they make a great basis for our acceptance tests. But as we discuss these
examples, there are other things coming out in the conversation that deserve to
be captured too:

-   *rules* that summarise a bunch of examples, or express other agreed
    constraints about the scope of the story

-   *questions* about scenarios where nobody in the conversations knows what the
    right outcome is

-   new *user stories* we discovered or sliced out of scope

In example mapping, we use a pack of 4-coloured index cards to capture these
different artifacts during the conversation.

**TODO: picture of 4 x cards with example, rule, question, story written on
them.**

We start by writing the **story** under discussion on a **yellow** card and
placing it at the top of the table.

TODO: picture

Next, we write each of the acceptance criteria, or **rules** that we already
know on a **blue** card and placing those across the table beneath the yellow
story card.

TODO: picture

For each rule, we may need one or more **examples** to illustrate it. We write
those on a **green** card and place them under the relevant rule.

TODO: picture

As we discuss these examples, we may uncover **questions** that nobody in the
room can answer. We capture those on a **red** card and move on with the
conversation.

TODO: picture

And so, as the conversation flows, we quickly build up a visual representation
on the table in front of us that reflects back our current understanding of the
story.

TODO: picture

A table covered in red, question, cards tells us that we still have a lot to
learn about this story.

TODO: picture

A table covered in blue, rule, cards tells us that this story is big and
complicated. Perhaps we can slice it?

TODO: picture

A rule with many examples might be over-complex. Are there multiple rules at
play that need to be teased apart?

TODO: picture

You’ll find that some rules are so obvious you don’t need examples at all. It’s
clear from the conversation that everyone understands the rule, and you can move
on without forcing yourselves to grind out Given / When / Then like
BDD-brainwashed automatons.

TODO: picture

And that’s it. I told you it was simple! A small group of 3-4 amigos should be
able to map out a well-understood, well-sized story in under half an hour. If
you can’t, either you’re still getting the hang of this, the story is too big,
or it still has too much uncertainty in it. Listen to that, and either try and
slice the story, or let the product person go off and do some homework before
you re-map the story at a later date.

What do we mean by example?
---------------------------

May teams assume that the three amigos should write acceptance tests (e.g.
Cucumber scenarios) *during* this session, sitting around a projector while
someone types formal gherkin scenarios into an IDE. There are occasions when
this is valuable, but generally I think it’s a bad idea. It wastes people's
time, and can actually be distracting from the true purpose of this
conversation.

It’s easy to see why people make this mistake: the apparent purpose is to take a
user story, which already has some pre-defined *acceptance criteria*, and come
up with *examples* that can be turned into *acceptance tests*.

TODO: drawing

I think the true purpose, however, is to reach a *shared understanding* of what
it will take for the story to be done. You can move much more quickly towards
this goal by staying low-tech.

Instead, just try to capture a list of *rough examples*, using the *friends
episode* naming convention:

-   The one where the customer forgot his receipt

-   The one where the product is damaged

-   The one where the product was bought 15 days ago

**TODO: put these on cards**

Sometimes, when uncertainty lurks, you’ll instinctively want to be more concrete
than this. You still don't need to resort to the rigid structure of *Given When
Then*:

-   Product was bought at 12:00 on the 1st May

-   Customer returns the item at 1pm on the 15th May

-   =\> Refund can be processed

**TODO: put this on a card**

When the outcome (Then) is unclear, you don’t have an example, you have a
question. *What should happen if the customer forgot his receipt? Good
question!*

Why capturing questions is awesome
----------------------------------

Many people tell me that just this one aspect of example mapping has transformed
their discovery workshops from dull ramble-athons into snappy productive
mind-melds.

Whenever a conversation is going round in circles, it’s because you don’t have
enough information. Probabably someone is missing fromt the conversation, but
maybe you need to do some user research, or a spike.

Instead of letting everyone share their *opinion* about what they think the
outcome should be, simply capture the question and move on. Congratulations!
You’ve just turned an *unknown unknown *into a *known unknown*. That’s great
progress.

Who should come to an Example Mapping session?
----------------------------------------------

….

While you’re learning this technique, it can help to have someone in the formal
role of facilitator, whose job it is to make sure everything that’s being said
is being captured on a card. Examples and questions fly around the room quickly,
and it takes discipline to capture them on the table so you can see what you’re
talking about.

How often should I run Example Mapping sessions?
------------------------------------------------

When to write Gherkin during the session
----------------------------------------

My team is distributed and we can't use cards. What do we do?
-------------------------------------------------------------

How Example Mapping Fits into Your Process
------------------------------------------

At Songkick, I would sit down around a table with the Product Owner, UX
Designer, and perhaps one of the other developers, and we'd talk through
different examples of what the software might do once the story was implemented.
I'd take notes by using index cards to represent each example we came up with,
laying them out in front of us on the table. Some of the cards would end up
being torn up as we realised they were beyond the scope of that story, and the
rest I would take away and write up as Gherkin.
