require 'sinatra'
require 'slim'

set :root, File.expand_path(File.dirname(__FILE__) + '/..')

# Automatically set up routes for all views

view_ext = '.slim'
views = Dir["#{settings.views}/**/*#{view_ext}"]
  .map { |file| file[settings.views.length...-view_ext.length] }
  .reject { |view| view =~ /layout$/ }

views.each do |view|
  puts view
  get view do
    slim view.to_sym
  end
  if view == '/index'
    get '/' do
      slim view.to_sym
    end
  end
end
