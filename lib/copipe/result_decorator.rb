module Copipe
  class ResultDecorator
    def self.decoration(command:command,index:index, &block)
      puts head = "--  result #{index+1}" + "-" * 40
      yield
      puts "-" * head.length
    end
  end

end
