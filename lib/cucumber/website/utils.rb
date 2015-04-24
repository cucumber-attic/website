module Cucumber
  module Website
    module Utils
      # Lifted from
      # http://gemjack.com/gems/tartan-0.1.1/classes/Hash.html
      #
      # Thanks to whoever made it.
      def deep_merge_hashes(master_hash, other_hash)
        target = master_hash.dup

        other_hash.each_key do |key|
          if other_hash[key].is_a? Hash and target[key].is_a? Hash
            target[key] = deep_merge_hashes(target[key], other_hash[key])
            next
          end

          target[key] = other_hash[key]
        end

        target
      end

      def constantize(class_name)
        unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ class_name
          raise NameError, "#{class_name.inspect} is not a valid constant name!"
        end

        Object.module_eval("::#{$1}", __FILE__, __LINE__)
      end
    end
  end
end
