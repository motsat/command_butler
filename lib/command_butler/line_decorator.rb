module CommandButler
  class LineDecorator
    def self.decoration(command:command, index:index, current_index: current_index, input: input)
      mark = if current_index == index
               "\e[33m" +  " > "
             elsif input
               "\e[32m" + (input.execute?? " o " : " - ")
             else
               "\e[37m" +  "   "
             end
      ret =  "#{index + 1} " + "["+ mark + "\e[0m" + "]"
      if command.command # コマンド
        ret += " " + command.command
      else
        ret += " - "
      end
      ret += " <= chdir to #{command.chdir}" if command.chdir # ディレクトリ移動
      ret
    end
  end
end

