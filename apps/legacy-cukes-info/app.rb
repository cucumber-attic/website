require 'sinatra'

module LegacyCukesInfo
  class App < Sinatra::Base
    set root: File.dirname(__FILE__)

    get '/legacy-index' do
      send_file settings.root + '/public/legacy-index.html'
    end
  end
end
