---
layout: post
nav: blog
date: 2017-05-26 12:00:00
title: Building software with BDD. 
author: theo
---

## BDD is like jazz

One of the most famous jazz records out there is called ‘Kind of Blue’ by Miles Davis, which I'm sure you have come across. I’ll get back to why I have a jazz record to describe Behaviour-Driven Development (BDD) later. But here are the songs on the album.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/song-titles.png" style="width: 50%">

At CukeUp! London 2015 there was a panel at called [‘WTF is BDD’?](https://skillsmatter.com/skillscasts/6174-wtf-is-bdd) I didn’t go myself because I was at a different conference, but I saw the recording of the panel, and I was trying to put myself in the shoes of somebody who doesn’t know what BDD is or is just starting to learn. Having watched the whole thing, I was even more confused. It was a group of BDD luminaries and they couldn’t agree on a single thing. They certainly couldn’t come up with any concrete examples of what BDD is. 

It was all quite, in my opinion, a disappointing discussion about how it’s important not to define what BDD is. And I agree with all of that. 

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/jazz-miles-davis.png" style="width:50%">
One of the reasons I think BDD is so great is that it is a set of principles and practices that keeps evolving; we borrow from other methodologies and new people come and go and teach us new things. So I think it’s important not to nail down what it is. But that is a problem for people who are new and are just trying to learn how to do it. 

[Chris Matts](https://twitter.com/papachrismatts) said one really smart thing that I really liked from that panel. He said "BDD is like jazz" – so you can’t fully describe what it is, but you can cut a vinyl of what it is today, for this particular band or this particular group. So that’s what I’m going to do – I’m going to give you a whirlwind tour of what BDD is like for me. This is how I practice BDD now and how I [teach BDD](https://cucumber.io/training) when I go and work with organizations who are adopting BDD.

First of all, just comparing to music, BDD is not like an orchestra where you have a conductor or a project manager or maybe a product owner who tells everyone what to do. Many software projects are like that. You have this ‘conductor’ who writes down all the requirements and just sends them out to the software development team and they try to make sense out of it. That’s not how BDD works. It’s also not something that you can do alone; it’s not a solitary activity. You can’t just download Cucumber and start doing BDD. Well, I guess maybe you can, if you’re experienced with it, but if you’re new to it, certainly that is not going to get you very far. BDD is much more of a jamming, jazzy kind of thing, where you have people improvising constantly, following some rules. There are some rules in there, but it’s different and it’s new every time. There are no notes in BDD. 

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/example-mapping-w-3-amigos.png" style="width: 50%">

## The album

The first song of the album is **Discovery Workshop**, with [The Three Amigos](http://www.velocitypartners.net/blog/2014/02/11/the-3-amigos-in-agile-teams/). This is where everything starts. You’ve got a backlog of stories, some of them are done, some you are working on, but you take a story off the backlog and take it into a room. You bring along with you three Mexican hats - very important - and underneath those hats, you put a developer, a tester and somebody who represents a business – it can be a product owner or a business analyst or a domain expert, and it doesn’t have to be three. It can be four – you can have a UX person in there, you can have somebody who’s doing DevOps, but the most important is that you have representatives from business and IT.  And from IT, you have representatives from both developers and testers. 

Together, they have this meeting which only lasts like 25 minutes and this is what Matt Wynne coined [Example Mapping](https://cucumber.io/blog/2015/12/08/example-mapping-introduction). A simple way to take your user story and break it down into smaller pieces, which allows you to get more detail and discover misunderstandings. Discovering misunderstandings, I think, is one of the key principles of BDD. I don’t do BDD because I want to do BDD. BDD is just a means to an end. What I want to do is to deliver high-quality software, quickly, and do that over time, over months and years. And in order to do that, you need to get lots of feedback, really quickly, all the time, and it starts when you get feedback on your understanding. So this is where BDD starts. You can test your understanding and realise if there’s a misunderstanding between all these groups.

After 25 minutes, you come up with something that might look like this: 

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/index-cards.png" style="width: 50%">

This is a real example map that we created in our company for the product that we’re developing, [Cucumber Pro](https://cucumber.io/pro). This is for the ‘search’ feature. For this particular user story, we’ve discovered a couple of rules. One rule is that we should only index Gherkin files. The product we’re making is like a collaboration tool for Cucumber. We should only index Gherkin files; we shouldn’t index other kinds of files, like Java files and Javascript files. The search should be scoped to a project. So these are two business rules that we thought were essential in this first user’s story.
Then we came up with some questions while we were talking about this. Should we do a fuzzy match when we search or index? What about tags in Gherkin files – do we tangle them specifically? We don’t know, so we just jot them down. And then we have examples to illustrate the rules. So the green ones are examples and the blue ones are rules.

The next thing we do now is to translate this into Gherkin. Now, this is where people do this very, very differently. And this is where I come with this little intermezzo called ‘**Don’t Gherkin too soon**’. In a lot of teams they have a business analyst or the product owner write down the Gherkin, or they write down the Gherkin in the discovery workshops. *Really bad idea*. It’s a bad idea to write it down in the workshop because it’s gonna take more than 25 minutes and then everybody’s gonna get bored and you’re going to stop doing those really, really valuable meetings. So don’t write Gherkin in those meetings when you do Example Mapping. It's also a bad idea to just have somebody representing the business writing down the Gherkin, putting it in JIRA and then assigning it to a developer, because then you missed out on the whole conversation. What I recommend instead is just two of the three amigos. Definitely the developer, but if you have a tester it’s really valuable to pair. I never recommend that the business people should be involved in writing the Gherkin. They should *read* it afterwards, but you’re just gonna slow everything down and bore everyone if they’re gonna write it. If they do it alone what they tend to come up with is something that doesn’t work particularly well for executable specifications. 

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/cucumber-pro-example-map.png" style="width: 50%">

So how do we do this? So, in the above image on the right there is a feature file that results from this example map. You’ll see the user story increment ends up here in the title. And then we have the rules and the questions, which is really nothing the ‘Cucumber’ needs to execute, but it’s really useful to document it for your understanding. We can just put that in the description section in the feature file, and I’m using markdown syntax here so that you can have it nicely rendered. Each of the examples becomes a scenario. I haven’t written the "Given, When, Then" here because that’s something that we do later. You might get it down to this level in the ‘three amigos’ meeting if you really want to sit and open up a laptop, but defer the "Given, When, Then" until the developer can do that after the meeting.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/executable-specifications.png" style="width: 50%">

Take a look at section one in the above photo. So no hits from a Java file, we have a "Given, When, Then". I’d kinda like to write it backwards, so I would have written the "Then" first because this kind of reflects the outcome – start with the end in mind.  So, I expect to see zero hits. When do I expect to see zero hits? Well, if I search for something and that content is only in a file that I don’t want to get hits from. I flesh it out a little bit and this is where we get into what Konstantin Kudryashov - who is the author of Cucumber for PhP (Behat) - calls ‘**[Modelling By Example](http://stakeholderwhisperer.com/posts/2014/10/introducing-modelling-by-example)**’. Take a look at section two. We take the sentence, a file with content, and we try to write that into code. Can you see the resemblance between the plain English sentence and the code here? It’s not one to 1:1 mapping exactly, but you’ll find most of the essential pieces – there’s a file and there’s content and there’s a path. And this is written before the actual code is written. This is still test code, this is the step definition. If we run this now, depending on if you’re using a statically typed language, this won’t even compile, if you’re using a dynamically typed language, you’ll have a failing scenario. And now you have to write some code (section 3), so you write maybe a little repo class and maybe a little file class, they don’t do anything yet, but you’ve sort of pushed some classes and some methods into your system, based on what conversation you had in three amigos meeting.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/unit-tests.gif" style="width: 50%">

So, this might be easy to visualise. You have a Cucumber Scenario (Gherkin and Step Definition) on the left, that will lead you to write your first class, perhaps the repo class, then the file class, then there will be some persistence somewhere, you need to store this system; our system actually reads it out of Git database, but you know traditionally people use, some kind of relational database, or maybe a document database.  We can now run this scenario and it will exercise all this code. But we don’t go through UI or anything. 

If you go back to the class on the illustration ealier, you’ll see that they are empty, so when we flesh out the details of these? Well, that’s when I’d like to do the unit tests (see above). So as soon as I’ve discovered the outside of the system, what are the immediate methods that I need to call for my step definitions, some new methods and objects fall out of that and I fleshed that out with a unit test, using traditional [Kent Beck style TDD](https://www.amazon.com/Test-Driven-Development-Kent-Beck/dp/0321146530).

Running this starts to become a bit slow because I have to run against the database all the time and not only is it slow, it’s also difficult, because in order for me to make the tests behave consistently each time I run them, I have to make sure that every time I run a new test, whether it’s unit test or a Cucumber scenario, I need to know exactly what’s in this database; I can’t have any leftovers from a previous test I run. I certainly can’t share this database with anyone else, because they might put stuff in it when I don’t know it and then my test will fail and I won’t know why. 
 <img src="{{ site.url }}/images/blog/kind-of-green-aslak/architecture-with-stub.png" style="width:50%">
What I really want to do is instead of running it against the database, have it to talk to some kind of stub, so from the perspective of the domain logic looks exactly the same, but the implementation is just an in-memory stub implementation. 

And this is something that a lot of people are familiar with, but they don’t really know how to do it, and also they don’t whether they trust that the stub works in the same way as the real thing - "If I need to read stuff from a database, what confidence can I possibly get by testing my system against something else?" - I think that’s a mental block that people have to overcome in order to adopt this practice and use stubs. 

What we’ve come up with is a way for you to gain that confidence and we call that ‘contract tests’. 
<img src="{{ site.url }}/images/blog/kind-of-green-aslak/architecture-contract-tests.png" style="width: 50%">

Think of these two things here as something you can plug into a socket, we call this a port. The thing that sits on the other side doesn’t really need to know what’s on the other side; this green thing here only knows that it’s talking to this port here to store and retrieve stuff, but it doesn’t know what it’s actually going to do on the other side. And we can write a unit test that will talk to this port and we can run that unit test for both the real implementation and for the stub implementation. And that will give us confidence that the stub is just as good as the real thing. And as we go along, we will discover that the stub doesn’t do exactly what the real thing needs to do, but then we just add another test and we make it do that, but that just opens up a whole new universe of nice to deal with automated tests, because you can plug this thing out for most of your testing; you only plug it back in when you actually boot up the system and put it in production.

Your tests start to look a bit like this.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/ports-and-adapters-w-unit-tests.png" style="width: 50%">

The business logic sits inside something that’s completely decoupled from external devices and services. The core business logic doesn’t know *anything* about databases or message queues or web services, because we’ve isolated them through these ports.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/ui-and-web-services-2.png" style="width: 50%">

And when we want to boot up the system, we just plug in the real thing here, you can have these ports connected to adapters that go out, so this is an adapter for database, adapter for a queue, adapter for a web service. Imagine this is a port for the user interface, how the user interacts. And currently, we’ve only written a little web server here, I can display this in a browser, so you can interact with this system here, whatever it is, through this port, but you can easily imagine that somebody could write a command-line client, and use exactly the same functionality, that would just plug into the same port. And you wouldn’t have to test everything again, because you’ve already tested the business logic works; you just need to test the intersection here for this new port.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/selenium.png" style="width: 50%">

So we can switch these in and out. I’ve added some stuff at the top here. If you have Selenium and Cucumber talking to one another, and talking to a browser, going down through all your business logic hooked straight to the database, your tests are going to be slow. 

You need something that goes through the whole depth of your stack, in order to get that confidence. But if all your tests are like that, you’re in a really bad place.

You’re in a place where if something goes wrong, you can’t diagnose where the problem is because it can be anywhere. It's called diagnostic precision, something doctors talk about, being able to find out what’s wrong. You can’t do that with these sorts of tests. They’re really brittle because if you have a change up at the top, it’s gonna break all your tests. And where do you think your application changes most often? Yep. In the UI. That’s what keeps changing all the time because we need to keep up with the latest UI trends and we need to respond to customer feedback. The business logic tends to change a lot slower. That changes more in the pace of the business strategy, whatever the business is capable of doing. So, you really want to connect the tests to the part of the application that doesn’t change so frequently, so that you can have more easily maintainable tests.

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/speed-and-ui.gif" style="width: 50%">

The last thing is speed. This here, and imagine if we connected those red ones instead of the grey ones, one of those tests typically take like 5 seconds or more, right? If you test everything like this, we’re talking 2-3 orders of magnitude faster! One test can test something complicated in the business domain – can typically take like 5 milliseconds. Do you know why? Because there’s no Input/Output. All the IO tends to happen outside of these ports. There’s IO when you have a browser involved, there’s IO when you have a database involved or web service – but we’ve stripped all that stuff away. That means we can run thousands of tests in a second, or at least thousands of tests in a minute. 

<img src="{{ site.url }}/images/blog/kind-of-green-aslak/test-pyramid.png" style="float:right; width:50%">

Focus on having different kinds of tests; lots and lots of unit tests, quite a few tests that don't go through all the heavy infrastructure components, and just a few tests that go through the UI. This is called the [Test Pyramid](https://www.mountaingoatsoftware.com/blog/the-forgotten-layer-of-the-test-automation-pyramid) (see right). This is kind of like the Holy Grail. If you want to do BDD efficiently, you have to be able to decouple your business logic from all of those slow and brittle devices that sit outside of it. So, **ports and adapters**, that’s a pattern - you can also find it under hexagonal architecture – it’s a pattern with two names, it’s the same thing, and those contract tests which basically allows you to gain the confidence that plugging in the stub is just as good as using the real thing. That is the missing link to moving your tests down to these layers. And it’s only when you’ve done that, that you’re able to have lots of feedback really, really quickly.

## Concluding thoughts

Let's recap a bit. ‘**Discovery workshops**’ are great for getting feedback on your understanding. You can weed out a lot of bad assumptions before you even start developing, if you just put these people in the same room and run this structured conversation. And the ‘**three amigos**’ are the people who come to this meeting. You need people with different perspectives because people with different perspectives tend to misunderstand each other and they need to be in the same room. You can’t communicate through JIRA tickets. **Example Mapping** – that is simple a technique that we use when we’re in the ‘three amigos’ meeting to have a structured conversation around breaking user stories down. 

‘**Don’t Gherkin too soon’** that’s the only one that sounds a bit like a song, doesn’t it? It’s just a reminder that you shouldn’t fall for the temptation of writing down requirements in Gherkin, as like an analysis phase that the business people do before development. It’s something that you do after the discovery workshop. 

BAs, **don’t be the saucier.** You know in big restaurants you have the chefs, the master chefs – they don’t go and make the sauce in the kitchen. They have minions to do that and for programming, those minions should be the developers and testers, because they know the details about how to actually write that down to the low level. The BAs will come over and taste the sauce and be like ‘yup, that’s good’ – but they don’t have to make it. 

**Modelling by Example** – so as soon as you have those scenarios, you can use that to drive out code that uses the same words and concepts as what the domain experts talk about, so you avoid this translation cost, between problem domain jargon and solution domain jargon. Amazing! And also, it allows you to do BDD without having to go through the UI – you get much faster feedback using direct method call. So this means that you have to use the same Cucumber implementation, same language as the code you’re writing, because the way that they interact is through function calls and method calls. If you’re writing something in .NET, you should use SpecFlow. You can’t invoke .NET objects with Cucumber for Ruby. It’s really important.

**Under your UI** -  UI tests are the worst – they are slow, they are expensive, they are really hard to fix. 

**Ports and adapters**, that is really the enabler of how you can hook in your scenarios and unit tests at a lower level, and the contract tests finally, is what gives you the confidence to do that. 

And this is how we do BDD in my team. We don't do it this way because we want to do BDD correctly, if there was something else that allowed me to deliver high-quality software at a steady pace and also allowed people to come and maintain that software that I wrote, once that I’ve left five years from now, then I’ll ditch BDD in a second, but the goal for me is to deliver software quickly and BDD is the best way I've found to do that. 


---
This is an edited transcript of Aslak Hellesøy's talk "Kind of Green" at CukeUp! London 2016. [Watch the talk here](https://skillsmatter.com/skillscasts/7361-keynote-kind-of-green) (log-in required). 

If you want to implement BDD into your organisation to benefit from faster and more maintainable software, head to our [training page](https://cucumber.io/training) for details on how we can help.
