module CommandButler
  class CommandObject
    attr_reader :command, :description, :need_confirm, :chdir, :set_val, :original_command
    def initialize(vars)
      @original_command  = vars["command"]
      @command           = vars["command"]
      @description       = vars["description"]
      @need_confirm      = !vars["need_confirm"]
      @chdir             = vars["chdir"]
      @set_val           = vars["set_val"]
    end

    def replaced?
      @command && (@command != @original_command)
    end

    def replace_command(val:val)
      return unless @command
      val.each_pair do |k, v|
        @command =  @command.gsub k, v # original_commandと別の参照にするためgsub!は使わない
      end
    end

    # こういうのを文字列で返したい
    # {"original_command"=>"date",
    #   "command"=>"date",
    #   "description"=>nil,
    #   "need_confirm"=>true,
    #   "chdir"=>nil,
    #   "set_val"=>"$DATE_VALUE"}
    def params
      instance_keys = instance_variables.map{|v| v.to_s }
      instance_values = instance_keys.map{|k| instance_variable_get(k) }
      key_and_values_array = [instance_keys.map{|k| k.gsub("@","")}, instance_values].transpose.flatten
      Hash[*key_and_values_array]
    end

    def need_confirm?
      @need_confirm
    end

    def set_val_command?
      !@set_val.nil?
    end

  end
end
