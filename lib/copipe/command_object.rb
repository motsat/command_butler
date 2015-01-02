module Copipe
  class CommandObject
    attr_reader :command, :description, :need_confirm, :chdir
    def initialize(vars)
      @command      = vars["command"]
      @description  = vars["description"]
      @need_confirm = !vars["need_confirm"]
      @chdir        = vars["chdir"]
    end

    def need_confirm?
      @need_confirm
    end

  end
end
