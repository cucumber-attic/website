require 'pathname'

module Cucumber
  module Website
    module Cache

      def self.wrap(api, name, config, logger)
        path = Path.new(name, config['env'])
        store = FileSystemStore.new(path, config[name]['cache_defaults'] || {})
        if config[name]['cache_refresh_interval']
          start_updating store, api, logger, config[name]['cache_refresh_interval']
        end
        store
      end

      def self.start_updating(store, api, logger, refresh_interval)
        if store.locked?
          logger.debug "Cache at #{store} already locked for updates by another process."
          return store
        end
        store.lock
        logger.info "Starting automatic update of #{store} from #{api}"
        update = Update.new(api, store).call
        PeriodicCall.new(update, refresh_interval, logger).start
        store
      end

      # Updates the store from the given API
      class Update
        def initialize(api, store)
          @api = api
          @store = store
        end

        def call
          (@api.methods - Object.methods).each do |key|
            @store.set(key, @api.send(key))
          end
          self
        end
      end

      module Path
        def self.delete(env)
          FileUtils.rm_rf "cache/#{env}"
        end

        def self.new(name, env)
          "cache/#{env}/#{name}.yaml"
        end
      end

      require 'yaml'
      require 'fileutils'
      # Stores data in a file at the given path
      class FileSystemStore

        def self.register_at_exit_hook(path, &block)
          @paths_with_at_exit_hooks_registered ||= []
          return if @paths_with_at_exit_hooks_registered.include?(path)
          at_exit &block
          @paths_with_at_exit_hooks_registered << path
        end

        def initialize(path, default_data)
          raise ArgumentError unless default_data.is_a?(Hash)
          @cache_path = Pathname.new(path)
          @default_data = default_data
        end

        def to_s
          @cache_path.to_s
        end

        def to_ary
          # FYI: somebody wants this method when we run the tests, we don't know who or why.
        end

        def set(key, value)
          data = read
          data[key.to_s] = value
          write(data)
          self
        end

        def lock
          lock_path.dirname.mkpath unless lock_path.dirname.exist?
          FileUtils.touch lock_path
          self.class.register_at_exit_hook(lock_path) do
            lock_path.delete if lock_path.exist?
          end
          self
        end

        def locked?
          lock_path.exist?
        end

        def method_missing(key)
          if !read.key?(key.to_s) && read == @default_data
            raise("Unable to find key '#{key}' in default cache. Please set this in your configuration.")
          end
          read[key.to_s]
        end

        private

        def lock_path
          Pathname.new("#{@cache_path}.lock")
        end

        def read
          return @default_data unless @cache_path.exist?
          YAML::load(File.read(@cache_path))
        end

        def write(data)
          @cache_path.dirname.mkpath unless @cache_path.dirname.exist?
          File.open(@cache_path, 'w+') do |file|
            file.write(YAML::dump(data))
          end
        end
      end

      # Call the given subject each interval, in a thread.
      # Logs errors to logger
      class PeriodicCall
        def initialize(subject, interval, logger)
          @subject = subject
          @interval = interval
          @logger = logger
        end

        def start
          defer_next_call
          self
        end

        def stop
          @time_to_stop = true
          self
        end

        private

        def defer_next_call
          return if @time_to_stop
          Thread.new do
            sleep @interval
            call_subject
            defer_next_call
          end
        end

        def call_subject
          return if @time_to_stop
          @subject.call
        rescue => error
          @logger.error error
        end
      end

    end
  end
end
