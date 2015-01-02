require 'copipe/parser'
require 'copipe/line_decorator'
require 'copipe/input'
require 'copipe/mediator'
require 'yaml'
module Copipe
  class Executer < Thor
    # default_task :execute
    desc :filename, "commands list file"
    def execute(file_name)
      Mediator.new.execute(file_name)
    end
  end
end

