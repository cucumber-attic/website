require 'yaml'
require 'pathname'

module Cucumber
  module Website
    module GitHub
      class FileSystemCache
        def initialize(api, config)
          @api = api
          @cache_refresh_interval = config['git_hub']['cache_refresh_interval']
          @cache_path = Pathname.new("cache/git_hub/#{config['env']}.yaml")
        end

        def flush
          File.delete(cache_path) if cache_exist?
        end

        def events
          update_cache_if_needed
          YAML::load(File.read(cache_path))
        end

        attr_reader :api, :cache_path, :cache_refresh_interval
        private :api, :cache_path, :cache_refresh_interval

        private

        def update_cache_if_needed
          unless cache_exist? && cache_valid?
            cache_path.dirname.mkpath
            File.open(cache_path, 'w+') do |file|
              file.write(YAML::dump(api.events))
            end
          end
        end

        def cache_valid?
          File.mtime(cache_path) > Time.now - cache_refresh_interval
        end

        def cache_exist?
          File.exist?(cache_path)
        end
      end
    end
  end
end
