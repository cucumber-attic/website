---
layout: post
nav:    blog
date:   2018-10-31 17:00:00
title:  "Announcing Cucumber-JVM v4.2.0"
author: mpkorstanje
---

We've released Cucumber-JVM v4.2.0! There have been several smaller releases
since the announcement of v4.0.0, but this one is worth some extra attention. As
always, the full changelog can be found in [the repository.](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md)

## Anonymous Parameter Types ##

In Cucumber-JVM 2.x, it was possible to capture any string and have it converted to a
type instance. With the release of Cucumber Expressions in Cucumber 3.0, we removed XStream, which also removed the ability to keep that behavior. We're happy to announce that this behavior is back! By installing an object mapper (Jackson in this example) the following step
definitions can are usable:

```java
Given("^there is some date (.*)$", (Date a) -> { })

Given("^there is some transaction (.*) (.*)$", (BigDecimal a, Currency b) -> { })

Given("^there is some type (.*)$", (TypeEnum a) -> { })
```

Likewise for their Cucumber Expression equivalent:

```java
Given("there is some date {}", (Date a) -> { })

Given("there is some transaction {} {}", (BigDecimal a, Currency b) -> { })

Given("there is some type {}", (TypeEnum a) -> { })
```

For Cucumber-JVM the object mapper can be installed by placing an
implementation of `TypeRegistryConfigurer` on the glue path.

```java
public class ParameterTypes implements TypeRegistryConfigurer {

    @Override
    public Locale locale() {
        return ENGLISH;
    }

    @Override
    public void configureTypeRegistry(TypeRegistry typeRegistry) {
        Transformer transformer = new Transformer();
        typeRegistry.setDefaultDataTableCellTransformer(transformer);
        typeRegistry.setDefaultDataTableEntryTransformer(transformer);
        typeRegistry.setDefaultParameterTransformer(transformer);
    }

    private class Transformer implements ParameterByTypeTransformer, TableEntryByTypeTransformer, TableCellByTypeTransformer {
        ObjectMapper objectMapper = new ObjectMapper();

        @Override
        public Object transform(String s, Type type) {
            return objectMapper.convertValue(s, objectMapper.constructType(type));
        }

        @Override
        public <T> T transform(Map<String, String> map, Class<T> aClass, TableCellByTypeTransformer tableCellByTypeTransformer) {
            return objectMapper.convertValue(map, aClass);
        }

        @Override
        public <T> T transform(String s, Class<T> aClass) {
            return objectMapper.convertValue(s, aClass);
        }
    }
}
```

### Implicit Anonymous Parameter Types ###


Formally the anonymous parameter type is defined as:

```
ParameterType(
  name: ""
  regexps: [\.*\]
  transformer: s -> s
  useForSnippets: false
  preferForRegexMatch: true
)
```

When matching a step to a Cucumber expression, Cucumber inspects the parameter
types of the step definition method and replaces the identity transform 
`s -> s` with `s -> transform(s, type)`. 

Additionally, when using a regular expression with a capture group that does not have
a predefined parameter type, a new anonymous parameter type will be created for that capture group. As such the following step definitions can also are usable:

```java
Given("^there is some date ([0-9]{4}-[0-9]{2}-[0-9]{2})$", (Date a) -> { })

Given("^there is some transaction ([0-9]+) ([A-Z]{3})$", (BigDecimal a, Currency b) -> { })

Given("^there is some type (RED|GREEN|YELLOW)$", (TypeEnum a) -> { })
```

### Built in Object Mapper ###

While recommended, it is not required to install an object mapper.

Cucumber comes with a built-in object mapper that can handle most basic types. 
Aside from `Enum` it supports conversion to `String`, `BigInteger`, 
`BigDecimal`, `Byte`, `Short`, `Integer`, `Long`, `Float`, `Double` and 
`String`.

Full changelog
---------------

See [CHANGELOG.md](https://github.com/cucumber/cucumber-jvm/blob/master/CHANGELOG.md).
