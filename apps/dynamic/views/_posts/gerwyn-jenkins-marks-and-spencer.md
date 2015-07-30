---
layout:   post
author:   theo
title:    "BDD at Marks and Spencer"
date:     2015-07-31 09:00:00
nav:      blog
---

*A couple months ago Matt Wynne sat down for a chat with Gerwyn Jenkins, Delivery Lead for the Automation team at Marks and Spencer. M&S have recently begun transitioning to Behaviour-Driven Development (BDD) and the impact is starting to show. In this interview Matt asks Gerwyn about this shift and what benefits BDD has brought.*

<img src="https://cucumber.io/images/blog/Gerwyn-300.jpg" style="float:right; width:50%">

**Matt:** What's your role at Marks and Spencer?

**Gerwyn**: I'm the Delivery Lead for the Automation Team. The team was setup last year when I was brought into this role alongside Obi Duru as Product Owner, who joined from another company where they had been doing BDD. My role was to help drive adoption of BDD with the product teams which had yet to change their ways of working.

**Matt**: So you've seen this from day one, really. What were things like before you started trying to adopt BDD?

**Gerwyn**: The teams were agile, but it wasn't as efficient as it could be. Everyone had their role, you were a developer or you were a tester, therefore the scrum process wasn't very efficient. Testing was always being left to the end and the developers were just passing code on to the testers. Part of the challenge we had initially was also long development and release cycles. In fact, it was a 7-8 week cycle from idea to release - which was just too long. And all the test automation - using [QuickTest Professional](https://en.wikipedia.org/wiki/HP_QuickTest_Professional) (QTP) – was at the end of the cycle. So we were lucky if we completed the automated tests before going live. Maybe in the late stages they might get some automation tests, but no doubt as soon as these were running the next development features were coming along.

We’ve now started to adopt a “testing first” principle. Our teams are starting to think how are we going to automate this first, and how do we apply BDD principles to the story. We've seen an increase in adoption of 'three amigo' sessions which are helping communication and collaboration.

**Matt**: So how did you get started? What was the first thing that you did?

**Gerwyn**: Initially we established a core team and brought in expertise with a framework to help quickly automate some priority stories. We did ‘Show and Tells’ of automation on iPads or emulators to demonstrate the power of just what the automation could do. From that then, we started to do a number of presentations, where we talked through what is BDD, what our approach is to it, what the benefits would be of it, and “it's coming to you soon”, basically.

Following the initial overviews we regrouped as a core team and worked for a couple of months to automate the Sanity (shakedown) tests. We took our QTP tests and transferred them over into Cucumber JVM tests, and then got them running cross-browser. These were published on the dashboard and we made the dashboard visible and showed the teams what the test results were doing. Most importantly, we were showing that the team did not need to spend days manually testing a new release we could have this running daily without any manual dependencies. That started to get people's interest in it a bit more.

Once we'd built the sanity tests and we were running them, we increased the visibility of the results by utilising large screens around the office and showing the stakeholders the results of the daily automated tests. 

We felt that we had learnt a lot of lessons about the website and were ready to engage with the product teams. We seeded an onshore and an offshore resource into the team and said, these guys are going to start working on your priority regression scripts; don't look at what you've done in the past. Start from which journeys are most important to the customer.

We picked the top scenario, and ran a three amigo session, where we got each attendee to write a feature file, which we reviewed together so everyone understood there was no magic in a feature file.

> We were showing that the team did not need to spend days manually testing a new release we could have this running daily without any manual dependencies. 

As soon as we had one scenario we got it onto a dashboard – so then they start to see, “oh right, I can see now, this is running these tests daily and I know when something's broken”.

As the teams worked through the priority regression tests the product owner could see the benefit of the collaboration and how the automation would help increase their code quality, they became an enthusiast of BDD as well, and would do show and tell to their peers, which was great as this was coming from another person on another team whom were saying “look, we've got this running and we've got it running daily”, and it’s helping us to identify issues early.

Once the team were on board and started to adopt BDD for new functionality, we looked to seed the next team and begin the same process tackling regression stories first.

Today got quite a few working hard to improve BDD adoption. We haven't got all teams covered yet, and we continue to improve our maturity as we work with new teams, but great progress has been made and new teams are coming to us asking how they adopt BDD. 

**Matt**: And so how many of those teams have flipped over now to do those 'Three Amigos' sessions as part of what they do before they start writing the software?

**Gerwyn**: All of them are doing the three amigos sessions. Where we’ve been having an interesting debate is when should they be doing the sessions. We're on a learning curve. Some teams that have been holding the sessions and then creating a Jira backlog full of INVESTed stories, but then they pick up the story and because it was three weeks ago, they have to revisit it. Our Agile Coaches and Scrum Masters are working with the teams on bringing the sessions to the last responsible moment. 

**Matt**: Tell me about what results you've seen. So this is, last June, you said, you started doing this, so you've been running with this project for nearly a year now, is that right?

**Gerwyn**: We're coming up to nearly ten months.

**Matt**: So what visible difference has there been, do you think?

**Gerwyn**: We have begun to see a “testing first” mindset being adopted. The teams are trying to drive that, and they're beginning to think about how their Definition of Done can included a repeatable regression test. With the three amigos sessions, we're seeing more collaboration and this is being fed back to us by the teams, better understanding, better communication as well. 

With our new dashboard the focus has been on quality and reducing the release cycle to reduce the amount of elapsed time spent on regression. 

**Matt**: So the cycle time for releases is still long, hasn't come down much. Didn't someone say it has halved, though?

**Gerwyn**: It's come down significantly, and we are seeing a lot more stability in our releases. It’s also helping to identify other blockers which are impediments in our speed of release.

**Matt**: That's often the way with adopting BDD – it flushes out a whole load of other things that you've been, maybe not exactly been sweeping under the rug but you've been able to ignore them and you have to confront them when you get into doing test automation and tighter collaboration.

Do you reckon already, so far, is M&S actually saving money as a result of this different way of working?

**Gerwyn**: That is one of the KPIs we’re being measured on. Yes, I think we have got definite examples where we have identified defects or issues that would have gone through and there are definitely monetary savings being identified. We’ve also seen a reduction in the amount of time spent on Manual Regression Testing.

**Matt**: How about just from a productivity and efficiency point of view? Do you think you're still at the stage where it's more about investing for the future, rather than you're not at the point where you're reaping the benefits yet?

**Gerwyn**: We’re not fully reaping the benefits yet. Though recently we've decided to turn off QTP for our website regression testing.

**Matt**: Well, that's going to save you some money isn’t it?

**Gerwyn**: Yes, that's going to save us some money! And what was interesting, we weren't going to turn off QTP until July-August time, we were holding onto QTP for reassurance but the fact we turned it off earlier is testament to the growing confidence in our cucumber tests.

But big money savings, I think not yet; I think we've got another six months before we start really seeing those bigger efficiencies.


----------


*If you and your team are looking to transition to BDD, find out more about our in-house training on our website [cucumber.io/training](https://cucumber.io/training).*
