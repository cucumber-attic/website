---
layout: post
author: aslak
title:  "Polymorphic Step Definitions"
date:   2015-07-08 01:00:00
nav: blog
---
<script type="text/javascript" src="//s3.amazonaws.com/downloads.mailchimp.com/js/signup-forms/popup/embed.js" data-dojo-config="usePlainJson: true, isDebug: false"></script><script type="text/javascript">require(["mojo/signup-forms/Loader"], function(L) { L.start({"baseUrl":"mc.us3.list-manage.com","uuid":"45b545ab379403b3a62708443","lid":"e3650a477a"}) })</script>

If you’re using Cucumber for Java you have to define your step definitions inside
a class. Keeping all step definitions in a single class quickly becomes impractical,
so you use many classes. Now you have a new problem - wiring the instances of those
classes together.

<img src="{{ site.url }}/images/blog/object-graph.png" class="image-responsive">

This is why Cucumber supports several [Dependency Injection](http://www.martinfowler.com/articles/injection.html)
(DI) containers - it simply tells a DI container to instantiate your step definition classes
and wire them up correctly.

One of the supported DI containers is [PicoContainer](http://picocontainer.com/). It’s a tiny library I wrote
together with Paul Hammant in 2003-2004. It’s not widely used (except perhaps for being
the centrepiece of IntelliJ IDEA’s plugin architecture), but in all modesty it is
pretty awesome, because it's so little and simple:

* PicoContainer doesn’t require any configuration
* PicoContainer doesn't require your classes to use any APIs such as the horrible `@Inject` - just use constructors
* PicoContainer really only has a single feature - it instantiates objects

Simply hand it some classes and it will instantiate each one, correctly wired together via their constructors. That’s it.
Cucumber scans your classes with step definitions in them, passes them to PicoContainer,
then asks it to create new instances for every scenario.

Here is an example:

```java
public class SomeStepDefs {
    public SomeStepDefs(AutomationApi api) {
    }
}
```

```java
public class SomeOtherStepDefs {
    public SomeOtherStepDefs(AutomationApi api) {
    }
}
```

Before PicoContainer can instantiate these classes it will create an instance of `AutomationApi`, and
then pass the same instance to both constructors. Simple!

Cucumber power users who understand the benefits of the
[test pyramid](http://martinfowler.com/bliki/TestPyramid.html) will prefer to
run most scenarios against the middle layer (without going through a UI). Then they'll pick
a small subset of the same scenarios to run through the UI and run those separately.

If you keep all the automation logic behind an `AutomationApi` interface you can provide
two different implementations - one that talks directly to the domain model, and another
one that uses Selenium WebDriver or another UI automation library.

PicoContainer is capable of dealing with constructor parameters that are interfaces, but
prior to version 1.2.3, Cucumber-JVM wasn't able to take advantage of this. All constructor parameters
had to be concrete classes.

As of version 1.2.3 you now have full control over how step definitions are created.
Simply tell Cucumber to use your own custom implementation of the `cucumber.api.java.ObjectFactory`
interface, which is the façade for all the DI containers.

For example:

```java
package my.features;

import cucumber.runtime.java.picocontainer.PicoFactory;

/**
 * Extension of the standard PicoContainer ObjectFactory
 * which will register the proper AutomatioApi implementation
 * based on a system property.
 */
public class CustomPicoFactory extends PicoFactory {
    public CustomPicoFactory() {
        if("web".equals(System.getProperty("my.app.testDepth"))) {
            addClass(WebAutomationApi.class);
        } else {
            addClass(DomainAutomationApi.class);
        }
    }
}
```

You tell Cucumber to use this object factory by defining the
`cucumber.api.java.ObjectFactory` system property. The easiest way to do this is
to create a `cucumber.properties` file on your classpath.
If you're using Maven, this should be `src/test/resources/cucumber.properties`.

Add the following line:

```
cucumber.api.java.ObjectFactory = my.features.CustomPicoFactory
```

Now, when you run Cucumber, PicoContainer will pass an instance of `DomainAutomationApi`
to `SomeStepDefs` and `SomeOtherStepDefs` by default. If you want to run with your
special Web automation implementation, simply run with `-Dmy.app.testDepth=web`
and it will pass an instance of your `WebAutomationApi` class instead.

We’re covering this technique in more depth in the season finale of
[Cucumber School](https://cucumber.io/school),
which should be out before the end of this month.
