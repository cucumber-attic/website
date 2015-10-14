module Cucumber
  module Website
    module GitHub
      class FileSystemCache
        def initialize(api)
          @api = api
        end

        def flush
        end

        def events
          @events ||= api.events
        end

        attr_reader :api
        private :api
      end
    end
  end
end
