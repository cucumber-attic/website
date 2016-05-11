require 'sinatra/base'
require 'cucumber/website/config'
require 'cucumber/website/asset_pipeline'

module Cucumber
module Website
module Static
  class App < Sinatra::Application
    set :root, File.dirname(__FILE__)
    register AssetPipeline

    before do
      cache_control :public
    end
  end
end
end
end
