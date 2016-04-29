require 'tilt'
require 'sprockets-helpers'

module Cucumber
module Website
  class ViewContext
    include Sprockets::Helpers

    def initialize(views_dir, config, locals)
      @views_dir = views_dir
      @config    = config
      @locals    = locals
    end

    def slim(template)
      render(:slim, template)
    end

    def erb(template)
      render(:erb, template)
    end

    def render(engine, template, options = {}, template_proc = nil, &block)
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
  end
end
end
