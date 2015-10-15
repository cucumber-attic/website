require 'yaml'

module Cucumber
  module Website
    module GitHub
      class FileSystemCache
        def initialize(api)
          @api = api
          @cache_path = 'cache/git_hub'
        end

        def flush
          File.delete(cache_path) if cache_exist?
        end

        def events
          update_cache_if_needed
          YAML::load(File.read(cache_path))
        end

        def events=(events)
          api.events = events
        end

        attr_reader :api, :cache_path
        private :api, :cache_path

        def update_cache_if_needed
          unless cache_exist?
            File.open(cache_path, 'w+') do |file|
              file.write(YAML::dump(api.events))
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
