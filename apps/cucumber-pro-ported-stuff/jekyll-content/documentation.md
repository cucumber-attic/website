---
layout: one-column
title: Documentation
slug: documentation
---

### Documentation

Cucumber Pro is accessed via a regular browser or tablet. When you log in you will be presented with a list of your projects. If you don't have any projects you can add one by specifying the URL to a GitHub, Bitbucket or Subversion repository.

When you open a project you will see a list of Feature files that you can open, edit and save. For more details about how the various features work, please refer to [this blog post](/blog/2014/01/25/a-sneak-peek-at-cucumber-pro.html).

The diagram below gives a high level overview of the architecture, to give a better understanding of how Cucumber Pro fits in with other tools.

![Technical Overview](/images/architecture-overview.png)

At the top you see the three typical roles of people using Cucumber Pro together to collaborate on Cucumber Features (Executable Specifications).

Cucumber Features are plain text files that are stored in your own source control repository. With Cucumber Pro several people can edit these files in a web browser. The editor offers autocompletion to help with editing. Users don't have learn how to use source control - the editor is easier to use than a word processor.

Cucumber Pro only stores files in your own source control repository. No copies are stored in Cucumber Pro itself.

Cucumber Pro does not execute your Cucumber Features. You should set up a Continuous Integration (CI) server to do that automatically whenever a Feature file is saved (or other code is pushed to your source control).

Cucumber Pro will soon be able to collect result from Cucumber running in a CI server and present reports based on those.
