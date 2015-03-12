---
layout: bootstrap
title: Gherkin
---
# Gherkin/Feature Files

Gherkin is the format for Cucumber Specifications. Technically speaking it is a [small computer language](http://www.martinfowler.com/bliki/BusinessReadableDSL.html) with a well-defined syntax, but
it's so simple that you don't have to know how to program in order to use it. 

Gherkin has following Characteristics:
-  Gherkin is a Domain Specific language which is used for behavior specifications.
- Gherkin is a line-oriented language that uses indentation to define structure.
- Most lines in Gherkin start with a Keyword.
- Line endings terminate statements.

Here is a simple Gherkin document or a feature file:

```gherkin
Feature: Password management
  
  In order to manage passwords
  As a registered user
  I want to specify password management rules
  
  Scenario: Forgot password
    Given a user with email "cukes@cukes.info" exists
    When I ask for a password reset
    Then an email with a password reset link should be sent

```
The only syntax here is the colored keywords (Feature, Scenario, Given etc) at the beginning of each line. The rest is entirely up to you.
Gherkin documents are stored in regular text files with a `.feature` file extension. The file above could
be stored in a `password_management.feature` file.

When you [run Cucumber](/running.html), it will generate a report that verifies whether or not the software
behaves the way the Gherkin document says.

How is that possible? You (or someone else on your team) can then write [some code](/step-definitions.html)
that translates the text in the Gherkin document into interactions with the software.

Cucumber divides a feature file into Feature, Scenario and Steps. lets discuss each Keyword in more detail:

###### Feature:
      - When cucumber scans a .feature file, it looks for a keyword Feature.
      - Every feature file should contain only one Feature Keyword.
      - Line that follows after Feature Keyword is the Title of the Feature.
      - Title of the Feature is used in Test Results.
      - Three Indented lines after the Feature Keyword line start a feature.
      - These three lines specify the INTENT of the feature file.
      - Example of these three lines:
          In order to {{achieve something}}
          As a {{Registered User}}
          I want to {{implement xyz functionality}}
      - Untill cucumber encounters another keyword like Scenario or Scenario Outline etc, all text will be considered in keyword Features' scope.

###### Scenario:
      - Each Feature file may have multiple scenarios.
      - Each Scenario start with a Keyword Scenario.
      - Line that follwos Keyword Scenario is Scenario Title.
      - Scenario Title is used in Test Reports but is optional.
      - Each Scenario can be considered as a Test Case.

###### Steps:
      Each Scenario contain multiple Steps and these are equvivalent to Test Steps.Given, When, Then, And, But are different types of steps available.

###### Given:
      Given Steps put the system in known state which is necessary for the user action( followed in next step). These are similar to Pre Conditions of the use cases. 

###### When:
      The purpose of When steps is to describe the user action.

###### Then: 
      The purpose of Then steps is to observe expected outcomes. The observations should be related to the business value/benefit in your feature description.
