require 'command_butler/command_object'
require 'yaml'
module CommandButler
  class ValParser
    def self.parse(file_name:file_name)
      # 今のとここれだけだが
      YAML.load_file(file_name)
    end
  end
end
