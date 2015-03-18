---
layout: post
author: julien
title:  "Cucumber.js - A Piece of Warning"
date:   2015-03-17 21:27:00
categories: blog
---

Cucumber.js is getting more and more popular. This is not only a boost to my ego, but I think it's a good thing for everyone who builds JavaScript apps.

The JavaScript community is large and eclectic. Anyone doing web development needs to touch it at some point. This means people are coming from various, often more cohesive, communities.

With Cucumber entering the JavaScript arena, Behaviour-Driven Development concepts, practices, and techniques are exposed to a whole new world.

Or at least they *should* be.

Let's face it: this is not how things worked in the past. Cucumber was born in the Ruby circles and matured there, hurting many developers in the process. And plenty of those developers still remember that:

![tweet](/images/blog/clay-shentrup-tweet.png)

Ruby devs used Cucumber as a testing tool and missed its by-then-not-obvious collaboration purpose. Many of them found it painful to have this extra layer of translation, those English sentences that needed to be translated via regular expressions. Why not write plain Ruby instead?

Indeed, writing tests in plain English doesn't make much sense in itself. You're better off using Ruby, JavaScript, or whatever programming language you fancy, if all you care about is testing.

Behaviour-Driven Development is all about communication. *Improving* communication. The purpose of writing down examples (i.e. scenarios) in everyday human language is to make things clearer, reduce ambiguity, and most importantly encourage conversations between developers, testers, business experts, and anyone else involved in the project. This allows everyone to agree on the thing we are building, what is the right thing to build.

Automating those scenarios with Cucumber is a step that comes during the second phase, and it's optional (but highly recommended!). This not only ensures the right thing is being built - it also helps the developers become more confident that they're building the thing right. Among other advantages, your automated scenarios will serve as regression tests.

So here it is, my advice for you, dear Cucumber enthusiast, willing to embrace it in your JavaScript project (and really, this applies to any implementation of Cucumber):

Learn about BDD first.

Learn what it really is (no, *Given/When/Then* is **not** BDD). Learn BDD if you and the people on your team are ready to change the way you approach software development. Remember that Cucumber is only an automation tool with this weird natural language-to-programming language translation overhead that really serves some purpose, a purpose lying outside the scope of software testing.

Find out more about BDD:

* [What is BDD and why should I care?](http://blog.mattwynne.net/2013/08/21/what-is-bdd-and-why-should-i-care-video/) by Matt Wynne;
* [Behaviour-Driven Development annotated slides](http://www.slideshare.net/lunivore/behavior-driven-development-11754474) by Liz Keogh;
* [Conversational patterns in BDD](http://lizkeogh.com/2011/09/22/conversational-patterns-in-bdd/) by Liz Keogh;
* [Introducing deliberate discovery](http://dannorth.net/2010/08/30/introducing-deliberate-discovery/) by Dan North.
