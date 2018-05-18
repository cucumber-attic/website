---
layout: post
nav:    blog
date:   2018-05-21 09:00:00
title:  "Announcing Cucumber-JVM v3.0.0"
author: mpkorstanje
---

With great joy and some relief I'm happy to announce Cucumber-JVM 3.0.0!

Here follows a summary of notable changes, and the non backward compatible changes.
The full change log is available [here](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).
 

Notable Changes
----------------

## Cucumber Expressions ##

Cucumber expressions have been implemented! Cucumber Expressions 
[were introduced](https://cucumber.io/blog/2017/07/26/announcing-cucumber-expressions) nearly a year ago in Cucumber.rb 
and Cucumber.js. Introducing them to cucumber-jvm required a fairly involved redesign that prompted a rewrite of 
Data Tables. It was also one of the reasons that has motivated us to [drop support for several the less used languages](https://cucumber.io/blog/2018/05/21/cucumber-jvm-languages-support). 

You can use Cucumber Expressions as [described on the new docs site](https://docs.cucumber.io/cucumber/cucumber-expressions/). 
To add custom parameters you have to place an implementation of `cucumber.api.TypeRegistryConfigurer` on the glue path.

## Data Tables ##

Most importantly `DataTable` has moved from `cucumber.api.DataTable` to `io.cucumber.datatable.DataTable` and its API has
changed significantly. You can use the custom data table types as 
[described in the project README](https://github.com/cucumber/cucumber/tree/master/datatable).
To add custom data table types you have to place an implementation of `cucumber.api.TypeRegistryConfigurer` on the glue path.


```java
public class TypeRegistryConfiguration implements TypeRegistryConfigurer {

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

This may look a bit tedious. But you can also use your favourite object mapper library instead.


```java
ObjectMapper objectMapper = new com.fasterxml.jackson.databind.ObjectMapper();

typeRegistry.defineDataTableType(new DataTableType(
    Grocery.class,
    (Map<String, String> row) -> objectMapper.convertValue(row, Grocery.class))
);
```

## XStream ##

Cucumber 1.x and 2.x used a library called XStream as a central building block for both data tables and type conversion.

However the usage of XStream in combination with Cucumber was poorly documented and it did not allow for the use of other 
Object Mappers (e.g. Jackson) which made it impossible to reuse domain objects. As XStream is not compatible with Java 9
it was also problem in long term.

With the introduction of Cucumber Expressions half of the use case for XStream disappeared. It  was not realistic to use
both systems next to each other so now was a good time to remove it entirely.

As such XStream has been removed from Cucumber. This means that `@Delimiter`, `@Format`, `@Transformer`, 
`@XStreamConverter`, `@XStreamConverters`and any other annotations from XStream will no longer work. These must be 
replaced by `DataTableType` or `ParameterType`.

We're not providing a migration guide in this blog post. If you have a specific question about how to migrate, please
[contact us](https://cucumber.io/support) and we'll update the documentation accordingly.


## Before and After Step Hooks ## 

Adds hooks that are invoked before and after a step.

The hooks have 'invoke around' semantics. Meaning that if a before step hook is executed the after step hooks will also
be executed regardless of the result of the step. If a step did not pass, the following step and its hooks will be
skipped.

To support the invoke around semantics the TestStep event has been replaced with an interface. Its concrete
implementation split into HookTestStep and PickleStepTestStep. All subclass specific methods in TestStep have been
deprecated.

During a dry run all hooks will be reported as skipped. In prior implementations the before and after scenario hooks
were unskippable and were simply not included in a dry run.  


Full change log
---------------

See [CHANGELOG.md](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).
