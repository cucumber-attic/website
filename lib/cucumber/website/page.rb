require 'date'
require 'redcarpet'
require 'liquid'
require 'htmlentities'
require_relative 'utils'
require_relative 'redcarpet_renderer'

module Cucumber
  module Website
    class Page
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
        @config        = config
        @file          = file

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

      def method_missing(name, *args)
        if name.to_s =~ /(.*)=$/
          @front_matter[$1] = args[0]
        else
          @front_matter.fetch(name.to_s) do
            raise NoMethodError, name, caller
          end
        end
      end

      def locals
        locals = deep_merge_hashes(@config, @front_matter)
        locals['locals'] = locals # So slim can pass locals to _includes
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

      def render(sinatra, layout=layout, encode=false)
        options = {
          layout_engine: :slim,
          layout: layout ? "_includes/#{layout}".to_sym : nil
        }

        if engine == :markdown
          # This causes a warning in Slim, because when we render the layouts it
          # will be given the same set of options, but we need it for the markdown.
          options[:renderer] = renderer
          options[:fenced_code_blocks] = true
        end

        template_proc = Proc.new { |template| content }
        html = sinatra.send(engine, template_proc, options, locals)
        html.gsub('---', '&#8212;') # em-dash
      end

      def cacheable?
        @front_matter.fetch('cacheable') { true }
      end

      def url
        "#{@config['site']['url']}#{path}"
      end

      def content
        Liquid::Template.parse(source).render(locals)
        # redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, fenced_code_blocks: true)
        # redcarpet.render(liquid_processed_markdown)
      end

      def timestamp
        File.mtime(@file)
      end

      def headers
        @front_matter['headers'] || {}
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

      def renderer
        constantize(locals['renderer']) if locals['renderer']
      end

      def layout
        locals['layout'] || 'layout'
      end

    end
  end
end
