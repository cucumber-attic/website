require 'sinatra'

module LegacyCukesInfo
  class App < Sinatra::Base
    set root: File.dirname(__FILE__)

    get '/' do
      send_file settings.root + '/public/index.html'
    end
  end
end
