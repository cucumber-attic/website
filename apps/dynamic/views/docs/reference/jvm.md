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

Cucumber-JVM consists of several modules (jars) that you can download from the [public maven repo](http://repo1.maven.org/maven2/info/cukes/).
There is no "setup" program for Cucumber-JVM---just jar files.

If you like living dangerously you can also get `SNAPSHOT` builds from the [sonatype snapshot repo](https://oss.sonatype.org/content/repositories/snapshots/info/cukes/).

```xml
<repository>
  <id>sonatype-snapshots</id>
  <url>https://oss.sonatype.org/content/repositories/snapshots</url>
  <snapshots>
    <enabled>true</enabled>
  </snapshots>
</repository>
```

## Running

There are several ways to run scenarios with Cucumber-JVM:

* [JUnit Runner](#junit-runner)
* [CLI Runner](#cli-runner)
* [Android Runner](/docs/reference/android#runner)
* Third party runners

### JUnit Runner

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

To use the JUnit runner you need to add the following dependencies:

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-junit</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>

<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
</dependency>
```

### CLI Runner

The Command-Line Interface Runner (CLI Runner) is an executable Java class that
can be run from the command-line, or from any build tool such as Gradle or Ant.

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
* [Cucumber-Eclipse](https://github.com/cucumber/cucumber-eclipse)

## Java

### {java-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-java8</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

Or, if you are on Java 6 or Java 7 or (or on Java 8 but prefer to use annotated methods
for Step Definitions):

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-java</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

While it's not required, we strongly recommend you include one of the
[Dependency Injection](/docs/reference/java-di) modules as well. This allows
you to share stare between [Step Definitions](/docs/reference#step-definitions)
without resorting to static variables (a common source of flickering scenarios).

### Step Definitions

Java Step Definitions are defined in a regular class. It doesn't need to extend
or implement anything. There is a Java 8 lambda API and a Java 6/7 method API:
styles:

#### Java 8 lambdas

If you're using the `cucumber-java8` module you can define [Step Definitions](/docs/reference#step-definitions)
using lambdas:

```java
package foo;

import cucumber.api.java8.En;

public class MyStepdefs implements En {
    public MyStepdefs() {
        Given("I have (\\d+) cukes in my belly", (Integer cukes) -> {
            System.out.format("Cukes: %n\n", cukes);
        });
    }
}
```

#### Java 6/7 methods

With Java 6 and 7 you can define Step Definitions as annotated methods:

```java
package foo;

public class MyStepdefs {
    @Given("I have (\\d+) cukes in my belly")
    public void I_have_cukes_in_my_belly(int cukes) {
        System.out.format("Cukes: %n\n", cukes);
    }
}
```

#### One-dimensional lists

The simplest way to pass a `List<String>` to a step definition is to use commas:

```gherkin
Given the following animals: cow, horse, sheep
```

Simply declare the argument as a `List<String>`:

```java
@Given("the following animals: (.*)")
public void the_following_animals(List<String> animals) {
}
```

See the [@Delimiter](#) annotation for details about how to define a delimiter different than `,`.

If you prefer to use a [Data Table](/docs/reference#data-table) to define a list you can do that too:

```gherkin
Given the following animals:
  | cow   |
  | horse |
  | sheep |
```

Simply declare the argument as a `List<String>` (but do not define a capture group in the pattern):

```java
@Given("the following animals:")
public void the_following_animals(List<String> animals) {
}
```

In this case, the `DataTable` is automatically flattened to a `List<String>`
by Cucumber (using `DataTable.asList(String.class)`) before invoking the step
definition.

## Groovy

### {groovy-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-groovy</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

## Scala

### {scala-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-scala</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

## Clojure

### {clojure-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-clojure</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

## Jython

### {jython-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-jython</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

## JRuby

### {jruby-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-jruby</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

## Rhino JavaScript

### {rhino-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-rhino</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```

## Gosu

### {gosu-}Dependency

```xml
<dependency>
    <groupId>info.cukes</groupId>
    <artifactId>cucumber-gosu</artifactId>
    <version>{{ site.versions.cucumber_jvm }}</version>
    <scope>test</scope>
</dependency>
```
