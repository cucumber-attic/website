---
layout: post
author: matt
title:  "Cucumber Ltd - the story so far"
date:   2016-05-23 00:00:00
nav: blog
---

Cucumber is an open source project, and now also a company. But what kind of a company? This post, loosely based around [a talk Steve Tooke and I recently gave at QCon London](https://www.infoq.com/presentations/distributed-teams-remote-collaboration), is about the hard work, the decisions, and the fun that have gone into trying to build a sustainable business around this popular open-source project.

<figure>
  <img src="/images/blog/gaia-ekra-swing-may-2015.jpg">
  <figcaption>Gaia plays on the swing at Aslak's summer cabin, May 2015<figcaption>
</figure>

##Our business plan

[Aslak](http://twitter.com/aslak_hellesoy), who likes spreadsheets, reckons there were around five-and-a-half million downloads of Cucumber last year, double the figure from two years before.

As Cucumber's base of open-source users grows, that means more demand for our [training and consulting](/training), and by delivering on that demand we get revenue, which then makes more time for working on the open source, which is what we love to do. Then, because we make it more awesome, it gets even more popular, and so we get this [beautiful virtuous cycle](/blog/2014/04/16/cucumber-limited).

As we spent time with our users in our consulting practice, we noticed that there was a need for something else, something a bit more polished than the open source tool. When you're trying to adopt BDD in an organisation where there's some resistance, it needs to be really user-friendly and slick, especially for the non-technical folks. We saw an opportunity for a product that might also give us a different kind of revenue.

##Cucumber Pro v1

Aslak, Julien and I started to build this product, which we called _Cucumber Pro_, in our spare time while we were traveling around the planet delivering training. At the same time we all started having young families. I had a house to renovate as well. It was exciting, but also stressful, trying to bootstrap this product on the side as well as doing all this other stuff.

Anyway, we built the first version of Cucumber Pro, and we got some people to start using it. But all the traveling for the training was taking a toll on our families. We saw this product as something that could save us from that, so we started to put pressure on ourselves: it really had to work.

If I'm honest, I think we also had an attitude that because we're all really experienced programmers, we could afford to cut some corners and just try to iterate fast on what the customers needed; telling ourselves we'd be able to refractor ourselves out of a mess later. Ever heard that one before? Yeah, it doesn't end well.

In [The E-Myth Revisited](http://www.amazon.com/E-Myth-Revisited-Small-Businesses-About/dp/0887307280) Michael Gerber talks about how most people who start their own businesses discover that they are the worst boss they ever had. It started to feel a bit like that.

So this rushing, this hunger, this almost-desperation led us to the point where we had product that just wasn't fitting. We knew there was a need there, but what we had didn't fit the need - it wasn't resonating with the users. And at the same time we had grown to hate the code. It wasn't working for anyone. So we just decided to take a step back, take a bit of a break, and focus on [some other things](/school) for a while.

##The Reboot

During the summer of 2015 the whole company and our families met at Aslak's family summer cabin on the coast of Norway. We worked together, ate together, played together and some of us stayed up far too late drinking whisky together. We talked a lot about the product, about what had gone wrong, and what we would do differently this time. Mostly, it came down to this:

> Slow down, be patient, pay attention to quality, and really listen to our users.

We resolved to reboot the product by committing the whole team for the whole month of October to it. No one was going to travel, no one was going to go and do any consulting. Focus.

After much soul-searching, we agreed to shelve the original codebase and start with a brand new codebase, on a new tech stack. We grew the team to include Steve Tooke and Romain Gerard. All this new was daunting - we had to try and figure out a way that we could work together and learn together, but still make some real progress. 

It was a really interesting time. It was a great opportunity for us to try something that we'd been hearing a bit about.

##The mob

We decided to try mob programming. In case you don't know what it is, here's [Woody](https://twitter.com/WoodyZuill) explaining:

> All the brilliant people work on the same thing, at the same time, in the same space and on the same computer.

We're all extreme programmers, that's like where we all come from. So nobody needs to convince us about the benefits of pairing. In practice however, a lot of the old codebase had ended up getting built solo, people in hotel rooms and on planes and so on. So we didn't have that shared consciousness about the code. We wanted to fix that too.

Mobbing is like turning pairing up to 11. So that all of the good stuff you get about learning from each other, about bringing the quality of the code up to the standard that everybody is happy with, all of that is massively accentuated by mobbing.

Another XP practice, collective code ownership, gets turned up to 11 as well, because everyone owns every line of code that's been written. Everyone's had a chance to have their say about every line of code that's written, so everybody's concerns about the code get shared. Everybody gets a chance to be heard, and you can resolve those issues either by helping them understand why they don't need to worry, or by actually factoring that concern in with a change.

So far, so good.

We do have a bit of a challenge with mobbing, however.

##Remote

We're a remote team. I live up in the wilds of the Scottish Highlands, Steve is in Southampton. Aslak's in London. Julian and Romain are in Wavre, just outside Brussels. It's really hard to work on the same computer in the same space at the same time.

But we've taken the decision that we want to be able to live where we want to. There's benefits that come with being able to be in your own space, being comfortable in your surroundings, being near your family. Here's Steve working with his three-month-old daughter Primrose:

<figure>
  <img src="/images/blog/primrose-first-commit.png">
  <figcaption>Primrose Tooke makes her first commit</figcaption>
</figure>

Here's Aslak with his four-month-old daughter Aurelia:

<figure>
  <img src="/images/blog/aurelia-first-commit.png">
  <figcaption>Aurelia Hellesøy joins the mob</figcaption>
</figure>

There's something really special about being in an environment where you can do that.

But, the challenges that come with being remote mean we've had to find new tools to enable mobbing to work. We use Slack for team chat, Screenhero to enable multiple people to share the same computer at the same time. Everyone gets their own pointer. When it's your turn to type at the computer, you share your desktop with everybody else. So, you work in the tools that you're comfortable with. Usually we have a second screen, either a phone or a tablet or just second monitor with a Google Hangout so we are all looking at each other, talking to each other using Google Hangouts. And that's how we code everyday.

##Resilience

Something that amazes me about the mob is how resilient it is. It just charges on, you can't stop it! On a small scale, suppose I have to take the phone call. I disappear for 15 minutes, I come back. The mob's been rolling on. They've been writing code - high quality code - the whole time. I can very easily just pick up what's going on now and start to contribute within a matter of minutes. Pretty amazing.

Equally, on the bigger scale, if I have to go away for a few days of training, maybe I'm in a different time zone, the mob carries on. We're swapping different people out each week to go and deliver the training courses, but the consciousness is still there and the code is still moving forward all the time. It's really powerful.

In my crazy moments, I imagine building a team where there were enough people living in enough timezones that the mob could just keep going 24 hours a day.

##Symbiosis

Running and growing this business is an adventure. Being a business owner and a developer at the same time is amazing. It's so good for you on both counts. Mike Feathers has [been writing recently](http://www.r7krecon.com/#!provocation/gfqa5) about the Symbiosis between code and organisation, and this is something we live and breathe every day. Most of the development team are also major shareholders in the business, so we're literally stakeholders in our own project. I wish there was a way for bigger organisations to experience this fusion of commercial and engineering perspectives.

As I polish off this post, I'm sitting in the bright sunlight on an early morning train to the XP2016 conference in Edinburgh. We're about to launch an early-adopter programme for Cucumber Pro at this conference, doing live demonstrations of Cucumber Pro for the first time, and getting feedback from both fans of Cucumber and people who've never heard of us.

I can't wait to see what they have to say!

##Play

Because we get to build our product in the way that we know works well, in the end that feels like play. Fun alone isn't an objective, but I think it's possible to find a kind of joy in almost anything, even writing a sales proposal. What we really love to do is to learn and improve ourselves - developing our [mastery](http://deliveringhappiness.com/the-motivation-trifecta-autonomy-mastery-and-purpose/). I think we develop our mastery best through play, and mobbing feels playful. If you've done pairing and worked in XP team, you'll know how playful that can feel. When you're playful, you're relaxed. When you're relaxed, you make your best decisions.

Kent Beck, at the beginning of the first XP Explained book, talks about two different cultures.

> In the mountains,
resources were scarce and people were always on the brink of
starvation. The culture they evolved was horrific. Mothers abandoned
babies to roving packs of feral children as soon as they had any
chance of survival. Violence, brutality, and betrayal were the order of
the day.
> In contrast, the forest had plenty of resources. A person had only to
spend half an hour a day providing for their basic needs. The forest
culture was the mirror image of the mountain culture. Adults shared in
raising children, who were nurtured and loved until they were quite
ready to care for themselves. If one person accidentally killed another
(deliberate crime was unknown), they were exiled, but they only had
to go a little ways into the forest, and only for a few months, and even
then the other tribespeople brought them gifts of food.
> XP is an experiment in answer to the question, "How would you
program if you had enough time?"

So maybe Cucumber Ltd is our experiment in answer to the question - _how would you run a software company if you had enough time?_
