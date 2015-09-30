require 'yaml'
require_relative 'utils'

module Cucumber
  module Website
    module Config
      extend Utils

      def self.new(env)
        raise "Environment not defined" unless env
        config = YAML.load_file(File.dirname(__FILE__) + "/../../../apps/dynamic/_config.yml")
        env_config = YAML.load_file(File.dirname(__FILE__) + "/../../../apps/dynamic/_config.#{env}.yml")
        deep_merge_hashes(config, env_config)
      end
    end
  end
end
