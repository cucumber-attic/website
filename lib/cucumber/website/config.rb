require 'yaml'
require 'erb'
require_relative 'utils'

module Cucumber
  module Website
    module Config
      extend Utils

      ROOT_PATH = File.dirname(__FILE__) + "/../../../apps/dynamic"

      class << self
        def new(env)
          raise "Environment not defined" unless env
          config = load_yaml(ROOT_PATH + "/_config.yml")
          env_config = load_yaml(ROOT_PATH + "/_config.#{env}.yml")
          deep_merge_hashes(config, env_config)
        end

        def load_yaml(path)
          YAML.load(ERB.new(File.read(path)).result)
        end
      end

    end
  end
end
