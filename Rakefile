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
  extend Cucumber::Website::Config
  config = load_config('development')
  config['site']['calendars'].each do |url|
    file_name = "event-backup/#{Time.now.strftime('%Y%m%d')}-#{url.gsub(/[:\/]/, '-')}"
    file_name += '.ics' unless file_name =~ /\.ics/
    begin
      File.open(file_name, 'w') { |io| io.write(open(url).read) }
    rescue OpenURI::HTTPError => e
      STDERR.puts "\e[31m****** #{url}: #{e.message} ******\e[0m\n"
    end
  end
end

require 'sinatra/asset_pipeline/task'
require './apps/static/app'
Sinatra::AssetPipeline::Task.define! Cucumber::Website::Static::App
