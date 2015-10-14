require 'values'

module Cucumber
  module Website
    module Core
      class Community < Value.new(:config, :contributors)
        def recent_contributors
          contributors.take(max_recent_contributors)
        end

        def max_recent_contributors
          config['community']['max_recent_contributors']
        end
      end
    end
  end
end
