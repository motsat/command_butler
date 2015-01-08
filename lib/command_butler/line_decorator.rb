module CommandButler
  class LineDecorator
    def self.decoration(command:command, index:index, current_index: current_index, history: history)
      mark = if current_index == index
               "\e[33m" +  " > "
             elsif history
                if history[:result]
                  history[:result][:status].success??  "\e[32m" + " o " :  "\e[31m" + " x "
                else
                  "\e[32m" + (history[:input].execute?? " o " : " - ")
                end
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

