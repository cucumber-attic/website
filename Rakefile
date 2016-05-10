$: << File.dirname(__FILE__) + '/lib'
require 'rake/tasklib'
require 'rake/sprocketstask'
require_relative 'apps/static/app'

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
  desc 'Precompile assets'
  task :precompile do
    environment = Cucumber::Website::Static::App.assets
    manifest = Sprockets::Manifest.new(environment.index, File.join(Cucumber::Website::Static::App.assets_path, "manifest.json"))
    manifest.compile(Cucumber::Website::Static::App.assets_precompile)
  end

  desc "Clean assets"
  task :clean do
    FileUtils.rm_rf(Cucumber::Website::Static::App.assets_path)
  end
end
