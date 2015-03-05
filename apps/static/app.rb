module Static
  module App
    def self.new(app)
      Rack::Static.new(app, root: File.dirname(__FILE__) + "/public", urls: ["/fonts"])
    end
  end
end
