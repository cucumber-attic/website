---
layout: post
author: aslak
title:  "A sneak peek at Cucumber Pro"
date:   2014-01-25 10:32:59
nav: blog
---

Cucumber Pro opened the door ajar for a select few [founder customers]({{ site.url }}/plans) a little over a month ago. Let's take a look at what we have so far:

## GitHub, Bitbucket and Subversion

Cucumber Pro lets you open and save executable specifications from GitHub.com, Bitbucket.org or Subversion repositories available on the Internet.

Adding a repository is easy - just paste the URL to your repository.

<iframe src="//fast.wistia.net/embed/iframe/dargnvqmvw" allowtransparency="true" frameborder="1" scrolling="no" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="640" height="388"></iframe>

## Type with others

Cucumber Pro has a simple text editor where you and other team members can edit executable specifications simultaneously from different computers or tablets.

This lets business analysts, testers and programmers collaborate and form a shared understanding of how the software should behave.

<iframe src="//fast.wistia.net/embed/iframe/r8yroculvy" allowtransparency="true" frameborder="1" scrolling="no" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="640" height="388"></iframe>

## Autocomplete

As the number of executable specifications grow, teams build a library of [step definitions](http://cucumber.io/step-definitions.html) that can be reused.

However, remembering the exact wording of step definitions is hard. This is why Cucumber Pro suggests them for you as you type.

<iframe src="//fast.wistia.net/embed/iframe/2tim8lubal" allowtransparency="true" frameborder="1" scrolling="no" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="640" height="388"></iframe>

In order to enable autocomplete you must tell Cucumber to generate a `.cucumber/.stepdefs.json` file in the root of your repository.

### Cucumber-Ruby

```
cucumber --dotcucumber .cucumber
```

### Cucumber-JVM

Using the JUnit Runner:

```java
@CucumberOptions(dotcucumber = ".cucumber")
```

Using the Command Line Runner:

```
java cucumber.api.cli.Main --dotcucumber .cucumber
```

### Cucumber-JS

Coming soon!

## Dirty files

Cucumber Pro automatically stores every keystroke so you don't lose your changes, but it doesn't automatically save files to your source control system.

To remind you about edited files that need to be saved, Cucumber Pro displays these "dirty" files as red.

When you save the file the red goes away and your file ends up in your source control.

![Dirty files]({{ site.url }}/images/blog/dirty-files.png)

## Branches

Many teams like to use feature branches when working on new features, and Cucumber Pro lets you choose what branch you want to work on simply by selecting the branch from a select box.

## Multilingual

You can use over 40 different languages with Cucumber Pro. Want Chinese?

{% highlight gherkin %}
# language: zh-CN
功能:加法
  为了避免一些愚蠢的错误
  作为一个数学白痴
  我希望有人告诉我数字相加的结果

  场景: 两个数相加
    假如我已经在计算器里输入6
    而且我已经在计算器里输入7
    当我按相加按钮
    那么我应该在屏幕上看到的结果是13
{% endhighlight %}

Ou plutôt le Français?

{% highlight gherkin %}
# language: fr
Fonctionnalité: Addition
  Afin de financer mon bonus avec l'argent des pigeons
  En tant que trader
  Je souhaite pouvoir additionner 2 chiffres

  Plan du Scénario: Addition de produits dérivés
    Soit une calculatrice
    Etant donné qu'on tape <a>
    Et qu'on tape <b>
    Lorsqu'on tape additionner
    Alors le résultat doit être <somme>

  Exemples:
    | a | b | somme |
    | 2 | 2 | 4     |
    | 2 | 3 | 5     |
{% endhighlight %}

## What's coming

Our main focus during the beta period is to polish the collaboration and source control features.

The next major functionality we'll be working on is results and reports. Cucumber Features are *executable*, so wouldn't it be nice to see the results of executed features?

You'll soon be able to publish results and screenshots from Cucumber to Cucumber Pro, and share reports with everyone on your team.

Stay tuned!

---
#### Update 14th Jan 2014

Corrected path to `stepdefs.json` file used for autocomplete thanks to comments from Joseph Salyer.
