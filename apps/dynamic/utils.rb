module Dynamic
  module Utils
    def front_matter(file)
      if has_yaml_header?(file)
        YAML.load_file(file)
      else
        {}
      end
    end

    def has_yaml_header?(file)
      !!(File.open(file, 'rb') { |f| f.read(5) } =~ /\A---\r?\n/)
    end

    # Lifted from Jekyll::Document
    YAML_FRONT_MATTER_REGEXP = /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m

    def content_after_yaml_header(file)
      content = File.read(file)
      # $' is what follows the match - AKA $POSTMATCH
      content =~ YAML_FRONT_MATTER_REGEXP ? $' : content
    end

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
