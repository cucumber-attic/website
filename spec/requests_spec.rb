require 'rack/test'
require 'nokogiri'

ENV['RACK_ENV'] = 'test'
APP = Rack::Builder.parse_file('config.ru').first

describe "integration testing" do
  include Rack::Test::Methods

  def app
    APP
  end

  [
    "/",
    "/training",
    "/school",
    "/blog",
    "/reference",
    "/css/style.css"
  ].each do |path|
    it "returns #{path} with a non-failure code" do
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

  describe "blog" do
    it "renders blog pages just like any other page" do
      get '/blog/2015/01/31/cucumber-ruby-rc-3-released-tmp'
      expect(last_response).to be_ok
    end
  end

  describe "rss feed" do
    it "exists" do
      get "/feed.xml"
      expect(last_response).to be_ok
      expect(last_response.headers['Content-Type']).to eq 'application/xml'
    end

    it "has 10 entries" do
      get "/feed.xml"
      feed = Nokogiri::XML(last_response.body)
      expect(feed.xpath('//rss/channel/item').length).to eq 10
    end
  end

  describe "redirects" do
    it "redirects all ruby api traffic to rubydoc.info" do
      get "/api/cucumber/ruby/yardoc/Cucumber/Configuration.html"
      expect(last_response.status).to eq 301
      expect(last_response.location).to eq "http://www.rubydoc.info/github/cucumber/cucumber/Cucumber/Configuration.html"
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
  end
end
