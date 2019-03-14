require 'rack/test'
require 'nokogiri'
require 'cucumber/website/calendar'
require 'cucumber/website/config'
require 'cucumber/website/page'
require 'cucumber/website/git_hub'
require 'cucumber/website/core/site'

ENV['RACK_ENV'] = 'test'
APP = Rack::Builder.parse_file('config.ru').first

describe "integration testing" do
  include Rack::Test::Methods

let(:app) { APP }

  [
    "/",
    "/training",
    "/school",
    "/blog",
    "/assets/main.css",
    "/fonts/cucumber-glyphs.eot",
    "/bdd-kickstart.pdf",
    "/events/bdd-analysis-london-2015",
  ].each do |path|
    it "GET '#{path}' responds with a non-failure code" do
      get path
      expect(last_response).to be_ok
      expect(last_response.headers['Content-Length'].to_i).to be > 0
    end
  end

  describe "any missing page" do
    it "returns a 404" do
      get "/missing"
      expect(last_response.status).to eq 404
    end
  end

  describe "events" do
    describe "rss feed" do
      let(:site) do
        config = Cucumber::Website::Config.new('test')
        views = File.join(File.dirname(__FILE__), "../apps/dynamic/views")
        pages = Cucumber::Website::Page.all(config, views)

        git_hub = Cucumber::Website::GitHub.for(config)
        Cucumber::Website::Core::Site.new(config, pages, git_hub)
      end

      let(:app) do
        Cucumber::Website.make_app(site)
      end

      it "exists" do
        get "/events-feed.xml"
        expect(last_response).to be_ok
        expect(last_response.headers['Content-Type']).to eq 'application/rss+xml'
      end

      xit "has at least 1 entry" do
        get "/events-feed.xml"
        feed = Nokogiri::XML(last_response.body)
        expect(feed.xpath('//rss/channel/item').length).to be > 0
      end
    end
  end

  context "when the request has an .html extension" do
    it "redirects to resource without .html extension" do
      get "/school.html"
      expect(last_response.status).to eq(301)
      follow_redirect!
      expect(last_response).to be_ok
      expect(last_request.path).to eq('/school')
    end
  end

  describe "redirects" do
    it "redirects all ruby api traffic to rubydoc.info" do
      get "/api/cucumber/ruby/yardoc/Cucumber/Configuration.html"
      expect(last_response.status).to eq 301
      expect(last_response.location).to eq "http://www.rubydoc.info/github/cucumber/cucumber-ruby/Cucumber/Configuration.html"
    end

    it "redirects all jvm api traffic to cucumber.github.io" do
      get "/api/cucumber/jvm/"
      expect(last_response.status).to eq 301
      expect(last_response.location).to eq "http://cucumber.github.io/api/cucumber/jvm/"
    end

    it "redirect all gherkin api traffic to cucumber.github.io" do
      get "/api/gherkin/"
      expect(last_response.status).to eq 301
      expect(last_response.location).to eq "http://cucumber.github.io/api/gherkin/"
    end

    it "redirects the podcast to soundcloud" do
      get "/podcast/feed.xml"
      expect(last_response.status).to eq 302
      expect(last_response.location).to eq "http://feeds.soundcloud.com/users/soundcloud:users:181591133/sounds.rss"
    end

    %w(ah jb mw sr st).each do |initials|
      it "redirects '#{initials}' to homepage to track incoming from business cards" do
        get "/#{initials}"
        expect(last_response.status).to eq 303
        expect(last_response.location).to eq('/')
      end
    end
  end

  describe "rewrites" do
  end
end
