require 'date'
require 'redcarpet'
require 'liquid'
require 'htmlentities'
require_relative 'utils'

module Dynamic
  class Page
    ENGINES = {
      '.md'     => :markdown,
      '.slim'   => :slim,
      '.html'   => :liquid,
      '.xml'    => :liquid
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

    attr_reader :engine, :locals

    def initialize(config, file, views_dir)
      @config        = config
      @file          = file

      ext            = File.extname(file)
      @template_path = file[views_dir.length+1..-1]
      @template_name = file[views_dir.length+1...-ext.length]
      @engine        = ENGINES[ext]

      @locals = deep_merge_hashes(config, front_matter)
      @locals['locals'] = @locals # So slim can pass locals to _includes
      @locals['template_path'] = @template_path
    end

    def path
      return '/' if @template_name == 'index'
      return '/feed.xml' if @template_name == 'feed'
      if post?
        "/blog/#{date.strftime('%Y/%m/%d')}/#{@template_name.split('/')[-1]}"
      else
        "/#{@template_name}"
      end
    end

    def renderer
      constantize(@locals['renderer']) if @locals['renderer']
    end

    def template_proc
      Proc.new do |template|
        content_after_yaml_header
      end
    end

    def layout
      @locals['layout'] || 'layout'
    end

    # Called when generating feed.xml
    def to_liquid
      {
        'title'   => title,
        'author'  => author,
        'content' => HTMLEntities.new.encode(content),
        'url'     => url,
        'date'    => date
      }
    end

    def title
      fm['title']
    end

    def author
      fm['author']
    end

    def date
      fm['date']
    end

    def url
      "#{@config['site']['url']}#{path}"
    end

    def content
      redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML.new, fenced_code_blocks: true)
      liquid_processed_markdown = Liquid::Template.parse(source).render(@config)
      redcarpet.render(liquid_processed_markdown)
    end

    def timestamp
      File.mtime(@file)
    end

    def headers
      front_matter['headers'] || {}
    end

    def post?
      @template_name =~ /^_posts\//
    end

    def primary?
      !(@template_name =~ /^_includes\//)
    end

  private

    def front_matter
      if has_yaml_header?
        YAML.load_file(@file)
      else
        {}
      end
    end

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

    def fm
      @fm ||= front_matter
    end

    def source
      @source ||= content_after_yaml_header
    end
  end
end
