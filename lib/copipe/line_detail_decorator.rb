module Copipe
  class LineDetailDecorator
    def self.decoration(command:command)
      res = ""
      res += "- #{command.params["description"]}\n" unless command.params["description"].nil?

      command.params.each_pair do |k,v|
        next if %w(chdir description original_command command need_confirm).include? k
        next if v.nil?
        res += " / "if 0 < res.size
        res += "#{k}: #{v.nil?? '-' : v}"
      end
      "       " + res
    end
  end
end
