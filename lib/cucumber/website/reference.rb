require_relative 'redcarpet_renderer'
require_relative 'nested_list'
require_relative 'ul_builder'

module Cucumber
  module Website
    class Reference < RedcarpetRenderer
      def preprocess(md)
        @carousel_languages = carousel_languages(md)
        md
      end

      def postprocess(html)
        html = carouselify(html)
        nav_body = create_nav_body_with_links_to_anchors(html)

        result = <<-HTML
<div class="container">
  <div class="row">
    <div class="col-md-3" role="complementary">
      <nav id="side-nav" class="affix hidden-sm hidden-xs">
#{nav_body}
      </nav>
    </div>
    <div class="col-md-9" role="main">
#{html}
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
        html
          .gsub('<p>[carousel]</p>', %Q{<div class="carousel-container">#{carousel_control}<div class="carousel">})
          .gsub('<p>[/carousel]</p>', '</div></div>')
      end

      def carousel_control
        lis = @carousel_languages.each_with_index.map do |language, slide|
          %Q{<li role="menuitem" class="slide-link" data-slide="#{slide}">#{language}</li>}
        end.join
<<-HTML
<div class="dropdown">
  <button type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
    <span class="current-slide">#{@carousel_languages[0]}</span>
    <span class="caret"></span>
  </button>
  <ul class="dropdown-menu" role="menu">#{lis}</ul>
</div>
HTML
      end

      # Creates a nested ul/li nav for h2,h3,h4,h5 elements. The h1 at the top of the
      # doc is not part of the nav.
      def create_nav_body_with_links_to_anchors(html)
        tree = NestedList.new
        html.split(/\n/).each do |line|
          if line =~ /<h([2-5]) id="([^"]+)" [^>]+>([^<]+)<\/h[2-5]>/
            level = $1.to_i - 2
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
    end
  end
end
