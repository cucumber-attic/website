require 'redcarpet'
require 'pygments'
require_relative 'nested_list'
require_relative 'ul_builder'

module Dynamic
  class Reference < Redcarpet::Render::HTML
    def preprocess(md)
      @carousel_languages = carousel_languages(md)
      md
    end


    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end

    def header(text, header_level)
      %Q{<h#{header_level} id="#{anchorify(text)}" class="header">#{text}</h#{header_level}>}
    end

    def postprocess(html)
      html = carouselify(html)
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

    def carousel_languages(md)
      carousels = md.split('[carousel]')[1..-1].map do |c|
        c.split('[/carousel]')[0]
      end
      languages = carousels.map do |c|
        c.split(/\n/).map { |l| l =~ /^```(\w+)/ ? $1 : nil }.compact
      end
      unique_languages = languages.uniq
      raise "Inconsistent carousel languages: #{languages.inspect}" if unique_languages.length > 1
      unique_languages[0] || []
    end

    def carouselify(html)
      slide_links = @carousel_languages.each_with_index.map do |language, slide|
        %Q{<span class="slide-link" data-slide="#{slide}">#{language}</span>}
      end.join
      carousel_control = %Q{<div class="carousel-control">#{slide_links}</div>}
      html
        .gsub('<p>[carousel]</p>', %Q{<div class="carousel-container">#{carousel_control}<div class="carousel">})
        .gsub('<p>[/carousel]</p>', '</div></div>')
    end

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
