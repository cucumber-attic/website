require 'yaml'
require 'cucumber/website/page'
require 'cucumber/website/config'

module Cucumber::Website
  describe Page do
    root = File.expand_path(File.join(File.dirname(__FILE__), "/../apps/dynamic"))
    views = File.join(root, 'views')

    extend Config
    config = load_config('test')

    it "exposes frontmatter as attributes" do
      template_path = File.dirname(__FILE__) + '/fixtures/some_page.md'
      page = Page.new(config, template_path, views)
      expect(page.arbitrary_frontmatter_attribute).to eq 'arbitrary frontmatter value'
    end

    it "can set attribute on page" do
      template_path = File.dirname(__FILE__) + '/fixtures/some_page.md'
      page = Page.new(config, template_path, views)
      page.new_attribute = 'yo'
      expect(page.new_attribute).to eq 'yo'
    end

    describe "as regular page" do
      let(:page) { Page.new(config, File.join(views, 'school.slim'), views) }

      it "has a url" do
        page = Page.new(config, File.join(views, 'school.slim'), views)
        expect(page.url).to eq("https://cukes.info/school")
      end
    end

    describe "as blog post" do
      let(:page) { Page.new(config, File.join(views, '_posts/matt-on-test-talks.md'), views) }

      it "has a title" do
        expect(page.title).to eq("Matt Wynne interviewed by TestTalks")
      end

      it "has a url" do
        expect(page.url).to eq("https://cukes.info/blog/2015/01/13/matt-on-test-talks")
      end
    end

    describe "as event" do
      it "has a title" do
        page = Page.new(config, File.join(views, 'events/cukeup-australia-2015.slim'), views)
        expect(page.title).to eq("cukeup-australia-2015")
      end
    end
  end
end
