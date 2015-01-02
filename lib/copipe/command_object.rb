module Copipe
  class CommandObject
    attr_reader :command, :description, :need_confirm, :chdir, :set_val
    def initialize(vars)
      @command      = vars["command"]
      @description  = vars["description"]
      @need_confirm = !vars["need_confirm"]
      @chdir        = vars["chdir"]
      @set_val      = vars["set_val"]
    end

    def replace_command(val:val)
      val.each_pair do |k, v|
        @command.gsub! k, v
      end
    end

    def need_confirm?
      @need_confirm
    end

    def set_val_command?
      !@set_val.nil?
    end

  end
end
