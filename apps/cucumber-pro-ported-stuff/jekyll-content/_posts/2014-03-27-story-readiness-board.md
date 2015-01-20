---
layout: post
author: matt
title:  "Visualise your Product Backlog with The Story Readiness Board"
date:   2014-03-23 12:00:00
categories: blog
---

There are lots of names for the conversations we have to prepare user stories for development. Some people hold _Three Amigos_ or _Specification Workshops_, some hold _Planning Poker_ or _Backlog Grooming_ sessions. Whatever you call this work, essentially you're trying to answer two questions:

- *What do we want to make?*
- *How will we make it?*

These two questions form a dynamic: when a clearly-defined requirement turns out to be complex to build, developers and product owners can usually negotiate to find a simpler *what* that has a more straightforward *how*. Similarly, product owners may not be able to clearly define *what* they want until they've had a chance to have it examined by the people who will think about *how* to build it.

I recently watched a team having what they called a *Sprint Planning* meeting. For this team, that meeting was their opportunity to have this conversation. As they laid out the stories for discussion--each on 5"x3" index cards--I came up with a suggestion.

Imagine two axes on the whiteboard:

![What to build vs How to build it]({{ site.url }}/images/what-to-build-how-to-build-it.png)

Now, put the stories that the business understand well to the top, and the stories that the developers have a clear idea how to build and test to the right. Note that this is not about estimating complexity or business value. This is simply about acknowledging how well we understand the problem and how to solve it.

Over time, stories will start out in the bottom-left corner, and gradually move up to the top-right as they become well understood and ready for development.

In the example above, Story B is well understood by the business, but the developers are still not sure how to build it. A [spike](http://www.extremeprogramming.org/rules/spike.html) would be a good idea for a story like this. Story C suffers from the opposite problem. The developers know how they'll implement it, but the product people can't decide on the details of what they want. [Three Amigos](http://www.velocitypartners.net/blog/2014/02/11/the-3-amigos-in-agile-teams/) or Specification workshops are a good solution here.

Doing this, we can see that it's a team effort to prepare stories - not just something for the business analyst to do in isolation. We can also see that it may take time to get a story ready. We can't tackle a batch of stories in a single meeting and expect them all to be ready by the end of that meeting. We might encounter questions that will need data, decisions or expertise from outside the room to solve.

Starting development on stories that are not well understood is a very common problem in teams that I visit. Perhaps by visualising the readiness of their stories like this, they can avoid it.

----

Want to know more about running successful Three Amigos workshops? [Learn all about BDD with Matt and Aslak at BDD Kickstart London](http://kickstartacademy.io/courses/bdd-kickstart) 29th April - 1st May 2014.
