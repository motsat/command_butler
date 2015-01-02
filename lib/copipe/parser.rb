require 'copipe/command_object'
module Copipe
  class Parser
    def self.parse_with_file(file_name:file_name)
      YAML.load_file(file_name).map do |y|
        vars = (y.is_a? String)? {"command"=> y} : y
        CommandObject.new(vars)
      end
    end
  end
end
