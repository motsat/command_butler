module CommandButler
  class ResultDecorator
    def self.decoration_frame(command:command,index:index, &block)
      puts head = "--  result #{index+1}" + "-" * 40
      yield
      puts "-" * head.length
    end

    def self.decoration_stdout(stdout: stdout)
      puts stdout
    end
    def self.decoration_stderr(stderr: stderr)
      puts "\e[31m" + stderr + "\e[0m"
    end

  end
end
