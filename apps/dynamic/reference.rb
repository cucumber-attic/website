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

      wrap_headers(doc)
      create_anchors(doc)
      nav_links = create_nav_links(doc)

      doc.css('body').first.children.first.add_previous_sibling(nav_links)

      doc.to_s
    end

    private

    def wrap_headers(doc)
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

    def create_anchors(doc)
      doc.css('.header').map do |node|
        anchor = anchorify(node.text)
        anchor_tag = %Q{<a id="#{anchor}" class="reference-anchor" href="##{anchor}" aria-hidden="true"><span class="reference-link"></span></a>}
        node.prepend_child(anchor_tag)
      end
    end

    # Creates a nav (nested ul) with links to headers
    def create_nav_links(doc)
      result = doc.create_element('ul')
      ul = result
      li = nil
      last_level = 1
      doc.css('.header').map do |node|
        anchor = anchorify(node.text)
        level = node.name[1..-1].to_i
        delta = level-last_level
        if delta > 0
          delta.times do
            ul = doc.create_element('ul')
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
        li = doc.parse(%Q{<li><a href="##{anchor}">#{node.text}</a></li>"}).first
        ul.add_child(li)
      end
      result
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
