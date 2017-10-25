# Cucumber-JVM is dropping support of JVM Languages #

Cucumber JVM is developed by volenteers who are all donating part of their spare time. Currently the core team of Cucumber-JVM consists of 3-4 people. As is this is bearly enough to keep up with current developments in cucumber such as upgrading gherkin, adding tag expresssions and cucumber expressions. Nevermind the daily housekeeping of dealing with tickets pull requests.

To be able to keep developing cucumber-jvm we are looking to decrease or workload a bit. To this end we started looking at how cucumber was used. In short we found that most people are using java, in combination with junit or testng as a test framework. About half our users don't use a DI-container. The other half uses picocontainer, spring or guice. 

We can also see that a good number of languages aren't used much at all. As the language modules are also fairly complex and consume a good amount of time we have decided to stop their support. This means that the scala, groovy, clojure, jython, jruby, rhino, scala and gosu implementations of cucumber are no longer supported. 

While these implementations have been removed from the cucumber-jvm project but are still available as part of the cucumber project. If you are interested in maintaining any of these implementations please hop into Slack so we can set you up!

## Cucumber Usage  ##

Cucumber-JVM comes in four parts. 

 * The core is required for all projects that want to use cucumber-jvm

 * A backend. This can be java, groovy, scala, ect.

 * A runner. Aside from the command line provided by core people can use Junit or TestNg. 

 * A di container such as Picocontainer, Guice, Spring.

Each of these modules costs time and effort to maintain. So we're interested in knowing which are actually used. Below are the statistics for info.cukes[1] from September. The number of downloads indicates how often the artifact was downloaded from maven central[2].

### Core ###

cucumber-core was downloaded 202244 times in a single month.

### Backend ###

Artifact                Downloads   % of total

cucumber-java           182103      92.31%          

cucumber-scala_2.11     5297        2.69%

cucumber-groovy         5005        2.54%

cucumber-clojure        1091        0.55%

cucumber-scala_2.12     971         0.49%

cucumber-jython         884         0.45%

cucumber-jruby          827         0.42%

cucumber-rhino          608         0.31%

cucumber-scala          394         0.20%

cucumber-gosu           83          0.04%

cucumber-scala_2.10     0           0.00%

------------------------------------------------

total                   197263      100.00%

cucumber-core           202244      102.53%

Looking at the numbers there is a large gap between java and the other jvm languages. And also a large gap between the runners up groovy and scala and the rest of the pack. Missing from this table is cucumber-java8. This module depends on cucumber-java and its usage comes with 35012 downloadsdown to 19.22% of cucumber-java.

Odly enough the total downloads total does not equal that of cucumber-core suggesting there are one or more custom back end implementations (e.g. cukes in space).

### DI Container ###

Artifact                Downloads   % of total

cucumber-picocontainer  63194       61.05%

cucumber-spring         30112       29.09%

cucumber-guice          8662        8.37%

cucumber-weld           769         0.74%

cucumber-openejb        568         0.55%

cucumber-needle         144         0.14%

cucumber-osgi           57          0.06%

------------------------------------------------

total                   103506      100.00%

cucumber-core           202244      195.39%

Pico container, sprint and guice are the most used di containers. However there is a huge discrepency with core. This suggests that people either use a custom container or no di-container at all. 

I am curious why. Though I suspect a lack of documentation is to blame.

### Runner ###

cucumber-junit          176769      83.00%

cucumber-testng         35913       16.86%

cucumber-android        291         0.14%

------------------------------------------------

total                   212973      100.00%

cucumber-core           202244      94.96%

Most people use junit, some use testng and curiously enough because the total adds up to more the the usage of core people must be using both together.

Android isn't used much at all. I don't know why. I think people might be using Appium in combination with cucumber-java.

### Summary ###

Most people are using java, in combination with junit or testng as a test framework. About half our users don't use a DI-container. The other half uses picocontainer, spring or guice. 

Footnotes:

 1 : With 2.0.0 the groupId has changed to io.cucumber but due to to its recent release these numbers are not representative yet.

 2 : This is not a completely accurate representation of use. Many coroporate environments use a cache to avoid overloading maven central. It is however the best we have.
