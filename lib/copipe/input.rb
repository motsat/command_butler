module Copipe

  class Input
    attr_reader :input_value
    module VALUE
      EXECUTE = %w(y yes)
      SKIP    = %w(s skip n no)
      ABORT   = %w(a abort q quit)
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
        puts "[#{Dir.pwd}] $ execute Enter (no: n, quit: q, jump : command-number, skip : s)\n"
        input_value = STDIN.gets.chomp
        input_value = 'y' if input_value == "" # エンターの実行はyと同じにする
        return self.new(input_value:input_value) if constant_inputs? input_value
        return self.new(input_value:input_value.to_i) if input_value.to_i.nonzero? # jumpコマンド
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
