module Cucumber
  module Website
    class NestedList
      attr_reader :nested

      def initialize
        @nested = []
        @current = @nested
        @stack = [@nested]
        @level = 0
      end

      def add(level, e)
        if level > @level
          raise "ERROR: Can't transition from #{@level} to #{level}" if level - @level > 1
          down = [e]
          @current.push(down)
          @current = down
          @stack.push(@current)
        elsif level < @level
          (@level - level).times { @stack.pop }
          @current = @stack.last
          @current.push(e)
        elsif level == @level
          @current.push(e)
        end
        @level = level
      end
    end
  end
end
