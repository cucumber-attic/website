require 'redcarpet'
require 'pygments'
require 'nokogiri'

module Cucumber
  class Reference < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end

    def header(text, header_level)
      %Q{<h#{header_level} id="#{anchorify(text)}" class="header">#{text}</h#{header_level}>}
    end

    def postprocess(html)
      doc = Nokogiri::HTML("<!DOCTYPE html>\n<html><body>#{html}</body></html>")

      nav_body = create_nav_body_with_links_to_anchors(doc)
      body = doc.css('body').first.children.to_s

      result = <<-HTML
<div class="container">
  <div class="row">
    <div class="col-md-9" role="main">
      #{body}
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

    # Creates a nav (nested ul) with links to headers
    def create_nav_body_with_links_to_anchors(doc)
      ul = doc.parse(%Q{<ul class="nav nav-pills nav-stacked" role="tablist">}).first

      li = nil
      last_level = 1
      doc.css('.header').map do |node|
        level = node.name[1..-1].to_i
        delta = level-last_level
        if delta > 0
          delta.times do
            ul = doc.parse(%Q{<ul class="nav nav-pills nav-stacked">}).first
            li.add_child(ul)
          end
        end
        if delta < 0
          delta.abs.times do
            ul = ul.parent.parent
          end
        end

        last_level = level

        # TODO: Escape node.text
        anchor = node['id']
        li = doc.parse(%Q{<li role="presentation"><a href="##{anchor}">#{node.text}</a></li>"}).first
        ul.add_child(li)
      end

      ul
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
