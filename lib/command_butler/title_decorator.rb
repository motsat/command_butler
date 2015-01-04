module CommandButler
  class TitleDecorator
    def self.decoration(file_name:file_name, contents:contents)
      res = ""
      head = "--- start" + ("-"  * 40) + "\n"
      res += head
      res += contents + "\n"
      res += "-" * (head.length - 1)
      res
    end
  end

end
