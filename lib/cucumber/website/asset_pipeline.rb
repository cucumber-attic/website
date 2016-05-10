require 'sprockets'
require 'sprockets-helpers'
require 'autoprefixer-rails'

module Cucumber
module Website
  module AssetPipeline extend self
    def registered(app)
      app.set :assets, assets = Sprockets::Environment.new(app.settings.root)
      app.set :assets_path, -> { File.join(public_folder, "assets") }
      app.set :assets_precompile, %w(main.js main.css cukeup.js cukeup.css *.png *.jpg *.svg *.eot *.ttf *.woff *.woff2)

      assets.append_path File.join('assets', 'css')
      assets.append_path File.join('assets', 'js')
      assets.append_path File.join('vendor', 'assets', 'bower_components')

      AutoprefixerRails.install(app.assets)

      app.configure :test, :development do
        assets.cache = Sprockets::Cache::FileStore.new('./tmp')
        app.get '/assets/*' do
          env['PATH_INFO'].sub!(%r{^/assets}, '')
          settings.assets.call(env)
        end
      end

      app.configure :production do
        assets.js_compressor  = :uglify
        assets.css_compressor = :sass
      end

      Sprockets::Helpers.configure do |config|
        config.environment = assets
        config.prefix      = '/assets'
        config.debug       = true if app.development?
        if app.production?
          config.digest      = true
          config.manifest    = Sprockets::Manifest.new(assets, File.join(app.assets_path, "manifesto.json"))
        end
      end

      app.helpers Sprockets::Helpers
    end
  end
end
end
