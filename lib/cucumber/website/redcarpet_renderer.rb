require 'redcarpet'
require 'pygments'
require 'cgi'

module Cucumber
  module Website
    class RedcarpetRenderer < Redcarpet::Render::HTML
      def block_code(code, language)
        if language
          Pygments.highlight(code, lexer: language)
        else
          %Q{<div class="highlight shell"><pre>#{CGI::escapeHTML(code)}</pre></div>}
        end
      end

      # If the same header text exists in multiple places in the document,
      # a unique anchor prefix can be specified:
      #
      #    ## {something-unique}The text
      def header(text, header_level)
        prefix = ""
        if text =~ /^\{([^\{]+)\}(.*)/
          prefix = $1
          text = $2
        end
        anchor = "#{prefix}#{anchorify(text)}"

        ensure_unique(anchor)

        %Q{<h#{header_level} id="#{anchor}" class="header" data-swiftype-name="title" data-swiftype-type="string">#{text}</h#{header_level}>\n}
      end

      def ensure_unique(anchor)
        @used_anchors ||= []
        raise "Duplicate anchor: '#{anchor}'. Prefix Markdown header title with {something-unique}" if @used_anchors.index(anchor)
        @used_anchors << anchor
      end

      private

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
end
