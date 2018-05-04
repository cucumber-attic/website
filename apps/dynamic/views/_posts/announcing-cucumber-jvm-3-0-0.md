---
layout: post
nav: blog
date: "2018-05-04 09:00:00"
title: "Announcing Cucumber-JVM v3.0.0"
author: mpkorstanje
---

With great joy and some relief I'm happy to announce Cucumber-JVM 3.0.0!

Here follows a summary of notable changes, and the non backward compatible changes.
The full change log is available [here](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).
 

Notable Changes
----------------

## Cucumber Expressions ##

Cucumber expressions have been implemented! This required a fairly involved refactoring that necessitated the removal 
of XStream and prompted a rewrite of Data Tables. It was also one of the reasons that has prompted us to drop support 
for several the less used languages.

You can use Cucumber Expressions as [described on the new docs site](https://docs.cucumber.io/cucumber/cucumber-expressions/). 
To add custom parameters you have to implement `cucumber.api.Configuration`.

## Data Tables ##

Most importantly `DataTable` has moved from `cucumber.api.DataTable` to `io.cucumber.datatable.DataTable` and its API has
changed significantly. You can use the custom data table types as 
[described in the project README](https://github.com/cucumber/cucumber/tree/master/datatable).
To add custom data table types you have to implement `cucumber.api.Configuration`.


```java
public class ParameterTypes implements Configuration {

    @Override
    public Locale locale() {
        return ENGLISH;
    }

    @Override
    public void configureTypeRegistry(TypeRegistry typeRegistry) {
        typeRegistry.defineDataTableType(new DataTableType(
            Grocery.class,
            (Map<String, String> row) -> new Grocery(
                row.get("name"),
                Price.fromString(row.get("price"))
            )
        ));

     
    }
}
```

This may look a bit tedious. But you can also use your favourite object mapper instead.


```java
ObjectMapper objectMapper = new ObjectMapper();

typeRegistry.defineDataTableType(new DataTableType(
    Grocery.class,
    (Map<String, String> row) -> objectMapper.convertValue(row, Grocery.class))
);
```

## XStream ##

XStream has been removed from Cucumber. This means that `@Delimiter`, `@Format`, `@Transformer`, `@XStreamConverter`, 
`@XStreamConverters`and any other annotations from XStream will no longer work. These must be replaced by
`DataTableType` or `ParameterType`.

Prior to Cucumber Expressions XStream was used internally to handle all conversions from Strings to Objects. However the
usage of XStream in combination with Cucumber was poorly documented and it didn't allow for the use of other Object
Mappers (e.g. Jackson) which made it impossible to reuse domain objects. As XStream is not compatible with Java 9 it
also problem in term.

With the introduction of Cucumber Expressions half of the usecase for XStream disapeared. It wasn't realistic to use
both systems next to each other so now was a good time to remove it entirely.


## Before and After Step Hooks ## 

Adds hooks that are invoked before and after a step.

The hooks have 'invoke around' semantics. Meaning that if a before step hook is executed the after step hooks will also
be executed regardless of the result of the step. If a step did not pass, the following step and its hooks will be
skipped.

To support the invoke around semantics the TestStep event has been replaced with an interface. And it's concrete
implementation split into HookTestStep and PickleStepTestStep. All subclass specific methods in TestStep have been
deprecated.

When doing a dry run all hooks will be reported. In prior implementations the before and after scenario hooks were 
unskippable and simply not included. These have been made skippable but will only be skipped on a dry run.


Full change log
---------------

See [CHANGELOG.md](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).
