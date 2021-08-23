module Conq
  class LogLevel
    include Comparable

    def initialize(label, value)
      @label = label
      @value = value
    end

    def to_s
      @label.to_s
    end

    def <=>(other)
      @value <=> other.value
    end

    protected
    def value
      @value
    end
  end

  module Levels
    DEBUG = LogLevel.new(:DEBUG, 1)
    INFO = LogLevel.new(:INFO, 2)
    WARNING = LogLevel.new(:WARNING, 3)
    ERROR = LogLevel.new(:ERROR, 4)
    CRITICAL = LogLevel.new(:CRITICAL, 5)
  end

  private_constant :LogLevel
end