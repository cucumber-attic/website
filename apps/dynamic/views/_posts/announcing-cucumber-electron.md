---
layout:   post
author:   josh
title:    "Announcing cucumber-electron"
date:     2017-01-23 09:00:00
nav:      blog
---

# Announcing cucumber-electron

There's a new way to run cucumber-js 2.0.0 for anyone building browser
applications. It's called
[cucumber-electron](https://github.com/cucumber/cucumber-electron) and it's
available as an npm module that acts as a drop-in replacement for
cucumber-js itself, supporting the same features and command line options.

Cucumber-electron runs cucumber-js in [Electron](http://electron.atom.io/),
a framework for building desktop applications in web technologies. By running
features this way, your step definitions can `require` npm modules including
server-side libraries and node.js core modules _and_ use a browser DOM to
render HTML, all in the same (chromium renderer) process, with no transpile step.

This approach is a compelling alternative to using a frameworks like Selenium
WebDriver, which automate real browsers like Chrome and Firefox, or even tools
like PhantomJS which automate a headless virtual browser. Because there is only
one process, scenarios run much faster and debugging failures is significantly
simpler. It's also possible to write synchronous step definitions for
manipulating and asserting about the DOM, which tend to be more reliable and
easier to write than their asynchronous equivalents. Finally, cucumber-electron
can be launched in "headed mode" and the familiar chromium developer tools can
be used for interactive debugging of your web app.

![Screenshot](https://gist.github.com/joshski/a5c35da27f752ca542c2ac61b64b08c1/raw/3807cb18da8a4e6ea72b293ec738326bad11d0ee/cucumber-electron-screenshot.png "cucumber-electron screenshot")

It's already being used to drive the development of a few substantial projects
including [bbc-a11y](https://github.com/bbc/bbc-a11y), an accessibility linting
tool for web apps.

Try it on your web app project and let us know how you get on!
