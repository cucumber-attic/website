module Cucumber
  module Website
    module GitHub
      class FileSystemCache
        def initialize(api)
          @api = api
          @cache_path = "cache/git_hub"
        end

        def flush
          File.delete(cache_path) if cache_exist?
        end

        def events
          update_cache_if_needed
          File.read(cache_path)
        end

        attr_reader :api, :cache_path
        private :api, :cache_path

        def update_cache_if_needed
          if !cache_exist? || File.zero?(cache_path)
            File.open(cache_path, "w+") do |file|
              file.write(api.events)
            end
          end
        end

        def cache_exist?
          File.exist?(cache_path)
        end
      end
    end
  end
end
