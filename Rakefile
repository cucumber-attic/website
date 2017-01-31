$: << File.dirname(__FILE__) + '/lib'

ENV["RACK_ENV"] ||= "development"

task default: [:spec, :cucumber]

task :spec do
  sh 'bundle exec rspec'
end

task :cucumber do
  sh 'bundle exec cucumber'
end

namespace :assets do
  require_relative 'apps/static/app'

  App = Cucumber::Website::Static::App

  desc 'Precompile assets'
  task :precompile do
    environment = App.assets
    manifest = Sprockets::Manifest.new(environment.index, File.join(App.assets_path, "manifest.json"))
    manifest.compile(App.assets_precompile)
  end

  desc "Clean assets"
  task :clean do
    FileUtils.rm_rf(App.assets_path)
  end
end
