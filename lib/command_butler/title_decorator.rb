module CommandButler
  class TitleDecorator
    def self.decoration(file_name:file_name)
      puts head = "--- start" + ("-"  * 40)
      puts " file_name: #{file_name}"
      puts "-" * head.length
    end
  end

end
