---
layout:   post
author:   matt
title:    "Five roles in a healthy mob"
date:     2017-09-18 00:00:00
nav:      blog
---

# Five roles in a healthy mob

The Cucumber Pro product team has been practicing mobbing for almost two years now. We’ve had periods where we drifted back to working in pairs, but for the last nine months mobbing has explicitly been our default behaviour as a team.

I think we’ve learned a lot from that, and I want to share some patterns I’ve noticed. As you read these thoughts, you should be aware that our mob is almost exclusively remote. We do meet up about once a month, but we tend to spend that time around a whiteboard rather than a keyboard.

Most of the literature I’ve read about mobbing describes two roles: driver and navigator. I’m going to describe how I see these roles, and add a few more I’ve noticed us use when things are working well.

Let’s start with those two familiar ones.

## The navigator

The navigator understands where the group have decided to aim for, and has a plan for how to get there. In a healthy mob, the rest of the group will trust them in that role, and save any questions or challenges for a later moment.

It’s important that the navigator is able to communicate intent to the driver, rather than treating them like Siri and just dictating the code. The driver and navigator need to work together to bring this understanding into the open, and this communication dynamic between driver and navigator is important for maintaining energy levels.

## The driver

The driver is the conduit, the lighting-rod for everyone’s ideas. They help to tease out the ideas from the navigator’s head, and move the codebase forward. It helps if the driver doesn’t think too hard, and mostly works on implementing the next move agreed with the navigator.

## The facilitator

While the driver and navigator focus on solving the problem at hand, the facilitator can observe and manage the group’s dynamic and rhythm. When the tests are passing, this is the person who remembers to ask everyone: "Are we happy with the code as it is? Can anyone suggest a refactoring at this point?"

This is also the person who remembers to hold the team to any rules or agreements they’ve made. For example, asking someone who’s noticed a minor syntax improvement to hold that thought and wait until the tests are passing.

They can also monitor the group for kindness and respect. Sometimes the problems we face as a mob, especially when diagnosing a problem nobody understands, can cause anxiety. Under these circumstances, the facilitator’s role is to notice this and guide the group back to a kind and respectful dynamic.

On our remote mob, the facilitator can also play a great role in live-Slacking (or whatever is your instal-message tool of choice) the intent, activity and decisions of the mob. By communicating like this, other team members who join the mob later can more easily pick up the context, or even offer suggestions or advice from afar, without interrupting the flow.

## The scout

Mobs work best when they know what to do, and are creatively, synergistically generating solutions for how to do it.

When the mob gets stuck, it’s often due to a lack of information. We can’t decide whether to go one route or the other, because we haven’t tried either of them yet and don’t know enough about the implications of that choice.

Sometimes we see a fork in the road and, although what’s down the fork looks attractive, we don’t have confidence about how long it will take us to go that route. So we stick to the routes we know. This might be a missed opportunity.

The scout is someone who loves to explore. They look at the territory ahead and anticipate challenges and puzzles the mob might face soon, and go off and gather information: they read documentation, they write spikes, they talk to customers, they draw wireframes.

Scouting can be done by someone who’s present in the mob, but has used [the law of two feet](https://en.wikipedia.org/wiki/Open_Space_Technology#Law_of_two_feet) to make the best use of their time. Or, they check out of the mob for a time and explicitly go and focus on that task. Or, they scout in solo time. Scouts are the pioneers in Simon Stewart’s [pioneers and settlers model](http://blog.rocketpoweredjetpants.com/2014/10/pioneers-and-settlers.html).

Scouting is work people can sometimes feel guilty about, but it’s vital for keeping the mob flowing.

## The Housekeeper

One of our practices is to note down TODOs in our code during a mobbing session where we know something needs refactoring, but we want to stay focussed on getting to green first. We don’t always get time to come back to these TODOs during that session.

The Housekeeper is a bit like the Scout, in that they spend time working around the mob, keeping the flow going by tidying up these little bits of detritus flung out of the mob’s productive core. While the scout looks ahead and breaks down new territory, the housekeeper focusses on making the existing code more habitable, easier to navigate and use.

Housekeepers watch the mob and notice places where the code is impeding the flow. They think about solutions to that and suggest or make refactorings to ease these friction points. Housekeepers are the settlers in Simon Stewart’s [pioneers and settlers model](http://blog.rocketpoweredjetpants.com/2014/10/pioneers-and-settlers.html).

----

Of course it’s important that the mob pays attention to housekeeping, and doesn’t just act like a spoilt teenager leaving mess for someone else to tidy up. Yet this is true of all of these roles: from time to time each of us will wear these hats.

By acknowledging these roles explicitly I think we can play to people’s strengths and celebrate how our individuality can best contribute to the overall effectiveness and flow of the mob.

What do you think of these roles? Did I miss any?

