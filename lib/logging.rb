module Logging
  class Logger
    attr_accessor :level
    attr_accessor :buffer

    def initialize(level, buffer)
      @level = level
      @buffer = buffer
    end

    def log(*input)
      formatted_date = Time.now.strftime("%Y-%M-%d %H:%M:%S")

      input.each do |data|
        @buffer << "[#{formatted_date}] #{@level.to_s}: #{data.to_s}"
      end
    end
  end

  class LogLevel
    attr_accessor :value

    def initialize(label, value)
      @label = label
      @value = value
    end

    def to_s
      @label
    end

    def <(other)
      @value < other.value
    end
  end

  module Levels
    DEBUG = LogLevel.new :DEBUG, 1
    INFO = LogLevel.new :INFO, 2
    WARNING = LogLevel.new :WARNING, 3
    ERROR = LogLevel.new :ERROR, 4
    CRITICAL = LogLevel.new :CRITICAL, 5
  end

  private_constant :LogLevel
end