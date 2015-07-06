---
layout:   post
author:   hamish
title:    "What is the true value of BDD?"
date:     2015-06-18 09:00:00
nav:      blog
---



*This is a guest post by Hamish Tedeschi, Managing Director of [MagenTys] Australia(http://magentys.io/). Hamish is also a co-organiser of CukeUp! AU, coming to Sydney at the end of 2015. [Click here](https://cucumber.io/events/cukeup-australia-2015) for more details on CukeUp! AU.*
***

<img src="{{ site.url }}/images/blog/hamish.jpg" style="float:right; width:50%">

2 successful days at [YOW! West](http://west.yowconference.com.au/) have just come to a close - my first YOW! conference, but definitely not my last. I made some new friends and also learnt quite a bit - time to learn some Clojure, I think! The theme of the two days was, without doubt, microservices, but that also seemed to be surrounded by another theme of collaboration and building the right thing. This seems to be a constant recurring theme in all conferences and companies I visit. How do we build the right thing in the face of misunderstandings, miscommunications and mistakes? It is THE most difficult thing... Coding is the easy part, that is just implementation detail. Too often we get hung up on the technology stack or the tools we may be going to use to achieve the job, when it seems using post-it notes can add more value than the alternatives. Don't get me wrong, I'm a big proponent of BDD, especially when done well, as I have seen the benefits first hand. But it seems we keep getting BDD wrong, even when we talk about it at these conferences or try to deliver a project using it.



For me, BDD is a design and discovery process. A method of expressing system intent in a collaborative way. We get executable specifications out of it which we can automate, if we choose. We then call these automated tests. This is wrong. Why? 

> Because people get hung up on the value of BDD being all about the automated "tests" you get out of it. When the real value is actually the shared understanding we get at the beginning.

 The root of the problem is that these automated "tests" aren't actually tests at all. We may do some testing in the process of creating these automated tests, but once they are written, they are not "testing" anything. Testing is the process of evaluating a product by learning about it through experimentation, which includes to some degree: questioning, study, modelling, observation and inference. Once code is written, it cannot experiment, question or study anything. It just executes and does exactly what it is told, no matter what. I propose we strip out the word "testing" or "test" completely when talking about BDD, and replace it with "checking" or "check". This will go someway in reducing misconceptions about the process, the value it provides and more importantly, the value it does NOT provide. This way, we may also stop striving for exhaustive coverage when writing scenarios, thinking of these as vehicles for regression tests. It may also mean that when we think about them as a design concept, we get more contributions from BA's and UX'ers at the time of elaboration.

BDD is HARD. It is easy to NOT to write a feature together as a team. It is easy to create a feature whilst thinking of the implementation details rather than the desired behaviour. It is easier still, to build something without a failing check or not build the check at all. BDD requires discipline, however, humans tend to take shortcuts wherever possible. I still believe, with the right blend of team, we can do it though.
***

*Hamish Tedeschi will be speaking at [CukeUp! AU](https://cucumber.io/events/cukeup-australia-2015) later this year. To learn more about the conference, sign up to our [mailing list](https://cucumber.io/events/cukeup-australia-2015).*
