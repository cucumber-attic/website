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
require 'cucumber/website/community'

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

  def self.make_app(pages)
    Class.new(Sinatra::Application) do

      set :root,  File.dirname(__FILE__)

      use Rollbar::Middleware::Sinatra

      configure(:development, :production) do
        CONFIG['site']['events'].start(CONFIG['site']['calendar_refresh_interval'])
      end

      configure :test do
        enable :raise_errors
        disable :show_exceptions, :logging
      end

      pages.each do |page|
        next unless page.primary?

        get page.path do
          headers.merge!(page.headers)

          if page.cacheable?
            timestamps = pages.map(&:timestamp) + [File.mtime(__FILE__)]
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
          "#{CONFIG['site']['edit_url']}/#{template_path}"
        end
      end

      error 500 do
        status 500
        slim :error
      end

      not_found do
        status 404
        slim :not_found
      end
    end
  end

  extend Config
  CONFIG = load_config(ENV['RACK_ENV'])

  views_path = File.dirname(__FILE__) + "/views"
  pages = Page.all(CONFIG, views_path)

  CONFIG['site']['posts'] =
    pages.select(&:post?).select { |page| page.date < Time.now }
    .sort { |a, b| b.date <=> a.date }

  calendar_logger = Logger.new($stderr)
  calendars = CONFIG['site']['calendars'].map { |url| Cucumber::Website::Calendar.new(url, calendar_logger) }
  events = Cucumber::Website::Events.new(pages.select(&:event?), calendars)
  CONFIG['site']['events'] = events

  CONFIG['site']['community'] = Cucumber::Website::CommunityLoader.new.call

  App = make_app(pages)
end
end
