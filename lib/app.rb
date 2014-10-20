require 'sinatra'
require 'slim'
require 'tilt/redcarpet'
require 'pygments'

Slim::Engine.set_default_options pretty: true
set :root, File.expand_path(File.dirname(__FILE__) + '/..')

class HTMLwithPygments < Redcarpet::Render::HTML
  def initialize
    super(with_toc_data: true)
  end

  def block_code(code, language)
    html = Pygments.highlight(code, lexer: language)
    html.gsub(/<div class="highlight">/, %Q{<div class="highlight #{language}">})
  end

  def postprocess(doc)
    wrap_code = true
    lines = doc.split("\n")
    header_prefix = %Q{\n<div class="topic">\n  <div class="topic-section">\n    <div class="topic-description">\n}
    lines.each do |line|
      if line =~ /^<div class="highlight (ruby|java|javascript)">/ && wrap_code
        line.prepend(%Q{\n  </div>\n  <div class="topic-example">\n})
        wrap_code = false
      end
      if line =~ /^<h[1-4]/
        line.prepend(header_prefix)
        header_prefix = %Q{\n    </div>\n  </div>\n</div>\n<div class="topic">\n  <div class="topic-section">\n    <div class="topic-description">\n}
        wrap_code = true
      end
    end
    lines.push("\n    </div>\n  </div>\n</div>\n")
    lines.join("\n")
  end
end

set :markdown, :renderer => HTMLwithPygments, :fenced_code_blocks => true, :layout_engine => :slim, :layout => :reference_layout

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
