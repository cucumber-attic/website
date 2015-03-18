---
title: JavaScript
nav: docs
renderer: Dynamic::Reference
---

# Cucumber-JVM

Cucumber-JVM is a Cucumber implementation for the most popular JVM languages.

This document is the reference for features that are specific to Cucumber-JVM.

Please see the [general reference](/docs/reference) for features that are
common to all Cucumber implementations.

## Installation

There is no setup program for Cucumber-JVM - just a few jar files to download.
All jar files are available in the Central Maven repository. The
language-specific sections below describe what jars you need.

## Running

There are three main ways to run scenarios with Cucumber-JVM:

* JUnit runner
* Main class
* Third party runners

### JUnit runner

The JUnit runner uses the JUnit framework to run Cucumber. All you need is a single
empty class with an annotation:

```java
package mypackage;

import cucumber.api.junit.Cucumber;
import org.junit.runner.RunWith;

@RunWith(Cucumber.class)
public class RunCukesTest {
}
```

You can run this test in the same way you run your other JUnit tests, using
your IDE or your build tool (for example `mvn test`).

### Main class

```
java cucumber.api.cli.Main
```

This behaves similarly to the `cucumber` command from [Cucumber-Ruby](/docs/reference/ruby). Run it with `--help`
to see what the options are:

```
java cucumber.api.cli.Main --help
```

### Third party runners

IntelliJ IDEA and Eclipse have plugins that can run scenarios from within an IDE:

* [IntelliJ IDEA](https://www.jetbrains.com/idea/help/cucumber.html)
* [CucumEclipse](https://github.com/cucumber/cucumber-eclipse)

# Java

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-java</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

# Groovy

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-groovy</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

# Scala

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-scala</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

# Clojure

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-clojure</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

# Jython

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-jython</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

# Rhino JavaScript

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-rhino</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

# Gosu

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-gosu</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```
