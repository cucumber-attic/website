# The official Cucumber website (cucumber.io) [![Circle CI](https://circleci.com/gh/cucumber/website/tree/master.svg?style=svg)](https://circleci.com/gh/cucumber/website/tree/master)

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

[ruby](https://www.ruby-lang.org/en/documentation/installation/)

### Installation

1. Run the following commands:
```
gem install bundler
bundle install
bundle exec foreman start
```

2. Point a browser to `http://localhost:5000`

## How it works

We use Rack to mount several smaller rack apps that serve different bits of content that make up the site. The individual rack apps are stored under `apps` and are loaded by `config.ru`

See [this blog post](http://mwmanning.com/2011/12/04/Jekyll-on-Heroku-Part-2.html) for more information about this design.

We decided not to use rack-jekyll as it didn't seem to be able to handle mounting a non-root directory and didn't seem to add much, other than complexity.

## Contributing

Please see [The Cucumber Brand Guidelines](https://github.com/cucumber-ltd/brand/blob/master/Cucumber_Brand_V1.0.pdf) for
details about fonts and colours.

### How to add a blog post

* Go to https://github.com/cucumber/website/tree/master/apps/dynamic/views/_posts.  
* Open a previous blog post for reference and for the format header (new tab)  
* On the toolbar, click the '+' button.  
* Name new file with hyphens and ending with .md  
* C&P previous post format header into new file  
* Adjust format according to new post  
* C&P blog post markdown  
* Change to preview to see live changes  
* Once ready, update description and commit.  
* Watch build status to check if it has been post

### Production

Assets need to be precompiled for production. Heroku will take care of
it but you might want to try it locally:

    RACK_ENV=production bundle exec rake assets:precompile
    RACK_ENV=production bundle exec foreman start

## License

This project is licensed under the MIT License. See the [LICENSE](https://github.com/cucumber/website/blob/master/LICENSE) file for more information
