module Copipe
  class LineDecorator
    def self.decoration(command:command, index:index, current_index: current_index, input: input)
      mark = if current_index == index
               "\e[33m" +  " > "
             elsif input
               "\e[34m" + (input.execute?? " o " : " - ")
             else
               "\e[37m" +  "   "
             end
      ret =  "#{index + 1} " + "["+ mark + "\e[0m" + "]"
      if command.command # コマンド
        ret += " " + command.command
        ret += " (#{command.original_command}) " if command.replaced?
      end
      ret += " <= chdir to #{command.chdir}" if command.chdir # ディレクトリ移動
      ret
    end
  end
end

