require 'slim'
require 'tilt'
require 'htmlentities'
require 'sprockets-helpers'
require_relative 'redcarpet_renderer'
require_relative 'utils'

Slim::Engine.set_options(pretty: ENV['RACK_ENV'] != 'production')
Slim::Engine.disable_option_validator!

module Cucumber
module Website
  class ViewContext
    include Sprockets::Helpers
    include Utils

    def initialize(views_dir, config, locals)
      @views_dir = views_dir
      @config    = config
      @locals    = locals
    end

    def encode_html(html)
      HTMLEntities.new.encode(html)
    end

    def slim(template)
      render(:slim, template)
    end

    def erb(template)
      render(:erb, template)
    end

    def render(engine, template, template_proc = nil, &block)
      options = {}

      if engine == :markdown
        options[:renderer] = renderer
        options[:fenced_code_blocks] = true
      end

      template_path = File.join(@views_dir, [template, engine.to_s].join('.'))
      template = Tilt[engine].new(template_path, 1, options, &template_proc)
      template.render(self, @locals, &block)
    end

    def nav_class(slug, name)
      slug == name ? 'active' : nil
    end

    def edit_url template_path
      "#{@config['edit_url']}/#{template_path}"
    end

    private

    def renderer
      @locals['renderer'] ? constantize(@locals['renderer']) : RedcarpetRenderer
    end
  end
end
end
