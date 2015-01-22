require 'rack/test'

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
    "/blog"
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
end
