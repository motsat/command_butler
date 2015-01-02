require 'copipe/parser'
require 'copipe/line_decorator'
require 'copipe/input'
require 'yaml'
module Copipe
  class Executer < Thor
    # default_task :execute
    desc :filename, "commands list file"
    def execute(file_name)
      commands = Parser.parse_with_file(file_name:file_name)
      commands.each_with_index do |command, index|
        # show all comamnds
        show_commands(commands:commands, current_index: index) # 1件実行ごとにコマンドを表示する
        # execute
        input = Input.start
        if input.execute?
          `#{command}`
        elsif input.skip?
          puts "skipped"
        elsif input.abort?
          exit 1
        else
        end
      end
    end


    def show_commands(commands:commands, current_index:current_index)
      commands.each_with_index do |command, index|
        puts LineDecorator.decoration line:command, index:index, current_index: current_index
      end
    end

  end
end

