module Copipe
  class Mediator
    def execute(file_name)
      inputs = {}
      @commands = Parser.parse_with_file(file_name:file_name)
      #@replaced = replaced

      jump_index = -1 # jump制御

      @commands.each_with_index do |command, index|

        # jumpが設定されていたらskipしたことにする
        if (index < jump_index)
          inputs[index] = Input.skip_instance
          next
        end

        # show all comamnds
        show_commands(current_index: index, inputs: inputs) # 1件実行ごとにコマンドを表示する
        # execute
        input = command.need_confirm?? Input.start : Input.execute_instance
        exit 1 if input.abort?
        jump_index = (input.input_value - 1) if input.jump?
        inputs[index] = input
        if input.execute?
          res = execute_command(command:command) 
          @commands.each {|c| c.replace_command(val:res[:set_val])} if res[:set_val]
        end
      end
    end

    def execute_command(command:command)
      res = {set_val:nil}
      Dir.chdir(command.chdir) if command.chdir
      return  res unless command.command
      # set_valコマンドの時は標準出力を取りたいのでバッククオート実行
      # その他は、都度出力されるものを表示したいのでsystemで実行
      if command.set_val_command?
        val = `#{command.command}`.chomp
        res[:set_val] = {command.set_val => val}
      else
        system command.command
      end
      res
    end

    def show_commands(current_index:current_index, inputs:inputs)
      @commands.each_with_index do |command, index|
        puts LineDecorator.decoration line:command, index:index, current_index: current_index, input: inputs[index]
      end
    end

  end
end
