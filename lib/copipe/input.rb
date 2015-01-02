module Copipe

  class Input
    attr_reader :input_value
    module VALUE
      EXECUTE = %w(y yes)
      SKIP    = %w(s skip)
      ABORT   = %w(a abort)
    end

    def initialize(input_value:input_value)
      @input_value = input_value
    end

    def self.constant_inputs?(input_value)
      VALUE.constants.map{|c| VALUE.const_get(c)}.flatten.include? input_value
    end

    def self.skip_instance
      self.new(input_value:VALUE::SKIP)
    end

    def self.execute_instance
      self.new(input_value:VALUE::EXECUTE)
    end

    def self.start
      while(true)
        puts "\nexecute: y or Enter (no: no or n / abort: abort or a)\n"
        puts "current dir ="  + Dir.pwd
        input_value = STDIN.gets.chomp
        input_value = 'y' if input_value == "" # エンターの実行はyと同じにする
        return self.new(input_value:input_value) if constant_inputs? input_value
        return self.new(input_value:input_value.to_i) if input_value.to_i.nonzero? # jumpコマンド
        raise 'unknown command'
      end
    end

    def jump?
      @input_value.is_a? Integer
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
