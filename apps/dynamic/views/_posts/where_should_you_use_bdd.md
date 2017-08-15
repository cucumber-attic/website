---
layout: post
author: thomas
title:  Where should you use Behaviour-Driven Development?
date:   2016-07-20 00:00:00
nav: blog
---
*September 18th-19th 2017, Stockholm: Join Thomas Sundberg for our flagship two-day [BDD Kickstart training](https://cucumber.io/events/bdd-kickstart-stockholm-17). This course has been taught to hundreds of teams who have implemented BDD and Cucumber successfully.*

When I was at the <a href="http://europeantestingconference.eu/">European Testing Conference</a> 2016 in Bucharest, 
a colleague asked for my thoughts on how they should use Behaviour-Driven Development (BDD). I had to run off and didn't get a chance to elaborate on my view, so I decided that I should write it down instead. 

My first thought was pretty simple. As long they were talking, and using BDD as a framework for understanding each other, they were on the right track. They were already specifying
what the application should do by 
writing <a href="https://github.com/cucumber/cucumber/wiki/Gherkin">Gherkin</a> to capture the conversations. 

But writing Gherkin is not the most important part here; it's about creating a common understanding. 

The real question my colleague wanted to answer was which parts of the system should they implement automation using BDD and which parts they should use unit tests to verify basic correctness. 
My default answer <b><i>"Everywhere!"</i></b> obviously wasn't not good enough. It's especially poor advice 
for someone currently learning and building experience using BDD. 

Better advice would describe why BDD should be used in more places than just testing an application through the user interface. 

Let me start with a reasoning around the agile testing pyramid. I'll quickly define what I mean.

<figure>
  <img src="/images/blog/testing-pyramid.png">
  <figcaption>The agile testing pyramid<figcaption>
</figure>

The agile testing pyramid tries to show you the number of tests that are appropriate at different levels. That is, 
the proportion between end-to-end, integrated and unit tests you want to aim for. There are no numbers 
defined. Instead, relate to the width of the pyramid. 

Aim for less end-to-end tests and integration tests and more unit tests. 

##What is an end-to-end test?

An end-to-end test checks your entire application. It uses the same user interface as 
the users and verifies that something actually works, this includes saving things in the database. 

Some people think this is the only realistic way to test an application. But in fact, most of the verification can be done using other seams of your application. 

End-to-end tests are typically 
<ul>
    <li>slow - they take seconds to run</li>
    <li>brittle - they often fail</li>
    <li>not scalable - it is impossible to pass through all paths in any application but the very smallest</li>
    <li>great for verifying that the most important flow through the application works</li>
</ul>

Aim for a few end-to-end tests that verify the most important parts, but don't use them for everything.

##What is an integration test?

An integration test checks a large part of your application stack. It probably doesn't go through the user inferface. 
It may use logic just below the UI to verify a wanted behaviour, for example saving data in your database. 

Integration tests are also used to verify the application can connect to applications provided by 
someone else, a database or web service for instance. 

Integration tests are typically 
<ul>
    <li>slow - they take seconds to run</li>
    <li>brittle - there are many reasons to why they fail</li>
    <li>not scalable - it is impossible to pass through all paths in any application but the smallest</li>
    <li>great for verifying that important components are properly connected</li>
</ul>

Be careful not to overdo intergration tests.
They're usually unstable and don't give enough feedback on why something broke. 

##What is a unit test?

A unit test will check small parts of your application. These are the small parts that makes up the larger 
components that you need later. It is common that a unit test checks one method. 

Unit tests are typically 
<ul>
    <li>fast - they take milliseconds to run</li>
    <li>stable - there is only one reason to why they fail</li>
    <li>scalable - it is possible to pass through all paths in any application</li>
    <li>great for verifying that implementations you later depend on actually work</li>
</ul>

Unit tests are fast and only have one reason to fail. We would therefore like to have lots of them. 

##Where should a BDD implementation be used then?

In my opinion, BDD should be used for verifying the most important parts of the application using end-to-end tests. 
That probably includes starting the application and test it with <a href="http://www.seleniumhq.org">Selenium</a> or 
similar. 

BDD should also be used to verify the wanted behaviour using integration tests. 

Importantly, the business should be able to understand these tests, so you can reduce uncertainty and build confidence in what you are building. 

Sometimes it is valuable to implement BDD with Cucumber for unit tests, but only when the business can benefit. Imagine a specific algorithm that decides to sell a stock for instance.

A unit test that is implemented using JUnit or similar should still strive for verifying the behaviour. 
They should not be aware of the actual implementation. If they are too tightly coupled to the implementation, they will become a hindrance when refactoring. That is not something you want. These unit tests will not be validated 
by a stakeholder as they are written in code, and most stakeholders don't read code. 

If they did we wouldn't need tools like Cucumber. 

##A better balanced answer

In answer to my friend, my answer would be: <b><i>"In all the places where the business has reason 
to have opinions about the behaviour."</i></b> 

This means that all parts of the agile testing pyramid can be implemented using Cucumber. You can can implement 
end-to-end tests, integration tests, and parts that could be tested using unit tests. The decision to use 
Cucumber or a unit testing framework is depending on the cooperation with the business. If they have opinions about 
the behaviour, then use Cucumber. If they are indifferent, use a unit testing framework.

There are no hard rules here. I'm trying to give you an idea about the proportions, but as I hope you understand, 
it depends. Personally, I tend to have more integration tests implemented using BDD than end-to-end tests implemented 
using BDD. The integration tests are usually faster and speed is important. Fast tests give you quicker feedback and 
that is worth a lot. 

I'd argue for testing as little as possible through the UI. Preferably nothing. Or only so much that you 
know that the system is properly wired and starts. 

##Conclusion

Cucumber is not slow. Starting a browser is slow. Starting and stopping your application is slow. This is mitigated 
the more you test at the bottom of the agile testing pyramid. Find a balance where BDD and Cucumber support you rather 
than hinder you. 

Finally, remember that Cucumber is <b><i>not a testing tool</i></b>. It is 
a <a href="https://cucumber.io/blog/2014/03/03/the-worlds-most-misunderstood-collaboration-tool">tool for capturing common understanding</a> 
on how a system should work. A tool that allows you, but doesn't require you, to automate the verification of 
the behaviour of your system if you find it useful. 

##Acknowledgements

I would like to thank Malin Ekholm and Theo England for proof reading. 

Learn how to produce beautiful living documentation and automated tests with Cucumber and Behaviour-Driven Development this September, taught by Thomas Sundberg. Join Thomas for the [BDD Kickstart training](https://cucumber.io/events/bdd-kickstart-stockholm-17) in Stockholm, September 18th-19th.*

##References

<ul>
    <li><a href="https://cucumber.io/">Cucumber</a> - A tool for simple, human collaboration</li>
    <li><a href="https://cucumber.io/blog/2014/03/03/the-worlds-most-misunderstood-collaboration-tool">The world's most misunderstood collaboration tool</a> - A blog post from Aslak Helles&oslash;y, the creator of Cucumber </li>
    <li><a href="http://www.thinkcode.se/blog/category/BDD">BDD</a> - My other posts about Behaviour-Driven Development </li>
    <li><a href="http://www.thinkcode.se/blog/category/Cucumber">Cucumber</a> - My other posts about Cucumber</li>
    <li><a href="http://www.thinkcode.se/blog/about">Thomas Sundberg</a> - The author</li>
</ul>
