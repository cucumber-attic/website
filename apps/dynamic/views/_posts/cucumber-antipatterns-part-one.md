---
layout: post
author: theo
title:  "Cucumber anti-patterns, part one!"
date:   2016-07-01 12:00:00
nav: blog
---
## Cucumber anti-patterns ##

![Aslak and Steve helping a group at CukeUp! London 2016.](https://cucumber.io/images/blog/aslak-steve-cukeup-16.jpg)
Cucumber’s popularity may give some the impression it’s an easy tool to master. I'm sorry to be the bearer of bad news, but it's not! Thousands of experienced Cucumber users have the bumps and bruises to prove it, ourselves included. 

Not too long ago, Aslak wrote a post encouraging users focused on Cucumber’s automation benefits to turn their attention to its other great strength: enabling shared understanding. The post racked up a lot of interest in the most part because it resonated with lots of readers. Used correctly, Cucumber can be an extremely valuable tool to bridge the communication gap between business and tech teams in your organisation. 

Over two blog installments, we will outline common anti-patterns we've discovered from training and consulting teams around the world. We’ll try to unpick why these patterns can become damaging and what you can do to avoid these common pitfalls.

This is an edited version of a conversation between Steve Tooke, Aslak Hellesøy and Matt Wynne on The Cucumber Podcast which you can listen to via [iTunes](https://itunes.apple.com/gb/podcast/cucumber-podcast-rss/id1078896635).

First up...

Writing the scenario *after* you've written the code
----------------------------------------------------

Let's step back a bit. Why should you write your scenarios before? The blunt answer is: Cucumber is not a testing tool. 

OK, it *is* a testing tool, but first and foremost it is a tool to test your understanding of the problem domain. And once that test passes, which means everybody agrees on what you’ve said in your Gherkin scenario, you can then start implementing. 

Writing the scenarios before the code encourages people with different perspectives to be involved in behaviour of the software. A product owner or a business stakeholder will read it with one perspective, a developer with another one, and a tester with a third. It makes it easier for people to figure out whether they disagree about something or whether there's uncertainty. So having that very concrete description of the example before you even start developing helps you figure out if everybody has the same understanding. 

<img src="{{ site.url }}/images/blog/cukeup-laptop-crowd-cukeup-16.jpg" style="float:right; width:50%">

BAs/Product Owners creating scenarios in isolation
-------------------------------

If your BA or product owner writes all the Gherkin on their own, perhaps in a JIRA ticket, you will be missing out on the whole team’s input. 

What you end up with is Gherkin that doesn't represent everybody's common understanding, and you miss out on the opportunity to thrash out and expose all of those different misunderstandings. Scenarios written by non-technical team members very often can't be automated without being changed. And once that happens, they stop being the thing that the product owner believed in. 

They sat and wrote out those words and now the Gherkin says something different, and pretty soon it just becomes a thing that belongs to the testers or the devs because the product owner's like, "Well that's not what I said, so this is something else."

Incidental details
------------------

Rambling long scenarios with lots of incidental details can ruin a good story. Often times the scenarios are written as a test, rather than documentation, which can lead to fluffy scenarios. 

An example of this might be:

> Given I sign up as Matt,
>  And my password is password,
>   And my password confirmation is password.  
>   When I check my bank balance then my bank balance is $100

The purpose of the scenario is to check the bank balance, and it isn't really relevant what the password is. But people fall into the trap of thinking they need to fill something in on the password form, and the way they wrote the scenario was thinking about it like, "I'm scripting a test. This is what I would type in if I was doing a manual test, so I've got to put that in my Cucumber scenario”. 

The lesson here is to focus on the behaviour of the story and stay clear of incidental details which don’t contribute anything. 

Testing several rules at the same time
--------------------------------------
A related anti-pattern is testing more than one outcome. Testing multiple things can blur the essence of your scenario and lead to uncertainty and misunderstandings.

Here, the litmus test is to take a scenario, show it to someone who isn't familiar with the domain and ask if they can explain its functionality. If the scenario doesn’t describe the behaviour of the system, you can’t use this as documentation and therefore can’t collaborate effectively on its answers.

Going back to the bank example, what exactly are we trying to test here? You would have to guess right. Are we testing passwords or are we testing the bank balance? Or we're testing both?

Scenario with either a bad name or no name at all
-------------------------------------------------

A good place to sum up the essence of a scenario is in the scenario title. Using the first example it could be, “Check Balance”. But if you miss it off or if you've copied and pasted a scenario from the one below, it can obscure the meaning of the scenario. 

Try to avoid boring and non-specific titles such as “Sign Up, Log In, Visit Balance Screen, and Review Balance”. 
For our own development work, we like to use the Friends episode naming convention for thinking about the name of the scenario, where you go, "This is the one where the balance is positive," or, "This is the one where the balance is over my overdraft". And in the Given, When, Then, that's when you go on into exactly how you're going to check for that behaviour. 

There’s some useful tips about this in [Matt’s Example Mapping post.](https://cucumber.io/blog/2015/12/08/example-mapping-introduction)

Adding unvaluable scenario descriptions
---------------------------------------

Descriptions such as “As a user, I want to check my balance, so that I know what my balance is” doesn’t give you any extra information about the user. 

Instead, focus on the business rules. 

For example, one rule could be after you've made a withdrawal, the withdrawal should show up in your list of transactions, and then you could have an example to illustrate that. 

It’s best to think of the feature file as a living document so when you talk about the story or the feature, you know that there are some business rules, you've come up with some examples, but you've also identified that there's some uncertainty.

It can be really good to write those down in the front matter as well, and check that in version control. So, "This is our current understanding of this feature; we know this stuff, we've got these acceptance tests, but we also know that we don't know this other stuff”. 

As the core team behind Cucumber, we've been supporting large teams implement BDD and Cucumber in a safe and responsible manner through [in-house training and consulting](https://cucumber.io/training). If you're interested in having one of the core-team behind Cucumber visit your offices, [contact us](https://cucumber.typeform.com/to/gUEP2E?source=blog) for more details. 

Part two of this blog post will be posted next month. Or you can [listen to Cucumber Podcast on iTunes](itunes.apple.com/gb/podcast/cucumber-podcast-rss/id1078896635). 

![enter image description here](https://cucumber.io/images/blog/matt-standing-cukeup-2016.jpg)