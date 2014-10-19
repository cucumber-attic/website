require 'sinatra'
require 'slim'
require 'tilt/redcarpet'
require 'pygments'

set :root, File.expand_path(File.dirname(__FILE__) + '/..')

class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end

set :markdown, :renderer => HTMLwithPygments, :fenced_code_blocks => true

# Automatically set up routes for all views
engines = {'.md' => :markdown, '.slim' => :slim}

views = Dir["#{settings.views}/**/*{#{engines.keys.join(',')}}"]
  .map { |file|
    ext = File.extname(file)
    {
      path: file[settings.views.length...-ext.length],
      ext: ext
    }
  }
  .reject { |view|
    view[:path] =~ /layout$/
  }

views.each do |view|
  get view[:path] do
    self.send(engines[view[:ext]], view[:path].to_sym)
  end
  if view[:path] == '/index'
    get '/' do
      self.send(engines[view[:ext]], view[:path].to_sym)
    end
  end
end
