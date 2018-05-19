---
layout: post
author: mpkorstanje
title:  "Cucumber-JVM is dropping support of JVM Languages"
date:   2018-05-19 09:00:00
nav:    blog
---
# Cucumber-JVM is dropping support of JVM Languages #

Cucumber JVM is developed by volunteers who are all donating part of their spare time. Currently the core team of 
Cucumber-JVM consists of 3-4 people. 
This makes it hard to keep up with current developments in Cucumber, such as upgrading Gherkin, adding Tag Expressions 
and Cucumber Expressions, while also evaluating issues and pull requests.

To be able to keep developing cucumber-jvm, we are looking to focus more on the languages and components that are used 
the most. 
We started looking at how Cucumber was used. We found that most people are using Java, combined with JUnit or TestNg as 
a test framework. 
About half our users don't use a DI container; the other half uses Picocontainer, Spring or Guice. For more details, 
see below.

We can also see that many languages aren't used much at all. Since the language modules are fairly complex and consume 
a large amount of time, we have decided to stop supporting them.
By decreasing our overall workload, we will be able to focus more on those components that used the most. 
Unfortunately, this means that the Scala, Groovy, Clojure, Jython, JRuby, Rhino, and Gosu implementations of Cucumber 
are no longer supported. 

While these implementations have been removed from the cucumber-jvm project, they are still available as part of the Cucumber project. 
If you are interested in maintaining any of these implementations, please [contact us](https://cucumber.io/support) so we can set you up!

## Cucumber Usage  ##

Cucumber-JVM comes in four parts: 

 * The core is required for all projects that want to use cucumber-jvm

 * A backend. This can be Java, Groovy, Scala, ect.

 * A runner. Aside from the command line provided by core, people can use JUnit or TestNg. 

 * A DI container such as Picocontainer, Spring, or Guice.

Each of these modules costs time and effort to maintain. So we gathered some date on which are actually used. 
Below are the statistics for info.cukes<sup>[1](#1)</sup> from September 2017. 
The number of downloads indicates how often the artifact was downloaded from maven central<sup>[2](#2)</sup>.

### Core ###

cucumber-core was downloaded 202244 times in a single month.

### Backend ###


|Artifact               |  Downloads |   % of total  |
|-----------------------|-----------:|--------------:|
|cucumber-java          |   182103   |      92.31%   |
|cucumber-scala_2.11    |     5297   |       2.69%   |
|cucumber-groovy        |     5005   |       2.54%   |
|cucumber-clojure       |     1091   |       0.55%   |
|cucumber-scala_2.12    |      971   |       0.49%   |
|cucumber-jython        |      884   |       0.45%   |
|cucumber-jruby         |      827   |       0.42%   |
|cucumber-rhino         |      608   |       0.31%   |
|cucumber-scala         |      394   |       0.20%   |
|cucumber-gosu          |       83   |       0.04%   |
|cucumber-scala_2.10    |        0   |       0.00%   |
|-----------------------|------------|---------------|
|total                  |   197263   |     100.00%   |
|cucumber-core          |   202244   |     102.53%   |


Looking at the numbers, there is a large gap between Java and the other JVM languages. There is also a large gap between
the runners up (Groovy and Scala) and the rest of the pack. 
Missing from this table is cucumber-java8. This module depends on cucumber-java and its usage (with 35012 downloads)
represents 19.22% of cucumber-java.

Oddly enough, the overall downloads total does not equal that of cucumber-core, suggesting there are one or more custom
backend implementations (e.g. cukes in space).

### DI Container ###

|Artifact               | Downloads |  % of total   |  
|-----------------------|----------:|--------------:|
|cucumber-picocontainer |  63194    |  61.05%       |
|cucumber-spring        |  30112    |  29.09%       |
|cucumber-guice         |   8662    |   8.37%       |
|cucumber-weld          |    769    |   0.74%       |
|cucumber-openejb       |    568    |   0.55%       |
|cucumber-needle        |    144    |   0.14%       |
|cucumber-osgi          |     57    |   0.06%       |
|-----------------------|-----------|---------------|
|total                  | 103506    |  100.00%      |
|cucumber-core          | 202244    |  195.39%      |

Picocontainer, Spring and Guice are the most used DI containers. However, there is a huge discrepancy in downloads with
core, which suggests that people either use a custom container or no DI container at all. 
We don't know why this is, although the lack of documentation might have something to do with it.

### Runner ###

|Artifact               | Downloads  |  % of total   |  
|-----------------------|-----------:|--------------:|
|cucumber-junit         |   176769   |   83.00%      |
|cucumber-testng        |    35913   |   16.86%      |
|cucumber-android       |      291   |    0.14%      |
|-----------------------|------------|---------------|
|total                  |   212973   |   100.00%     |
|cucumber-core          |   202244   |    94.96%     |

Most people use JUnit, some use TestNg. Curiously enough, some people might be using both together, as the total adds up
to more than the usage of core.

Android isn't used much at all. We also don't know why. It might be that people are using Appium in combination with
cucumber-java.

### Summary ###

Most people are using Java, in combination with JUnit or TestNg as a test framework. About half our users don't use a
DI container; the other half uses Picocontainer, Spring or Guice. 

Footnotes:
 * <a name="1"></a>1 : With 2.0.0 the groupId has changed to io.cucumber but due to to its recent release these numbers 
   are not representative yet.
 * <a name="2"></a>2 : This is not a completely accurate representation of use. Many corporate environments use a cache
  to avoid overloading maven central. It is however the best we have.
