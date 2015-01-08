require 'command_butler/command_parser'
require 'command_butler/val_parser'
require 'command_butler/line_decorator'
require 'command_butler/line_detail_decorator'
require 'command_butler/val_decorator'
require 'command_butler/result_decorator'
require 'command_butler/title_decorator'
require 'command_butler/input'
require 'open3'
module CommandButler
  class Mediator
    def execute(file_name, options)
      # TODO 履歴配列にして、resultsもいれる
      # resultクラスも作る
      histories = []
      @commands = CommandParser.parse(file_name:file_name)

      @vals = {}
      if options[:val_file]
        @vals = ValParser.parse(file_name:options[:val_file])
        @vals.each_pair do |k,v|
          @commands.each {|c| c.replace_command(val:{k=>v})}
        end
      end
      jump_index = -1 # jump制御

      contents = (0 < @vals.size)? ValDecorator.decoration(vals:@vals) : ""
      puts TitleDecorator.decoration(file_name:file_name, contents:contents)

      @commands.each_with_index do |command, index|

        # jumpが設定されていたらskipしたことにする
        if (index < jump_index)
          histories[index] = {input: Input.skip_instance}
          next
        end

        # show all comamnds
        show_commands(current_index: index, histories: histories) # 1件実行ごとにコマンドを表示する
        # execute
        input = command.need_confirm?? Input.start : Input.execute_instance
        exit 1 if input.abort?
        jump_index = (input.input_value - 1) if input.jump?
        histories[index] = {input: input}
        if input.execute? && command.command
          stdout, stderr, status = execute_command(command:command, index:index) 
          histories[index][:result] = {stdout:stdout, stderr: stderr, status: status}
          @commands.each {|c| c.replace_command(val:{command.set_val => stdout})} if command.set_val_command?
        end
      end
    end

    def execute_command(command:command, index:index)
      Dir.chdir(command.chdir) if command.chdir
      return unless command.command

      # set_valコマンドの時は標準出力を取りたいのでopen3で実行
      stdout, stderr, status = "", "", nil
      ResultDecorator.decoration_frame(command: command, index: index) do
        stdout, stderr, status = command.execute
        if status.success?
          ResultDecorator.decoration_stdout  stdout: stdout, status:status
        else
          ResultDecorator.decoration_stderr stderr: stderr, status:status
        end
      end

      sleep 0.5 # 表示がいっきに流れて見失しなうのでsleep
      [stdout, stderr, status]
    end

    def show_commands(current_index:current_index, histories:histories)
      @commands.each_with_index do |command, index|
        puts LineDecorator.decoration command: command, index: index, current_index: current_index, history: histories[index]
        detail = LineDetailDecorator.decoration  command: command
        puts detail if 0 < detail.size
      end
    end

  end
end
