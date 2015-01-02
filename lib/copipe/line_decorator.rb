module Copipe
  class LineDecorator
    def self.decoration(line:line, index:index, current_index: current_index, input: input)
      mark = if current_index == index
               "\e[33m" +  " > "
             elsif input
               "\e[34m" + (input.execute?? " o " : " - ")
             else
               "\e[37m" +  "   "
             end
      ret =  "#{index + 1} " + "["+ mark + "\e[0m" + "]"
      if line.command # コマンド
        ret += " " + line.command
        ret += " (#{line.original_command}) " if line.replaced?
      end
      ret += " <= chdir to #{line.chdir}" if line.chdir # ディレクトリ移動
      ret
    end
  end
end

