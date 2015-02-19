require 'yaml'
require 'slim'
require 'redcarpet'
require 'liquid'
require 'tilt'
require 'sinatra/base'

Slim::Engine.set_options(pretty: ENV['RACK_ENV'] != 'production')

# Sinatra app that displays a Jekyll app dynamically
# Support several template engines: Markdown, Slim and HTML with Liquid
module Dynamic
  class App < Sinatra::Application
    set :root,          File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, 'static') }
    set :views,         Proc.new { File.join(root, 'views') }

    engines = {
      '.md'     => :markdown,
      '.slim'   => :slim,
      '.html'   => :liquid
    }

    TIMESTAMPED_FILES = Dir["#{views}/_includes/*"] + [__FILE__]

    Dir["#{views}/**/*{#{engines.keys.join(',')}}"].each do |file|
      ext = File.extname(file)
      template_path = file[views.length+1..-1]
      template = file[views.length+1...-ext.length]
      next if template =~ /^_includes/

      path = template == 'index' ? '/' : "/#{template}"
      get path do
        timestamps = (TIMESTAMPED_FILES + [file]).map {|f| File.mtime(f)}
        last_modified timestamps.max

        locals = deep_merge_hashes(CONFIG, front_matter(file))
        locals['locals'] = locals # So slim can pass locals to _includes
        locals['template_path'] = template_path
        layout = locals['layout'] || 'layout'
        options = {
          layout_engine: :slim,
          layout: "_includes/#{layout}".to_sym
        }
        engine = engines[ext]
        if engine == :markdown
          # This causes a warning in Slim, but I can't see a way around it
          options[:renderer] = constantize(locals['renderer']) if locals['renderer']
          options[:fenced_code_blocks] = true
        end
        self.send(engine, template_proc(file), options, locals)
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

    private

    CONFIG = {
      'site' => YAML.load_file(File.join(root, "_config.#{ENV['RACK_ENV']}.yml"))
    }

    # Lifted from Jekyll::Document
    YAML_FRONT_MATTER_REGEXP = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m

    def front_matter(file)
      if has_yaml_header?(file)
        YAML.load_file(file)
      else
        {}
      end
    end

    def template_proc(file)
      Proc.new do |template|
        content = File.read(file)
        # $' is what follows the match - AKA $POSTMATCH
        content =~ YAML_FRONT_MATTER_REGEXP ? $' : content
      end
    end

    def has_yaml_header?(file)
      !!(File.open(file, 'rb') { |f| f.read(5) } =~ /\A---\r?\n/)
    end

    # Lifted from
    # http://gemjack.com/gems/tartan-0.1.1/classes/Hash.html
    #
    # Thanks to whoever made it.
    def deep_merge_hashes(master_hash, other_hash)
      target = master_hash.dup

      other_hash.each_key do |key|
        if other_hash[key].is_a? Hash and target[key].is_a? Hash
          target[key] = Utils.deep_merge_hashes(target[key], other_hash[key])
          next
        end

        target[key] = other_hash[key]
      end

      target
    end

    def constantize(class_name)
      unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ class_name
        raise NameError, "#{class_name.inspect} is not a valid constant name!"
      end

      Object.module_eval("::#{$1}", __FILE__, __LINE__)
    end
  end
end
