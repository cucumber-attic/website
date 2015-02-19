require 'redcarpet'
require 'pygments'
require 'nokogiri'

module Cucumber
  class Reference < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, lexer: language)
    end

    def header(text, header_level)
      # The header class is temporary - it allows us to iterate over all headers
      # in order with Nokogiri
      %Q{<h#{header_level} class="header">#{text}</h#{header_level}>}
    end

    def postprocess(html)
      doc = Nokogiri::HTML("<!DOCTYPE html>\n<html><body>#{html}</body></html>")

      wrap_headers_and_contents_in_sections(doc)
      create_anchors_with_ids(doc)

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

    def wrap_headers_and_contents_in_sections(doc)
      doc.css('.header').map do |node|
        parent = doc.create_element('section')
        node.add_previous_sibling(parent)

        nodes = Nokogiri::XML::NodeSet.new(doc)
        while next_node = node.next
          break if next_node.name =~ /h\d/
          nodes.push(node)
          node = next_node
        end

        parent.add_child(nodes)
      end
    end

    def create_anchors_with_ids(doc)
      doc.css('.header').map do |node|
        anchor = anchorify(node.text)
        anchor_tag = %Q{<a id="#{anchor}" href="##{anchor}"></a>}
        node.prepend_child(anchor_tag)
      end
    end

    # Creates a nav (nested ul) with links to headers
    def create_nav_body_with_links_to_anchors(doc)
      ul = doc.parse(%Q{<ul class="nav nav-stacked">}).first

      li = nil
      last_level = 1
      doc.css('.header').map do |node|
        anchor = anchorify(node.text)
        level = node.name[1..-1].to_i
        delta = level-last_level
        if delta > 0
          delta.times do
            ul = doc.parse(%Q{<ul class="nav">}).first
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
