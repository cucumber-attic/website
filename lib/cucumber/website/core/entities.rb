require 'values'

module Cucumber
  module Website
    module Core
      Contributor = Value.new(:avatar_url, :username)
      Community   = Value.new(:contributors, :max_recent_contributors) do
        def recent_contributors
          contributors.uniq.take(max_recent_contributors)
        end
      end
    end
  end
end
