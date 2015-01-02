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
      commands.each_with_index do |command, index|
        # show all comamnds
        show_commands(commands:commands, current_index: index, inputs: inputs) # 1件実行ごとにコマンドを表示する
        # execute
        if command.need_confirm?
          input = inputs[index] = Input.start
          exit 1 if input.abort?
          next   if input.skip?
          # 出力を行いながら実行するコマンドのためにsystemで実行する
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

