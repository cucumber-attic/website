module Cucumber
  module Website
    module GitHub

      class Fake
        attr_accessor :events

        def initialize
          @events = []
        end

        def methods
          [:events]
        end
      end
    end

  end
end
