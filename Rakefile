$: << File.dirname(__FILE__) + '/lib'

ENV["RACK_ENV"] ||= "development"

task default: [:spec, :cucumber, :backup_events]

task :spec do
  sh 'bundle exec rspec'
end

task :cucumber do
  sh 'bundle exec cucumber'
end

task :backup_events do
  require 'open-uri'
  require_relative 'lib/cucumber/website/config'
  config = Cucumber::Website::Config.new('development')
  config['calendars'].each do |url|
    file_name = "event-backup/#{Time.now.strftime('%Y%m%d')}-#{url.gsub(/[:\/]/, '-')}"
    file_name += '.ics' unless file_name =~ /\.ics/
    begin
      File.open(file_name, 'w') { |io| io.write(open(url).read) }
    rescue OpenURI::HTTPError => e
      STDERR.puts "\e[31m****** #{url}: #{e.message} ******\e[0m\n"
    end
  end
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
