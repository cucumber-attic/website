---
title: Reference
slug: reference
renderer: Dynamic::Reference
---
# Cucumber-JVM Reference

This is the reference document for Cucumber-JVM-specific features.
Please see the general [reference](reference) for features that are
common to all platforms.

## Step Definitions

### One-dimensional lists

```gherkin
Given the following animals: cow, horse, sheep
```

This can be turned into a `List<String>` automatically:

```java
@Given("the following animals: (.*)")
public void the_following_animals(List<String> animals) {
}
```

See the [@Delimiter](#) annotation for details about how to define a delimiter different than `,`.

If you prefer to use a `DataTable` to define a list you can do that too:

```gherkin
Given the following animals:
  | cow   |
  | horse |
  | sheep |
```

This can be turned into a `List<String>` automatically:

```java
@Given("the following animals:")
public void the_following_animals(List<String> animals) {
}
```

In this case, the `DataTable` is automatically flattened to a `List<String>`
by Cucumber (using `DataTable.asList(String.class)`) before invoking the step
definition.
