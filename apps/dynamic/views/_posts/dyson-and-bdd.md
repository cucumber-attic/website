---
layout:   post
author:   theo
title:    "Dyson Digital and BDD"
date:     2018-05-04 01:00:00
nav:      blog
---

<img src="https://cucumber.io/images/events/cukenfest-unconference.jpg" style="float:center; width:100%">


### Dyson digital and BDD: one team’s path to building the right thing

*This is a guest post from Tom Hall, a Digital Quality Lead at Dyson Digital.*


When Dyson’s digital team decided to bring Behaviour-Driven Development into our ways of working, it was to address two problems that were severely hampering our ability to deliver working software: 

* Misunderstood requirements 
* The amount of time it took to manually regression test every release

Our first step was to get the experts in to give the team an introduction to BDD. The Cucumber team delivered an excellent three day BDD Kickstart training course, teaching the whole team the collaborative practices used in BDD, and then getting the technical team (developers and testers) hands-on using SpecFlow to write requirements as Gherkin scenarios and write code to implement the scenarios as automated tests. 

We viewed it as vitally important that all those involved in our adoption of BDD were there together as a group, to gain a shared understanding of what it is and the benefits it can bring.

We now have a suite of modular tests, rather than the lengthy end-to-end tests we previously ran manually, which saves us tens of man-hours for every release and has greatly reduced the length of our test cycles.

At the same time as automating our regression testing, we started using a BDD approach for new features for our ecommerce websites. At first this proved difficult to work in to our pipeline, until we also started using an agile development approach, which enabled us to consistently express requirements as user stories and build example mapping in to our backlog refinement. 

We made a commitment that all user stories would be “example mapped” at the start of a sprint and the product owner would be included in those discussions. Through collaborating as a team on the detail of what each story and its acceptance criteria mean, mapping out the permutations of each rule and raising any doubts, everyone in the team has a clear understanding of the story before development starts. 

By including successful unit testing and acceptance testing in the definition of done, we have built automated feedback loops within the continuous integration process, which inform us very quickly if a change has broken the build. 

The strongest testaments of the value BDD has brought are the quality of the developed product and the satisfaction of the product owner. Following launch a couple of weeks ago, no changes to the application have been requested by the product owner and they have spoken of how delighted they are with what has been developed. How often does that happen with a new IT system? 

BDD has enabled the team to validate with the product owner that we understand the full meaning of requirements, while demos of each feature within sprints has ensured we are building the right solution. Consistently using this approach throughout product development gave the team and the product owner confidence at the point of launch, without the need for a lengthy User Acceptance Test phase, that we had built the right thing and it was working as expected. 

Now that the Award application is live we are in a position, with comprehensive automated testing coverage built in, to release new features to production more frequently than has ever been possible at Dyson. 


*Cucumber run on-site and public classes for teams who want to truly benefit from BDD. Here are a few upcoming BDD Kickstart classes in 2018. For a full list, visit our [events page.](https://cucumber.io/events)*

 - [Stockholm](https://cucumber.io/events/bdd-kickstart-stockholm-18) - May 7th-8th
 - [Perth, AU](https://cucumber.io/events/bdd-kickstart-perth-2018) - May 24th-25th
 - [Chicago](https://cucumber.io/events/bdd-kickstart-chicago-2018) - June 7th-8th
 - [London](https://cucumber.io/events/bdd-kickstart-london-18) - Late June
 - [San Francisco](https://cucumber.io/events/bdd-kickstart-san-francisco-18) - August 14th-15th
