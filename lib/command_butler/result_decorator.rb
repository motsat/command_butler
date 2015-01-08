module CommandButler
  class ResultDecorator
    def self.decoration_frame(command:command,index:index, &block)
      puts head = "--  [#{index+1}] " + (command.command || command.chdir) + "-" * 30
      yield
      puts "-" * head.length
    end

    def self.decoration_stdout(stdout: stdout, status:status)
      puts stdout
      puts "\e[32m success status:" + status.to_i.to_s + "\e[0m"
    end

    def self.decoration_stderr(stderr: stderr, status:status)
      puts stderr
      puts "\e[31m error status:" + status.to_i.to_s+ "\e[0m"
    end

  end
end
