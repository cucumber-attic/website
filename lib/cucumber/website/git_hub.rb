require 'cucumber/website/git_hub/api'
require 'cucumber/website/git_hub/fake'

module Cucumber
  module Website
    module GitHub
      def self.for(config)
        return GitHub::Fake.new if config['env'] == 'test' && !config['git_hub']['token']

        GitHub::API.new(config)
      end
    end
  end
end
