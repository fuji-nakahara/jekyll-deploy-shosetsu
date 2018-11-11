module JekyllDeployShosetsu
  module Util
    class << self
      def append_yaml_front_matter(path, yaml)
        content     = File.read(path)
        config      = content[Jekyll::Document::YAML_FRONT_MATTER_REGEXP, 1]
        new_config  = config + yaml
        new_content = content.gsub(config, new_config)
        File.write(path, new_content)
      end
    end
  end
end
