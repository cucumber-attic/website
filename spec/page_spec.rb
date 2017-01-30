require 'cucumber/website/page'
require 'cucumber/website/config'

module Cucumber::Website
  describe Page do
    root = File.expand_path(File.join(File.dirname(__FILE__), "/../apps/dynamic"))
    views = File.join(root, 'views')

    config = Config.new('test')

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
        expect(page.url).to eq("https://cucumber.io/school")
      end
    end

    describe "as blog post" do
      let(:page) { Page.new(config, File.join(views, '_posts/matt-on-test-talks.md'), views) }

      it "has a title" do
        expect(page.title).to eq("Matt Wynne interviewed by TestTalks")
      end

      it "has a url" do
        expect(page.url).to eq("https://cucumber.io/blog/2015/01/13/matt-on-test-talks")
      end

      it "has a date" do
        expect(page.date).to be_a(Time)
      end
    end

    describe "as event" do
      it "has a title" do
        page = Page.new(config, File.join(views, 'events/cukeup-australia-2015.slim'), views)
        expect(page.title).to eq("CukeUp! Australia")
      end
    end

    describe "rendering" do
      let(:page) { Page.new(config, File.join(views, '_posts/mob-programming.md'), views) }
      let(:site) { double }
      let(:request) { double(session: {}) }

      it "gets a blog post as HTML" do
        rendered_post = page.render(site, request)
        expect(Nokogiri::XML(rendered_post).root.name).to eq "html"
      end

      it "gets the XML feed" do
        rendered_feed = page.render(site, request, true)
        expect(Nokogiri::XML(rendered_feed).root.name).to eq "p"
      end

      it "renders the same view multiple times with different layouts" do
        rendered_post = page.render(site, request)
        expect(Nokogiri::XML(rendered_post).root.name).to eq "html"
      end
    end
  end
end
