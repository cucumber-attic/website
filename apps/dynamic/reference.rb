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
  end
end
