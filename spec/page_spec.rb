require 'yaml'
require_relative '../apps/dynamic/page'

module Dynamic
  describe Page do
    root = File.expand_path(File.join(File.dirname(__FILE__), "/../apps/dynamic"))
    views = File.join(root, 'views')

    config = {
      'site' => YAML.load_file(File.join(root, "_config.test.yml"))
    }

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
