module Copipe
  attr_reader :input_value

  class Input

    module VALUE
      EXECUTE = %w(y yes)
      SKIP    = %w(s skip)
      ABORT   = %w(a abort)
    end

    def initialize(input_value:input_value)
      @input_value = input_value
    end

    def self.start
      puts "\nexecute: y or Enter (no: no or n / abort: abort or a)\n"
      puts "current dir ="  + Dir.pwd
      input_value = STDIN.gets.chomp
      input_value = 'y' if input_value == "" # エンターの実行はyと同じにする
      self.new(input_value:input_value)
    end

    def execute?
      (VALUE::EXECUTE).include? @input_value
    end

    def skip?
      (VALUE::SKIP).include? @input_value
    end

    def abort?
      (VALUE::ABORT).include? @input_value
    end
  end
end
