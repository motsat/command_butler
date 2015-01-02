module Copipe
  class CommandObject
    attr_reader :command, :description
    def initialize(vars)
      @command     = vars["command"]
      @description = vars["description"]
    end
  end
end
