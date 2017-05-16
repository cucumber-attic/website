---
layout:   post
author:   theo
title:    "Introduction to TDD and BDD"
date:     2017-05-16 09:00:00
nav:      blog
---

> This is an edited transcript of Seb Rose's recent presentation at ACCU conference. You can watch the 15 minute talk [here](https://www.youtube.com/watch?v=l95DsKm5fbY). 
> 
> Seb will be at CukenFest London, a series of events for the BDD, Agile and Cucumber community happening over June 21st-25th. [Read more about events on our website](http://cukenfest.cucumber.io/).

# Introduction to TDD and BDD
There are four subsections to this talk. 

- TDD
- BDD
- Contradiction. 
- xDD

We’ll start off with an introduction to TDD. I’ll go through that quite quickly because I sense that most of you are doing that already. Then, I’ll spend a little more time on BDD and then deal with the contradictions or potential contradictions between the two, before getting – if I have enough time – slightly more for the software with XDD. 

## What is TDD?
![alt text](https://cucumber.io/images/blog/seb-accu/write-failing-test.png "Write a failing test")

This is the classic TDD cycle, popularized in Nat Pryce and Steve Freeman’s book [‘Growing Object-Oriented Software, Guided by Tests’](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627). It’s generally described as ‘write a failing test’ and then make the test pass and then refactor; you then keep going around this loop. This is the TDD cycle – it’s really simple. It’s got three little statements; it’s got coloured arrows that go between them. Within that, there’s a lot of complexity or at least a lot of nuance.

![alt text](https://cucumber.io/images/blog/seb-accu/tdd-bullet-points.png "TDD")

This is another way of thinking about it. The three sections are slightly expanded here. Typically, you see TDD described as ‘write a failing test’ and while that’s procedurally correct, it’s also rather confusing because that’s not what you’re attempting to do; the idea is not to write a failing test. What you’re trying to do is imagine what the next step you want to make is to evolve the implementation that you need to deliver value. It’s quite often rewritten as ‘writing the next specification’. Essentially, your next test is your next specification of how the software should behave and because you haven’t done that yet, it’s going to fail but you’re not there writing a failing test. 

Then, the second step, the idea is to make it pass quickly. The intention is not to design everything perfectly; it’s to get that test passing. Your collection of tests go from failing to all passing and now that all of your tests are passing, it’s safe to refactor. The intention here is not to get the best design; it’s to get them all to green quickly, because now they’re all green, you can look at them and go ‘how do I want to improve this design?’ and you can safely improve the design through the refactor phase.

The third thing is refactor. That’s usually written in blue; I don’t know why I’ve done it in green here. Then again, I don’t know why they do it in blue. The refactor loop in Nat and Steve’s [book](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627) is actually a cycle. You can draw it many other ways, but the idea is you don’t go in and refactor and you’re done; you go in, you look and see ‘what’s this change that I’d like to make’ and you make that change. You make sure the test is still green and you look at it again and say ‘is there another change that I want to do?’ or ‘has that refactoring introduced another thing that I want to do?’. This is a multi-process in itself; it’s not a single step. 

Those are the three phases of TDD. 

> One thing I just want to dwell on very briefly is the word ‘refactor’ because I talk to a lot of developers in my line of work and ‘refactor’ is often misunderstood. When you’re refactoring, you are not changing the behaviour of the code. You never refactor to add a new piece of functionality. You might refactor to get the codebase into a state where you want it to be so that you can add a new piece of functionality but refactoring, by definition, does not alter the externally observable behaviour of the code.

## What is BDD?

I showed you a nice little diagram about, I waffled on about it for 3 or 4 minutes but TDD is quite contained. 
BDD, however, is extremely uncontained; it’s sort of weird. No one is quite sure what it means. [Matt Wynne](https://twitter.com/mattwynne) who works with me in Cucumber Limited and has been working BDD for a while, has tried to distill it down and he’s come up with this sentence. 
>“BDD practitioners explore, discover, define, then drive out the desired behaviour of software using conversations, concrete examples, and automated tests.”

Even so, it’s a lot of words on the page and actually, if you squint a little bit, it goes all blurry. There are some interesting things in here but essentially, BDD is a 3-level approach.

The first is to get developers, testers and people from the business to talk to each other. That is the beginning of BDD. Anyone who thinks we’re doing BDD because we use ‘Given’, ‘When’, ‘Then’ – we may be doing BDD but the words ‘Given’, ‘When’, ‘Then’ have nothing to do with BDD. BDD stands for Behaviour-Driven Development and the real intent is to try and work out what your customer or business wants from the software before you start working on it. The first way of doing this is to actually **collaborate** with those people. 

The second thing, once we’ve got that collaboration, is to somehow **record** that in a way that is meaningful to anybody reviewing it, who might come around and look at it later, who might want to comment on it. Typically, that gets done using a ubiquitous language. People often use the ‘Given’, ‘When’, ‘Then’ words but that’s not pertinent. The idea is that we’ve collaborated and this is shared understanding. This has made sure there is a collaborative goal that we’re trying to achieve and once we’ve got good at collaborating, it’s worth trying to capture that so that not everybody needs to be in the room at the same time, so that that shared learning can be propagated. 
Finally, if it’s appropriate to our teams and to our projects, we drive out the behaviour using **automation**. 

> We collaborate, we record that collaboration in some form of specification and then we automate that specification to drive out the implementation.

### Cucumber isn't BDD

Matt and I both work for Cucumber Ltd but in his definition there is no mention of Cucumber anywhere. Cucumber is not part of BDD. Cucumber is something that has been created to help people automate in a specific way. If I go back to Nat and Steve’s [book](https://www.amazon.com/Growing-Object-Oriented-Software-Guided-Tests/dp/0321503627) they just use JUnit throughout their book to automate acceptance tests. It depends entirely on your organization – how you want to do it. 

The classic way, using Cucumber and SpecFlow and any other tool that uses a semi-structured syntax called Gherkin, to record and define those specifications, you end up with what are called feature files. 

![alt text](https://cucumber.io/images/blog/seb-accu/feature-file.png "Feature Files")

Feature files are just plain text files. They have a semi-structure, there is a syntax, the keywords are in blue. The intent is that anyone from your domain should be able to read your feature files and understand exactly what the intent is of the system – how it is supposed to behave.

The feature file looks something like this. It has a name at the top saying what feature is, it’s got some text which tells you what the behaviour or the acceptance criteria is and then, it has a number of scenarios that show how the system behaves given certain situations. The important thing here is that the examples that you might come up with when you’re collaborating get recorded as the scenarios. The acceptance criteria, which are the rules, the way the system should be behaving are captured in the text at the top and the important thing here is that user stories which a lot of Agile teams get very hung up on are just rubbish at the end of the implementation and should be bent.

## TDD and BDD: differences and contradictions

Moving on to the contradiction. We’ve talked about BDD and TDD. People often say ‘what’s the difference between them?’.

People also go on and ask ‘I’ve also heard about acceptance test-driven development. What are they all? When should I use them? Are they different?’. The reality is that you can find websites that will tell you when to use which in which environment and what systems are designed to support. [Liz Keogh](https://twitter.com/lunivore) who works with [Dan North who invented the term BDD](https://dannorth.net/introducing-bdd/) was asked this question – what’s the difference between all these things? 
>[Her answer](https://lizkeogh.com/2011/06/27/atdd-vs-bdd-and-a-potted-history-of-some-related-stuff/) is ‘they’re just called different things’. 

There is no essential difference between them. What holds them together is that they all require a group of people, specifying how the software should behave, collaboratively, before implementing it. That’s the important bit, so maybe that’s what we should boil the BDD definition down to. The idea is to work from the outside, thinking about how we want to pave, we use examples to make sure that everybody on the team understands what we’ve just agreed on – concrete examples with concrete data – and we write these examples in a ubiquitous language – a language using terms that derive from the business domain that are understood, unambiguously, by everybody on the team.

## Design your tests - xDD
The "DD" question. What is it all about? The reason it’s called ‘test-driven’ or ‘behaviour-driven’ or ‘acceptance test-driven’ is that you have to specify this behaviour *before* you do the implementation. There is no ‘we sort of do behaviour-driven’, ‘we sort of do test-driven’, ‘we write the tests in the same sprint’. You have to write them first. That’s what drives them, that’s how it becomes a design process. It’s the failing specification, it’s the fact that you see it fail, which is driving you to do the implementation. That’s what pushes the developer; that’s what the developer uses to think about what code to write.

The second D is for ‘design’ quite often. I know that it isn’t for ‘design’, it’s for ‘development’ but actually we’re designing code. When we write automation, we have to think about how is this going to be consumed, how are we going to invoke this method, how are we going to kick off this behaviour. By writing your code in response to your tests and listening to what that tells you, you get testability baked in, you get code that is testable, you understand what the contexts are. You get a vast number of benefits way beyond test coverage. 

>It’s not about test coverage.

Finally, the refactoring that you get from both BDD and TDD and having that good body of tests which really specifies how your system behaves is that you can now refactor until it feels good. People go ‘well, it would be nice if we knew when we’d refactor them’. Software is not ‘put the specs in the top, crank a handle and the right solution comes out’. 

It’s a creative activity and as much as I’m sure you all hate being thought as creatives, you are creatives. You have to have a feeling about it.

## Conclusions

BDD, TDD, ATDD, specification by example – they’re all the same. They work from the outside in, they use examples to specify how the system should behave, those examples are expressed in a ubiquitous language that the whole team understands, including the non-technical members, and then, once you’ve automated it, you get verification, which means that you can tell when your documentation is up to date, it means that you can know when a regression has crept in, it means that you can see how much of the system has been implemented by the development team. 

All of these things are good.

The relevant question when deciding whether to implement a test, a specification using JUnit or CPP Light or whatever they are, as opposed to a tool that supports natural language processing, such as Cucumber or SpecFlow or even the CPP version of Cucumber, is this:

**Who is interested in reading these tests?** 

If you want some feedback from your business about something, if it’s a piece of behaviour that is really important to your product and your business is going to say ‘no, it shouldn’t work like that’, ‘yes, it should work like this’, really consider writing those tests in a way that they can read those tests and go ‘that is what we wanted’. Cucumber, SpecFlow, tools that use Gherkin allow you to do that directly in the ubiquitous language. However, you still don’t need to use them, you can write out long sentences within the technical frame that you’re working on and that would generate that readable documentation that you can share with your business. You can do it in JUnit, you can do it in CPP Light, you can do it in all of these tools; there is no problem. 

What you do need to do is make sure that it’s expressed in a way you get the feedback from the people who are interested, the people who have got a stake, have got skin in the game.

> Seb Rose will be at CukenFest London 2017 alongside the rest of the Cucumber team. 

>[Visit our website for the line-up and more details.](http://cukenfest.cucumber.io/)
