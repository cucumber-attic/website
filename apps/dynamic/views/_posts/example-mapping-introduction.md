---
layout: post
nav: blog
date: "2015-08-07 12:00:00"
title: Introducing Example Mapping
author: matt
---

Before you pull a user story into development, it’s crucial to have a
[conversation to clarify and
confirm](<http://ronjeffries.com/xprog/articles/expcardconversationconfirmation/>)
the acceptance criteria. Some people do this during their [backlog
grooming](<http://scrummethodology.com/scrum-backlog-grooming/>) or [planning
poker](<https://www.mountaingoatsoftware.com/agile/planning-poker>) sessions.
Many teams have a specific [three
amgios](<http://www.velocitypartners.net/blog/2014/02/11/the-3-amigos-in-agile-teams/>)
meeting, [specification
workshop](<http://gojko.net/2008/11/12/specification-workshops-an-agile-way-to-get-better-requirements/>)
or [discovery
workshop](<http://dannorth.net/2010/08/30/introducing-deliberate-discovery/>).

I’ve met so many agile teams who struggle with this conversation: it’s
unstructured, takes too long, gets boring, with the result that they don’t do it
regularly or consistently, or they just give up on it entirely.

This post outlines a simple, low-tech method I've discovered for making the
conversation short and powerfully productive.

I call it [Example Mapping](<https://twitter.com/search?q=%23ExampleMapping>).

![](<../../../static/public/images/blog/example-mapping/title.jpg>)

I've been facilitating discovery workshops since I first started using BDD back
in 2008 at [Songkick](<http://www.songkick.com/>). Since then, I've [gone on to
teach](<http://cucumber.io/training>) hundreds of people about these practices,
yet for a long time my skill at running a discovery workshop was at the
*unconcious competence* stage: I knew how to do it myself, but I struggled to
fully explain what I knew to anyone else.

A couple of years ago, during a training workshop in St. Louis, MO, I figured it
out and have been teaching it to people ever since. It seems popular and useful,
so I want to share it with you.

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

![](<../../../static/public/images/blog/example-mapping/4-cards.jpg>)

In example mapping, we use a pack of 4-coloured index cards to capture these
different artefacts while the conversation happens. As we talk, a map emerges on
the table in front of us that reflects back our current understanding of the
story.

![](<../../../static/public/images/blog/example-mapping/map.jpg>)

We start by writing the **story** under discussion on a **yellow** card and
placing it at the top of the table.

Next, we write each of the acceptance criteria, or **rules** that we already
know on a **blue** card and placing those across the table beneath the yellow
story card.

For each rule, we may need one or more **examples** to illustrate it. We write
those on a **green** card and place them under the relevant rule.

As we discuss these examples, we may uncover **questions** that nobody in the
room can answer. We capture those on a **red** card and move on with the
conversation.

And so, as the conversation flows, we quickly build up a visual representation
on the table in front of us that reflects back our current understanding of the
story:

-   A table covered in red, question, cards tells us that we still have a lot to
    learn about this story.

-   A table covered in blue, rule, cards tells us that this story is big and
    complicated. Perhaps we can slice it? Take another yellow card and stick the
    sliced story on the backlog.

-   A rule with many examples might be over-complex. Are there multiple rules at
    play that need to be teased apart?

You’ll find that some rules are so obvious you don’t need examples at all. It’s
clear from the conversation that everyone understands the rule, and you can move
on without forcing yourselves to grind out Given / When / Then like
BDD-brainwashed automatons.

And that’s it. I told you it was simple! A small group of amigos should be able
to map out a well-understood, well-sized story in **about 25 minutes**.

If you can’t, either you’re still getting the hang of this, the story is too
big, or it still has too much uncertainty in it. Listen to that, and either try
and slice the story, or let the product person go off and do some homework
before you re-map the story at a later date.

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

I think the true purpose, however, is to reach a *shared understanding* of what
it will take for the story to be done. You can move much more quickly towards
this goal by staying low-tech.

Instead, just try to capture a list of *rough examples*, using the *friends
episode* naming convention.

![](<../../../static/public/images/blog/example-mapping/friends.jpg>)

For example:

-   The one where the customer forgot his receipt

-   The one where the product is damaged

-   The one where the product was bought 15 days ago

Sometimes, when uncertainty lurks, you’ll instinctively want to be more concrete
than this. You still don't need to resort to the rigid structure of *Given When
Then*:

![](<../../../static/public/images/blog/example-mapping/no-gherkin.jpg>)

When the outcome (Then) is unclear, you don’t have an example, you have a
question.

Why capturing questions is awesome
----------------------------------

Many people tell me that just this one aspect of example mapping has transformed
their discovery workshops from dull ramble-athons into snappy productive
mind-melds.

![](<../../../static/public/images/blog/example-mapping/question.jpg>)

Whenever a conversation like this is going round in circles, it’s because you
don’t have enough information. Probabably someone is missing from the
conversation, or maybe you need to do some user research, or a
[spike](<http://www.extremeprogramming.org/rules/spike.html>).

Instead of letting everyone share their *opinion* about what they think the
outcome should be, simply capture the question and move on. Congratulations!
You’ve just turned an *unknown unknown* into a *known unknown*. That’s great
progress.

Who should come to an Example Mapping session?
----------------------------------------------

The bare minimum is your three amigos: a developer, a tester and a product
person. By all means invite your operations, user experience people or whoever
else is relevant to the story being discussed. Anyone likely to help you
discover new questions, or to turn questions into decisions during the
conversation will be useful.

While you’re learning this technique, it can help to have someone in the formal
role of facilitator, whose job it is to make sure everything that’s being said
is being captured on a card. Examples and questions fly around the room quickly,
and it takes discipline to capture them on the table so you can see what you’re
talking about.

What do I do with the cards when we’re finished?
------------------------------------------------

Here’s what we did at Songkick:

After the discussion, I’d pick up the cards, find a pair, and write up a Gherkin
feature file. I’d list out the rules at the top of the feature, along with any
other interesting stuff I’d learned during the conversation. If there were any
remaining questions, I’d list those too. I’d use each of the green examples
cards as the names of my scenarios.

Then, I might flesh out some of the scenarios with their Given / When / Then
steps. Not all of them, but the ones I was curious about, or felt there might be
some uncertainty around.

Finally, I’d copy and paste the contents of feature file into an email, and send
it round the people from the discovery workshop for feedback.

How often should I run Example Mapping sessions?
------------------------------------------------

My recommendation, based on what I’ve seen work for several teams in practice,
is to run them frequently: daily or every other day. Just pick one story and
give it 25 minutes of attention, then go back to work. Trying to do more in a
big batch will just drain your energy.

My team is distributed and we can't use cards. What do we do?
-------------------------------------------------------------

I’ve seen innovative hacks on this already: some people use bullet lists in a
shared Google doc, I’ve seen people using a spreadsheet with coloured cells to
represent the cards. The key is to keep it quick and easy to work with, so you
can focus on the conversation.

Some final tips
---------------

It’s important to clearly understand the distinction between [rules and
examples](<http://lizkeogh.com/2011/06/20/acceptance-criteria-vs-scenarios/>)
before you can make use of Example Mapping. I have a great exercise for teaching
this that I’ll share in a future post.

Remember that the whole purpose of this conversation is to **discover the stuff
you don’t already know**. So there are no stupid questions. Have some fun and
really explore the problem.

You’ll find that rules make natural fault lines for slicing your story. Try to
feel comfortable deferring as much as possible, so that you can focus on solving
the core of the problem. You can add more sophistication (and complexity) later.
