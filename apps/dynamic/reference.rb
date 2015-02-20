require 'redcarpet'
require 'pygments'
require_relative 'nested_list'
require_relative 'ul_builder'

module Dynamic
  class Reference < Redcarpet::Render::HTML
    def block_code(code, language)
      code = Pygments.highlight(code, lexer: language)
      if language == 'gherkin'
        code
      else
        %Q{<div class="programming #{language}">#{code}</div>}
      end
    end

    def header(text, header_level)
      %Q{<h#{header_level} id="#{anchorify(text)}" class="header">#{text}</h#{header_level}>}
    end

    def postprocess(html)
      html.gsub!('<p>[carousel]</p>', '<div class="carousel">')
      html.gsub!('<p>[/carousel]</p>', '</div>')
      nav_body = create_nav_body_with_links_to_anchors(html)

      result = <<-HTML
<div class="container">
  <div class="row">
    <div class="col-md-9" role="main">
#{html}
    </div>
    <div class="col-md-3" role="complementary">
      <nav id="side-nav" class="affix">
#{nav_body}
      </nav>
    </div>
  </div>
</div>
HTML
    end

    private

    def create_nav_body_with_links_to_anchors(html)
      tree = NestedList.new
      html.split(/\n/).each do |line|
        if line =~ /<h(\d) id="([^"]+)" class="header">([^<]+)<\/h\d>/
          level = $1.to_i - 1
          item = {href: "##{$2}", text: $3}
          tree.add(level, item)
        end
      end

      ul = '<ul class="nav nav-stacked" role="tablist">'
      nested_list_builder = UlBuilder.new(tree.nested, ul) do |item|
        %Q{<li role="presentation"><a href="#{item[:href]}">#{item[:text]}</a>}
      end
      nested_list_builder.build
    end

    def anchorify(string)
      string
      .gsub(/[']+/, '')
      .gsub(/\W+/, ' ')
      .strip
      .downcase
      .gsub(' ', '-')
    end
  end
end
