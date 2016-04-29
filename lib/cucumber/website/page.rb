require 'date'
require 'yaml'
require 'liquid'
require 'slim'
require 'sass'
require 'tilt'
require 'htmlentities'
require 'sprockets-helpers'
require_relative 'utils'
require_relative 'redcarpet_renderer'

Slim::Engine.set_options(pretty: ENV['RACK_ENV'] != 'production')
Slim::Engine.disable_option_validator!

module Cucumber
  module Website
    class BasePage
      def initialize(front_matter)
        @front_matter = front_matter
      end

      def headers
        @front_matter.fetch('headers') { {} }
      end

      def cacheable?
        @front_matter.fetch('cacheable') { true }
      end

      def method_missing(name, *args)
        if name.to_s =~ /(.*)=$/
          @front_matter[$1] = args[0]
        else
          # key could be a string or a symbol - try both
          @front_matter.fetch(name.to_s) do
            @front_matter.fetch(name.to_sym) do
              raise NoMethodError, name, caller
            end
          end
        end
      end
    end

    class Page < BasePage
      ENGINES = {
        '.md'   => :markdown,
        '.slim' => :slim,
        '.xml'  => :erb,
        '.erb'  => :erb,
        '.adoc' => :asciidoc
      }

      class << self
        def all(config, views_dir)
          views_glob = "#{views_dir}/**/*{#{ENGINES.keys.join(',')}}"
          Dir[views_glob].map do |file|
            Page.new(config, file, views_dir)
          end
        end
      end

      include Utils

      attr_reader :engine

      def initialize(config, file, views_dir)
        @config     = config
        @file       = file
        @views_dir  = views_dir

        @front_matter = if has_yaml_header?
          YAML.load_file(@file)
        else
          {}
        end

        ext            = File.extname(file)
        @template_path = file[views_dir.length+1..-1]
        @template_name = file[views_dir.length+1...-ext.length]
        @engine        = ENGINES[ext]

        # Set some defaults
        @front_matter['title'] ||= @template_name.split('/')[-1]
      end

      def render(site, encode = false, no_layout = false)
        options = {
          layout_engine: :slim,
          # The no_layout flag prevents Liquid from using cached posts rendered in feed.xml
          # as the template for posts rendered in the blog
          layout: no_layout ? nil : "_includes/#{layout}"
        }

        if engine == :markdown
          options[:renderer] = renderer
          options[:fenced_code_blocks] = true
        end

        locals['site'] = site
        locals['locals'] = locals # So slim can pass locals to _includes

        template_proc = Proc.new { |template| content }
        view_context = ViewContext.new(@views_dir, @config)
        html = Tilt[engine].new(path, 1, options, &template_proc).render(view_context, locals)
        html.gsub('---', '&#8212;') # em-dash

        return html if no_layout

        template_path = File.join(@views_dir, "_includes/#{layout}.slim")
        layout_template = Tilt[:slim].new(template_path, 1, {})
        layout_template.render(view_context, locals) { html }
      end

      class ViewContext
        include Sprockets::Helpers

        def initialize(views_dir, config)
          @views_dir = views_dir
          @config = config
        end

        def slim(template, options = {})
          template_path = File.join(@views_dir, template.to_s + '.slim')
          template = Tilt[:slim].new(template_path, 1, {})
          template.render(self, options[:locals])
        end

        def erb(template, options = {})
          template_path = File.join(@views_dir, template.to_s + '.erb')
          template = Tilt[:erb].new(template_path, 1, {})
          template.render(self, options[:locals])
        end

        def nav_class(slug, name)
          slug == name ? 'active' : nil
        end

        def edit_url template_path
          "#{@config['edit_url']}/#{template_path}"
        end
      end

      def renderer
        locals['renderer'] ? constantize(locals['renderer']) : RedcarpetRenderer
      end

      def layout
        locals['layout'] || 'layout'
      end

      def locals
        locals = @front_matter
        # TODO: only for posts, when we have a subtype for that
        if @front_matter.key?('date')
          locals['date'] = date # because sometimes it can be a string
        end
        locals['template_path'] = @template_path
        locals['config'] = @config
        locals
      end

      def path
        return '/' if @template_name == 'index'
        return '/feed.xml' if @template_name == 'feed'
        return '/events-feed.xml' if @template_name == 'events-feed'
        if post?
          "/blog/#{date.strftime('%Y/%m/%d')}/#{@template_name.split('/')[-1]}"
        else
          "/#{@template_name}"
        end
      end

      def url
        "#{@config['url']}#{path}"
      end

      def content
        Liquid::Template.parse(source).render(locals)
      end

      def timestamp
        File.mtime(@file)
      end

      def post?
        @template_name =~ /^_posts\//
      end

      def event?
        @template_name =~ /^events\//
      end

      def primary?
        !(@template_name =~ /^_includes\//)
      end

      def date
        Time.parse(super.to_s)
      end

    private

      def has_yaml_header?
        !!(File.open(@file, 'rb') { |f| f.read(5) } =~ /\A---\r?\n/)
      end

      # Lifted from Jekyll::Document
      YAML_FRONT_MATTER_REGEXP = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m

      def content_after_yaml_header
        content = File.read(@file)
        # $' is what follows the match - AKA $POSTMATCH
        content =~ YAML_FRONT_MATTER_REGEXP ? $' : content
      end

      def source
        content_after_yaml_header
      end
    end

    # Stub used for specs and scenarios
    class FakeEventPage < BasePage
      def post?
        false
      end

      def event?
        true
      end

      def primary?
        true
      end

      def path
        url
      end

      def render(sinatra_app)
        body
      end
    end
  end
end
