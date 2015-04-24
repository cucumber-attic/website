require 'cucumber/website/reference'
require 'redcarpet'

module Cucumber::Website
  describe Reference do
    Dir["#{File.dirname(__FILE__)}/reference/*.md"].each do |md_file|
      it "renders #{md_file}" do
        html = to_html(File.read(md_file))
        html_file = md_file.gsub(/\.md/, '.html')
        File.open(html_file, 'w') {|io| io.puts(html)} if ENV['WRITE_HTML']
        expect(html.strip).to eq(File.read(html_file).strip)
      end
    end

    def to_html(markdown)
      renderer = Redcarpet::Markdown.new(Cucumber::Website::Reference.new, fenced_code_blocks: true)
      renderer.render(markdown)
    end
  end
end
