require 'yaml'
require_relative '../apps/dynamic/page'
require_relative '../apps/dynamic/config'

module Dynamic
  describe Page do
    root = File.expand_path(File.join(File.dirname(__FILE__), "/../apps/dynamic"))
    views = File.join(root, 'views')

    extend Config
    config = load_config('test')

    describe "as regular page" do
      it "has an url" do
        page = Page.new(config, File.join(views, 'school.slim'), views)
        #expect(post.url).to eq("")
      end
    end

    describe "as blog post" do
      it "has an url" do
        page = Page.new(config, File.join(views, '_posts/matt-on-test-talks.md'), views)
        #expect(post.url).to eq("")
      end
    end
  end
end
