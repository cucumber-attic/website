---
layout: post
author: matt
title:  "Introducing Example Mapping"
date:   2015-08-07 12:00:00
nav: blog
---

Before you start work on a user story, it's vital to have a conversation to clarify and confirm the acceptance criteria. This post outlines a simple, low-tech way I've discovered for facilitating that conversation. I call it [Example Mapping](https://twitter.com/search?q=#ExampleMapping).

Although I wasn't aware of it at the time, I've been facilitating discovery workshops since I first started using Cucumber at [Songkick](http://songkick.com) back in 2008. Since then, I've gone on to teach hundreds of people about how to practice BDD, but for a long time my understanding of how to run a discovery workshop was at the _unconcious competence_ stage: I knew how to do it, but I couldn't seem to explain it effectively to anyone else.

A couple of years ago, while teaching a class in St. Louis, Missouri, I stumbled across this technique, and have been teaching it to people ever since. It seems popular and useful, so I want to share it with you.

## What is an Example Mapping session?

A popular pattern for running discovery workshops is to invite the _three amigos_ - the product owner, a tester and a developer - to have a conversation about the user story. By having this conversation _before you start development_, you're able to catch a lot of potential misunderstandings and assumptions early, and iron them out before anybody's written any code.

Ostensibly, the purpose of this meeting is to take a user story, which already has some pre-defined _acceptance criteria_, and come up with _examples_ that can be turned into _acceptance tests_.

TODO: drawing

May teams make the mistake of assuming that the three amigos should write acceptance tests (i.e. Cucumber scenarios) during this session, sitting around a projector while someone types out scenarios into an IDE. I think there are occasions when this is valuable, but generally it's a waste of people's time. You can move much more quickly by keeping things low-tech.

Instead, just try to capture a list of _rough examples_, using the _friends episode_ naming convention:

  * The one where the customer forgot his receipt
  * The one where the product is damaged
  * The one where the product was bought 15 days ago

Sometimes you may need to be more concrete than this, but you still don't need to resort to the rigid structure of given when then:

  * Product was bought at 12:00 on the 1st May
  * Customer returns the item at 1pm on the 15th May
  * => Refund can be processed

## Who should come to an Example Mapping session?

## How often should I run Example Mapping sessions?

## When to write Gherkin during the session

## My team is distributed and we can't use cards. What do we do?

## How Example Mapping Fits into Your Process

At Songkick, I would sit down around a table with the Product Owner, UX Designer, and perhaps one of the other developers, and we'd talk through different examples of what the software might do once the story was implemented. I'd take notes by using index cards to represent each example we came up with, laying them out in front of us on the table. Some of the cards would end up being torn up as we realised they were beyond the scope of that story, and the rest I would take away and write up as Gherkin.
