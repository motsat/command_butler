module Copipe
  class LineDetailDecorator
    def self.decoration(command:command)
      res = ""
      res += " note: #{command.params["description"]}\n" unless command.params["description"].nil?
      res += " original : #{command.original_command} " if command.replaced?

      command.params.each_pair do |k,v|
        next if %w(chdir description original_command command need_confirm).include? k
        next if v.nil?
        res += " / "if 0 < res.size
        res += " #{k}: #{v.nil?? '-' : v}"
      end
      res = "       " + res if 0 < res.size
      "\e[34m" + res + "\e[0m"
    end
  end
end
