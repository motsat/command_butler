require 'command_butler/command_object'
require 'yaml'
module CommandButler
  class CommandParser
    def self.parse(file_name:file_name)
      YAML.load_file(file_name).map do |y|
        vars = (y.is_a? String)? {"command"=> y} : y
        CommandObject.new(vars)
      end
    end
  end
end
