require 'date'
require 'yaml'
require 'liquid'
require_relative 'view_context'

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
    YAML_FRONT_MATTER_REGEXP = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m

    class << self
      def all(config, views_dir)
        views_glob = "#{views_dir}/**/*{#{ENGINES.keys.join(',')}}"
        Dir[views_glob].map do |file|
          Page.new(config, file, views_dir)
        end
      end
    end

    attr_reader :engine

    def initialize(config, file, views_dir)
      @config       = config
      @file         = file
      @views_dir    = views_dir
      @front_matter = has_yaml_header? ? YAML.load_file(@file) : {}

      ext            = File.extname(file)
      @template_path = file[views_dir.length+1..-1]
      @template_name = file[views_dir.length+1...-ext.length]
      @engine        = ENGINES[ext]

      # Set some defaults
      @front_matter['title'] ||= @template_name.split('/')[-1]
    end

    def render(site, request, no_layout = false)
      raise caller[0..3].inspect if request === true
      locals['site'] = site
      view_context   = ViewContext.new(@views_dir, @config, locals, request)
      template_proc  = Proc.new { |template| content }

      html = view_context.render(engine, path, template_proc)
      html.gsub('---', '&#8212;') # em-dash

      return html if no_layout
      view_context.render(:slim, "_includes/#{layout}") { html }
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

    def source
      # Content after YAML header
      content = File.read(@file)
      # $' is what follows the match - AKA $POSTMATCH
      content =~ YAML_FRONT_MATTER_REGEXP ? $' : content
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

    def render(site, request)
      body
    end
  end
end
end
