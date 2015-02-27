require 'yaml'
require 'slim'
require 'redcarpet'
require 'liquid'
require 'tilt'
require 'sinatra/base'
require 'sinatra/assetpack'
require 'less'
require_relative 'utils'

Slim::Engine.set_options(pretty: ENV['RACK_ENV'] != 'production')

# Sinatra app that displays a Jekyll app dynamically
# Support several template engines: Markdown, Slim and HTML with Liquid
module Dynamic
  class App < Sinatra::Application
    extend Utils

    set :root,  File.dirname(__FILE__)
    set :views, Proc.new { File.join(root, 'views') }

    register Sinatra::AssetPack
    assets {
      css_dir = 'assets/css'
      serve '/css', from: css_dir
      Less.paths << File.join(App.root, css_dir)

      serve '/bower_components', from: 'bower_components'

      css :main, '/css/style.css', [
        '/css/main.css',
        '/bower_components/slick-carousel/slick/slick.css'
      ]
      css_compression :simple
    }

    engines = {
      '.md'     => :markdown,
      '.slim'   => :slim,
      '.html'   => :liquid
    }
    TIMESTAMPED_FILES = Dir["#{views}/_includes/*"] + [__FILE__]

    CONFIG = {
      'site' => YAML.load_file(File.join(root, "_config.#{ENV['RACK_ENV']}.yml"))
    }

    def self.path_for(template, locals)
      return '/' if template == 'index'

      segments = template.split('/')
      if segments[0] == 'blog'
        date_path = locals['date'].to_s.gsub('-', '/')
        segments.insert(1, date_path)
      end
      "/#{segments.join('/')}"
    end

    Dir["#{views}/**/*{#{engines.keys.join(',')}}"].each do |file|
      ext = File.extname(file)
      template_path = file[views.length+1..-1]
      template = file[views.length+1...-ext.length]
      next if template =~ /^_includes/

      locals = deep_merge_hashes(CONFIG, front_matter(file))
      locals['locals'] = locals # So slim can pass locals to _includes
      locals['template_path'] = template_path
      layout = locals['layout'] || 'layout'

      template_proc = Proc.new do |template|
        content_after_yaml_header(file)
      end

      renderer = constantize(locals['renderer']) if locals['renderer']

      get path_for(template, locals) do
        timestamps = (TIMESTAMPED_FILES + [file]).map {|f| File.mtime(f)}
        last_modified timestamps.max

        engine = engines[ext]

        # Don't move options outside the `get` block. It will get
        # clobbered after the 1st request (!?)
        options = {
          layout_engine: :slim,
          layout: "_includes/#{layout}".to_sym
        }
        if engine == :markdown
          # This causes a warning in Slim, but I can't see a way around it
          options[:renderer] = renderer
          options[:fenced_code_blocks] = true
        end
        self.send(engine, template_proc, options, locals)
      end
    end

    before do
      cache_control :public
    end

    helpers do
      def nav_class(slug, name)
        slug == name ? 'active' : nil
      end

      def edit_url(template_path)
        "#{CONFIG['site']['edit_url']}/#{template_path}"
      end
    end
  end
end
