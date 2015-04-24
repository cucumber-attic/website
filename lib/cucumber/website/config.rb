require 'yaml'
require_relative 'utils'

module Cucumber
  module Website
    module Config
      include Utils

      def load_config(env)
        config = {
          'site' => YAML.load_file(File.dirname(__FILE__) + "/../../../apps/dynamic/_config.yml")
        }

        env_config = {
          'site' => YAML.load_file(File.dirname(__FILE__) + "/../../../apps/dynamic/_config.#{env}.yml")
        }

        deep_merge_hashes(config, env_config)
      end
    end
  end
end
