---
layout:   post
author:   matt
title:    "Talking CukeUp with Nat Pryce"
date:     2017-06-12 10:00:00
nav:      blog
---

<img src="https://cucumber.io/images/blog/cukeup-people.jpg" style="float:center; width:100%">

This month sees the arrival of [CukenFest London (June 21st-25th)](http://cukenfest.cucumber.io/). I've spent some time catching up with a few people involved in the conference this year. Today I spoke to Nat Pryce. We go way back and he's spoken at few CukeUp conferences over the years. Nat's talks are always entertaining so I'm really looking forward to hearing what he has to say about running fast tests. 

Here's our conversation:

> Hi Nat! You’re obviously a world-famous TDD pioneer and [published author](http://www.growing-object-oriented-software.com/), but how did you first get into programming, and do you think it gets any easier as you get older?

I started programming on 8-bit home computers in the early 1980s: Commodore Pets in school and an Apple ][ at home. But what I really wanted was a ZX Spectrum.  I got one for Christmas in the mid '80s and had to learn to program it straight away -- the game cassettes that came with it had been demagnetised!

Does it get easier when you get older?  Some things do and some things don't.  I have much better habits now as a programmer, but the older I've got the more complicated things I've done -- the act of programming has become just one part of a much larger puzzle.
 
> Your talk is about end-to-end tests that are lightning fast, which might seem like a contradiction in terms to many people. What sort of crazy magic is this?

Spoilers!

The crazy magic is the way we designed our test scaffolding.  We can run the same test code against business logic in memory, or against the entire application running on a developer machine, or deployed into the cloud with HTTP services, caches, load balancers, routers, databases and message queues in the mix.  

<img src="https://cucumber.io/images/blog/nat-square.jpg" style="float:right; width:40%">

So we get super-fast feedback on business logic, and can verify that the user can make use of that business logic when there's a load of technical jibber-jabber between them and it.

> You’ve been a regular at CukeUp over the years. How would you describe the conference to someone who’s never been before?

I'd describe it as about much more than Cucumber.  I've learned lots of useful techniques at CukeUp, even though the projects I've been involved in have rarely involved Cucumber.  It's about the techniques, not the technology.

 
> What do you think is the secret to getting effective communication happening between business and technical people?

Direct communication between the people who have problems to solve and the people who will implement the solution, rapid delivery of new functionality into the hands of the former, and fast, blame-free feedback loops to quickly uncover and address misunderstandings and capitalise on new ideas for improvement.


**Join us at CukeUp! on June 23rd. [Book your ticket today](http://cukenfest.cucumber.io/).**
