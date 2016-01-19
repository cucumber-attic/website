require 'sass'
require 'sinatra/base'
require 'sinatra/asset_pipeline'
require 'uglifier'
require 'autoprefixer-rails'
require 'cucumber/website/config'

module Cucumber
module Website
module Static
  class App < Sinatra::Application
    set :root,  File.dirname(__FILE__)

    set :assets_precompile, %w(main.js main.css cukeup.js cukeup.css *.png *.jpg *.svg *.eot *.ttf *.woff *.woff2)
    set :assets_css_compressor, :sass
    set :assets_js_compressor, :uglifier

    register Sinatra::AssetPipeline
    AutoprefixerRails.install(sprockets)

    before do
      cache_control :public
    end
  end
end
end
end
