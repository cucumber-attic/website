---
layout: post
nav:    blog
date:   2018-09-24 09:00:00
title:  "Announcing Cucumber-JVM v4.0.0"
author: mpkorstanje
---

I am happy to announce the release of Cucumber-JVM v4.0.0. This release features 
several new features, some quality of life improvements and major internal 
refactorings. As always the full change log can be found in the repository [here](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).

Notable Changes
----------------

## --parallel ##

Cucumber-JVM now supports parallel execution of Pickles[1] across threads! See the 
documentation for each runner on how to enable this[2][3][4]. This was made possible 
by some serious help from Kiel Boatman. Thanks!

While executing in parallel each thread will have it's own separate test context. 
If you are currently using static variables to share state between steps please 
refactor to using dependency injection first.

Because pickles are now executed concurrently `TestCaseEvent`s will no longer 
arrive in order. To mitigate the impact of this for `Eventlistener` implementations
the `Eventbus` will record all events and replay them in a canonical order. 
Implementations of `ConcurrentEventListener` will receive events as they happen. To help 
concurrent event listners handle concurrent events all `TestCaseEvents` now also include 
the `TestCase` of which they're part.

1. A Pickle is a compiled Gherkin Scenario. A Scenario with Examples results in multiple Pickles, one for each example.
2. [JUnit](https://github.com/cucumber/cucumber-jvm/tree/v4.0.0/junit). Unfortunately due to framework limitations JUnit4 can only execute features in parallel. 
3. [TestNG](https://github.com/cucumber/cucumber-jvm/tree/v4.0.0/testng)
4. [CLI](https://github.com/cucumber/cucumber-jvm/blob/v4.0.0/core/src/main/resources/cucumber/api/cli/USAGE.txt).


## Data Tables ##

With help from Łukasz Susk support was added to configure a default converter that
will handle all types for which no converter has been defined. This should safe some 
drudgery. The example below uses Jacksons object mapper.


```java
public class TypeRegistryConfiguration implements TypeRegistryConfigurer {

    @Override
    public Locale locale() {
        return ENGLISH;
    }

    @Override
    public void configureTypeRegistry(TypeRegistry typeRegistry) {
        JacksonTableTransformer jacksonTableTransformer = new JacksonTableTransformer();
        typeRegistry.setDefaultDataTableEntryTransformer(jacksonTableTransformer);
    }

    private static final class JacksonTableTransformer implements TableEntryByTypeTransformer, TableCellByTypeTransformer {

        private final ObjectMapper objectMapper = new ObjectMapper();

        @Override
        public <T> T transform(Map<String, String> entry, Class<T> type, TableCellByTypeTransformer cellTransformer) {
            return objectMapper.convertValue(entry, type);
        }

        @Override
        public <T> T transform(String value, Class<T> cellType) {
            return objectMapper.convertValue(value, cellType);
        }
    }
}
```

## Extra Glue ##

Eduardo Kalinowski added extra glue to `@CucumberOptions`.

```
src/test/java
  |- RunCukes.java // implicit @CucumberOptions(glue={"login", "signup", "common"}, ....)
  |- login
  |  |- login.feature
  |  |- LoginSteps.java
  |- signup
  |  |- signup.feature
  |  |- SignupSteps.java
  |- common
  |  |- CommonSteps.java
  |  |- SharedSteps.java
```  

A typical cucumber project has a single runner in a root package. This runner assumes that
the glue path is its current package. This assumption reduces the amount of configuration 
required.

This setup however only works well when there is a single runner. When there are multiple
runners each runners has to spell out its entire glue path e.g. 
`@CucumberOptions(glue={"login", "common"})`. With the extraGlue property this is no longer
required. The extra glue is used in addition to the default glue path.

```
src/test/java
  |- login
  |  |- RunCukes.java // @CucumberOptions(extraGlue={"common"}) implicit glue="login" 
  |  |- login.feature
  |  |- LoginSteps.java
  |  |- LoginPicoFactoryConfiguration.java
  |  |- LoginTypeRegistryConfiguration.java
  |- signup
  |  |- RunCukes.java //  @CucumberOptions(extraGlue={"common"}) implicit glue="signup"
  |  |- signup.feature
  |  |- SignupSteps.java
  |  |- SignupPicoFactoryConfiguration.java
  |  |- SignupTypeRegistryConfiguration.java
  |- common
  |  |- CommonSteps.java
  |  |- SharedSteps.java
  |  |- CommonPicoFactoryConfiguration.java
  |  |- CommonTypeRegistryConfiguration.java
```



## Internal Refactoring ##

With help from Marit Van Dijk the Cucumber internals are being refactored and we are slowly
moving towards constructor dependency injection. While on its face not an exciting
development it will help us move towards a more flexible and extensible version of
Cucumber in the future.

Full change log
---------------

See [CHANGELOG.md](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).
