require 'rack/test'

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
    "/dynamic-liquid",
    "/dynamic-markdown",
    "/dynamic-slim"
  ].each do |path|
    it "returns #{path} with a non-failure code" do
      get path
      expect(last_response).to be_ok
    end
  end

  describe "any missing page" do
    it "returns a 404" do
      get "/missing"
      expect(last_response.status).to eq 404
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

  describe "Dynamic app" do
    it "renders a liquid page with layout" do
      get "/dynamic-liquid"
      expect(last_response.body).to include('This is from layout.slim')
      expect(last_response.body).to include('<p>Dynamic: https://cukes.info</p>')
    end

    it "renders a markdown page with layout" do
      get "/dynamic-markdown"
      expect(last_response.body).to include('This is from layout.slim')
      expect(last_response.body).to include('<h2>This is Markdown</h2>')
    end

    it "renders a slim page with layout" do
      get "/dynamic-slim"
      expect(last_response.body).to include('This is from layout.slim')
      expect(last_response.body).to match(/<h2>\s*This is Slim\s*<\/h2>/)
    end
  end
end
