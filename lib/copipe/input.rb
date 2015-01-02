module Copipe
  attr_reader :input_value

  class Input

    module VALUE
      EXECUTE = %w(yes)
      SKIP    = %w(s skip)
      ABORT   = %w(a abort)
    end

    def initialize(input_value:input_value)
      @input_value = input_value
    end

    def self.start
      puts "\nexecute? y or n\n"
      puts "current dir ="  + Dir.pwd
      input_value = STDIN.gets.chomp
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
