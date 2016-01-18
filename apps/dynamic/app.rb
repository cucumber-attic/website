require 'yaml'
require 'slim'
require 'redcarpet'
require 'liquid'
require 'tilt'
require 'sinatra/base'
require 'sprockets-helpers'
require 'rollbar'
require 'rollbar/middleware/sinatra'
require 'cucumber/website/page'
require 'cucumber/website/config'
require 'cucumber/website/calendar'
require 'cucumber/website/events'
require 'cucumber/website/reference'
require 'cucumber/website/core/community'
require 'cucumber/website/core/site'
require 'cucumber/website/git_hub/api'
require 'cucumber/website/cache'

Slim::Engine.set_options(pretty: ENV['RACK_ENV'] != 'production')
Slim::Engine.disable_option_validator!

# Sinatra app that displays a Jekyll app dynamically.
#
# Why? A couple of reasons:
#
# * We have special requirements for the generated docs. Seemed easier to go the dynamic route.
# * We want to have some dynamic content as well as "static".
#
# Supports several template engines: Markdown, Slim and Erb.
# All templates are pre-processed with Liquid.
#
# Markdown can be used to generate reference documentation. Features include:
#
# * Automatic generation of nested left nav based on Markdown headers
# * Uses Bootstrap scroll spy to collapse/expand nav items
# * Mini-smartypants. --- gets converted to an emdash
# * Use [carousel] to create a carousel of code samples for different languages
# * Use {} in headers to create unique anchors when there are clashes
#
module Cucumber
module Website

  def self.make_app(site)
    Class.new(Sinatra::Application) do

      set :root, File.dirname(__FILE__)
      set :site, site

      configure :production do
        use Rollbar::Middleware::Sinatra
      end

      # TODO: This decision isn't a concern of the web app. Where to?
      if site.config['calendar_refresh_interval']
        site.events.start(site.config['calendar_refresh_interval'])
      end

      configure :test do
        enable :raise_errors
        disable :show_exceptions, :logging
      end

      site.pages.each do |page|
        next unless page.primary?

        get page.path do
          headers.merge!(page.headers)

          # TODO: this is insuficient for some pages. e.g. the blog index page, where it needs to check the mtime of each page rendered in the index. We should delegate this logic to the page class and have subtypes for different types of page.
          if page.cacheable? && settings.environment != :development
            timestamps = site.pages.map(&:timestamp) + [File.mtime(__FILE__)]
            last_modified timestamps.max
          end

          page.render(self)
        end
      end

      before /(.*)\.html/ do
        url = params[:captures][0]
        redirect to(url), 301
      end

      helpers do
        include Sprockets::Helpers

        def nav_class(slug, name)
          slug == name ? 'active' : nil
        end

        def edit_url template_path
          "#{settings.site.config['edit_url']}/#{template_path}"
        end
      end

      configure :development, :production do
        error 500 do
          status 500
          slim :error
        end
      end

      not_found do
        status 404
        slim :not_found
      end
    end
  end

  config = Config.new(ENV['RACK_ENV'])

  views_path = File.dirname(__FILE__) + "/views"
  pages = Page.all(config, views_path)

  logger = Logger.new($stderr)
  calendars = config['calendars'].map { |url| Calendar.new(url, logger) }

  git_hub = Cache.wrap(GitHub::API.new(config), 'git_hub', config, logger)
  site = Core::Site.new(config, pages, calendars, git_hub)

  App = make_app(site)
end
end
