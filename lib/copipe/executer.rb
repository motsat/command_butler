require 'copipe/parser'
require 'copipe/line_decorator'
require 'copipe/input'
require 'yaml'
module Copipe
  class Executer < Thor
    # default_task :execute
    desc :filename, "commands list file"
    def execute(file_name)

      inputs = {}
      commands = Parser.parse_with_file(file_name:file_name)

      jump_index = -1 # jump制御

      commands.each_with_index do |command, index|

        # jumpが設定されていたらskipしたことにする
        if (index < jump_index)
          inputs[index] = Input.skip_instance
          next
        end

        # show all comamnds
        show_commands(commands:commands, current_index: index, inputs: inputs) # 1件実行ごとにコマンドを表示する
        # execute
        input = command.need_confirm?? Input.start : Input.execute_instance
        if input.abort?
          exit 1
        elsif input.jump?
          jump_index = (input.input_value - 1)
        end
        inputs[index] = input
        if input.execute?
          Dir.chdir(command.chdir) if command.chdir
          system command.command   if command.command
        end
      end
    end

    def show_commands(commands:commands, current_index:current_index, inputs:inputs)
      commands.each_with_index do |command, index|
        puts LineDecorator.decoration line:command, index:index, current_index: current_index, input: inputs[index]
      end
    end

  end
end

