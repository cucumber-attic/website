module Cucumber
  module Website
    class UlBuilder
      def initialize(tree, ul="<ul>", &li_proc)
        @tree = tree
        @ul = ul
        @li_proc = li_proc || lambda do |item|
          %Q{<li><a href="#{item[:href]}">#{item[:text]}</a>}
        end
      end

      def build(indent='')
        create_nested_ul(@tree, indent)
      end

      def create_nested_ul(tree, ul_indent)
        s = %Q{#{ul_indent}#{@ul}\n}
        tree.each_with_index do |item, i|
          children = tree[i+1]
          if !(Array === item)
            s += %Q{#{ul_indent}  #{@li_proc.call(item)}\n}
            if Array === children
              s += create_nested_ul(children, ul_indent + '  ')
            end
            s += %Q{#{ul_indent}  </li>\n}
          end
        end
        s + ul_indent + "</ul>\n"
      end
    end
  end
end
