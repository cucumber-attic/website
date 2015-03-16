require_relative 'utils'

module Dynamic
  module Config
    include Utils

    def load_config(env)
      config = {
        'site' => YAML.load_file(File.dirname(__FILE__) + "/_config.yml")
      }

      env_config = {
        'site' => YAML.load_file(File.dirname(__FILE__) + "/_config.#{env}.yml")
      }

      deep_merge_hashes(config, env_config)
    end
  end
end
