module Logging
  module Levels
    DEBUG = 1
    INFO = 2
    WARNING = 3
    ERROR = 4
    CRITICAL = 5
  end

  class Logger
    attr_accessor :level
    attr_accessor :buffer

    def initialize(level, buffer)
      @level = level
      @buffer = buffer
    end

    def log(*input)
      input.each do |data|
        @buffer << data
      end
    end
  end
end
